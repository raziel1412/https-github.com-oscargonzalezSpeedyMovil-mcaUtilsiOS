//
//  SessionSingleton.swift
//  MiClaro
//
//  Created by Roberto Gutierrez Resendiz on 04/08/17.
//  Copyright © 2017 am. All rights reserved.
//

import UIKit
import Crashlytics
import ObjectMapper
import ReachabilitySwift

class SessionSingleton {
    static let sharedInstance = SessionSingleton();

    var reachability : Reachability?
    private var ipAddress : String?
    private var currentTab : String?
    private var planCards : [[PlanCard]]?
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate;
    private var serviceBeingConsumed : Bool?
    private var refreshConfigWorker : DispatchWorkItem?;
    private var canUpdateApp : Bool?
    private var isUpdateAppAvailable: Bool?
    private var actionType: Int?
    private var isDigitalBirth: Bool?
    private var userProfileID:  String?

    private init() {
        self.reachability = Reachability();
        self.serviceBeingConsumed = false;
    }

    func isConsumingService(state : Bool) {
        self.serviceBeingConsumed = state;
    }

    func isConsumingService() -> Bool {
        return self.serviceBeingConsumed ?? false;
    }

    private func setConfigFileLifeTime(tiempo : String?) {
        let nombre = "ConfigFileLifeTime";
        if let objectData = tiempo {
            UserDefaults.standard.set(objectData, forKey: nombre);
            UserDefaults.standard.synchronize();
        } else {
            UserDefaults.standard.removeObject(forKey: nombre);
            UserDefaults.standard.synchronize();
        }
    }

    private func getConfigFileLifeTime() -> Int {
        let nombre = "ConfigFileLifeTime";
        guard let str = UserDefaults.standard.value(forKey: nombre) as? String else {
            if let time = Int(SessionSingleton().getGeneralConfig()?.config?.configFileLifeTime ?? "86400") {
                return time
            }
            return 86400
        }
        let tiempo = NSString(format: "%@", str);
        
        return tiempo.integerValue;
    }

    func isExpiredTime() -> Bool {
        if let last = self.getLastConfigDate() {
            let elapsedTime = abs(Date().timeIntervalSince(last))
            let maxTime = getConfigFileLifeTime();
            return (elapsedTime > TimeInterval(maxTime))
        } else {
            return true;
        }
    }

    func isNetworkConnected() -> Bool {
        let connected = self.reachability?.isReachable ?? true;

        return connected;
    }

    func setCountryList(list : [CountryListResponse]?) {
        let nombre = String(describing: CountryListResponse.self);
        guard let data = list else {
            UserDefaults.standard.removeObject(forKey: nombre);
            UserDefaults.standard.synchronize();
            return;
        }

        if let objectData = Mapper().toJSONString(data) {
            UserDefaults.standard.set(objectData, forKey: nombre);
            self.setLastConfigDate(fecha: Date());
            UserDefaults.standard.synchronize();
        } else {
            UserDefaults.standard.removeObject(forKey: nombre);
            UserDefaults.standard.synchronize();
        }
    }

    func setCurrentCountry(country : String?) {
        let nombre = "CurrentCountry";

        if let objectData = country {
            UserDefaults.standard.set(objectData, forKey: nombre);
            UserDefaults.standard.synchronize()
        } else {
            UserDefaults.standard.removeObject(forKey: nombre);
            UserDefaults.standard.synchronize();
        }
    }

    func getCurrentCountry() -> String? {
        let nombre = "CurrentCountry";
        guard let str = UserDefaults.standard.value(forKey: nombre) as? String else {
            return nil
        }

        return str;
    }

    func getCountryList() -> [CountryListResponse]? {

        let nombre = String(describing: CountryListResponse.self);
        guard let str = UserDefaults.standard.value(forKey: nombre) as? String else {
            return nil
        }

        guard let json = Mapper<CountryListResponse>().mapArray(JSONString: str) else {
            return nil;
        }

        return json;
    }

    private func setLastConfigDate(fecha : Date? = nil) {
        let nombre = String(describing: GeneralConfig.self);
        let nombre_last = String(format: "%@_last", nombre);

        if let objectData = fecha {
            UserDefaults.standard.set(objectData, forKey: nombre_last);
            UserDefaults.standard.synchronize()
        } else {
            UserDefaults.standard.removeObject(forKey: nombre_last);
            UserDefaults.standard.synchronize();
        }

        let worker = DispatchWorkItem {
            NotificationCenter.default.post(name: Observers.ObserverList.RefreshConfigurationFile.name,
                                            object: nil);
        }

        DispatchQueue.main.asyncAfter(deadline: SessionSingleton.sharedInstance.getExpiration(), execute: worker);
        SessionSingleton.sharedInstance.setRefreshConfigWorker(worker: worker);
    }

    private func getLastConfigDate() -> Date?{
        let nombre = String(describing: GeneralConfig.self);
        let nombre_last = String(format: "%@_last", nombre);
        guard let dt = UserDefaults.standard.value(forKey: nombre_last) as? Date else {
            return nil;
        }

        return dt;
    }

    func getExpiration() -> DispatchTime {
        let tol = self.getConfigFileLifeTime();
        let inicio = self.getLastConfigDate();
        let fin = inicio?.addingTimeInterval(TimeInterval(tol));
        let offset = (fin?.timeIntervalSince(Date()) ?? 0);
        let restante : DispatchTime = DispatchTime.now() + (offset < 0 ? 0 : offset);

        return restante;
    }

    func setRefreshConfigWorker(worker : DispatchWorkItem?) {
        if (nil == worker) {
            self.refreshConfigWorker?.cancel();
        }

        self.refreshConfigWorker = worker;
    }

    func getRefreshConfigWorker() -> DispatchWorkItem? {
        return self.refreshConfigWorker;
    }

    func setGeneralConfig(config : GeneralConfig?) {
        let nombre = String(describing: GeneralConfig.self);

        if let objectData = config?.toJSONString() {
            Crashlytics.sharedInstance().setObjectValue(objectData, forKey: nombre);
            UserDefaults.standard.set(objectData, forKey: nombre);
            self.setConfigFileLifeTime(tiempo: config?.config?.configFileLifeTime);
            self.setLastConfigDate(fecha: Date())
            UserDefaults.standard.synchronize()
        } else {
            Crashlytics.sharedInstance().setObjectValue(nil, forKey: nombre);
            UserDefaults.standard.removeObject(forKey: nombre);
            UserDefaults.standard.synchronize();
        }
    }

    func getGeneralConfig() -> GeneralConfig? {

        let nombre = String(describing: GeneralConfig.self);
        guard let str = UserDefaults.standard.value(forKey: nombre) as? String else {
            Crashlytics.sharedInstance().setObjectValue(nil, forKey: nombre);
            return nil;
        }

        guard let json = GeneralConfig(JSONString: str) else {
            Crashlytics.sharedInstance().setObjectValue(nil, forKey: nombre);
            return nil;
        }

        Crashlytics.sharedInstance().setObjectValue(str, forKey: nombre)
        return json;
    }

    func getCurrentSession() -> RetrieveProfileInformationResult? {
        let rpi = WebServicesWithObjects.getLastResponseFromService(service: ServiceEndpoint.RetrieveProfileInformation, ofType: RetrieveProfileInformationResult.self);

        if let pdi = rpi?.retrieveProfileInformationResponse?.personalDetailsInformation {
            let username = String(format: "%@ %@ %@", pdi.accountUserFirstName ?? "", pdi.accountUserLastName ?? "", pdi.accountUserSecondLastName ?? "");
            let email = rpi?.retrieveProfileInformationResponse?.contactMethods?.first?.emailContactMethodDetail?.emailAddress ?? ""
            Crashlytics.sharedInstance().setUserIdentifier(pdi.rUT);
            Crashlytics.sharedInstance().setUserName(username);
            Crashlytics.sharedInstance().setUserEmail(email);
        } else {
            Crashlytics.sharedInstance().setUserIdentifier("");
            Crashlytics.sharedInstance().setUserName("");
            Crashlytics.sharedInstance().setUserEmail("");
        }

        return rpi;
    }

    func setFullAccountData(account : [ServiceAccount]?) {
        let nombre = String(describing: ServiceAccount.self);
        guard let data = account else {
            UserDefaults.standard.set("", forKey: nombre);
            UserDefaults.standard.removeObject(forKey: nombre)
            UserDefaults.standard.synchronize()
            return;
        }

        if let objectData = Mapper().toJSONString(data) {
            Crashlytics.sharedInstance().setObjectValue(objectData, forKey: "CardsData");
            UserDefaults.standard.set(objectData, forKey: nombre);
            UserDefaults.standard.synchronize()
        } else {
            Crashlytics.sharedInstance().setObjectValue(nil, forKey: "CardsData");
            UserDefaults.standard.removeObject(forKey: nombre)
            UserDefaults.standard.synchronize()
        }
    }

    func getFullAccountData() -> [ServiceAccount]? {
        let nombre = String(describing: ServiceAccount.self);
        guard let str = UserDefaults.standard.value(forKey: nombre) as? String else {
            return nil
        }

        guard let json = Mapper<ServiceAccount>().mapArray(JSONString: str) else {
            return nil;
        }

        return json;
    }

    func setCurrentTab(tabName : String) {
        self.currentTab = tabName.uppercased()
    }

    func getCurrentTab() -> String {
        return self.currentTab?.uppercased() ?? "";
    }

    func setPlanCards(planCards : [[PlanCard]]?) {
        self.planCards = planCards;
    }

    func getPlanCards() -> [[PlanCard]]? {
        return self.planCards;
    }

    func setLastRefreshDate(fecha : Date?) {
        let nombre = "LastRefreshDate"
        guard let data = fecha else {
            UserDefaults.standard.removeObject(forKey: nombre)
            UserDefaults.standard.synchronize()
            return;
        }

        UserDefaults.standard.set(data, forKey: nombre);
        UserDefaults.standard.synchronize()
    }

    func getLastRefreshDate() -> Date? {
        let nombre = "LastRefreshDate"

        guard let dt = UserDefaults.standard.value(forKey: nombre) as? Date else {
            return nil;
        }

        return dt;
    }

    func setIpAddress(newIpAddress : String?) {
        let nombre = "MyIpAddress"
        guard let data = newIpAddress else {
            UserDefaults.standard.removeObject(forKey: nombre)
            UserDefaults.standard.synchronize()
            return;
        }

        UserDefaults.standard.set(data, forKey: nombre);
        UserDefaults.standard.synchronize()
    }

    func getIpAddress() -> String? {
        let nombre = "MyIpAddress"

        guard let ip = UserDefaults.standard.value(forKey: nombre) as? String else {
            return nil;
        }

        return ip;
    }

    func getAmountSeparator() -> String {
        var listaPaisesPunto = [String]();
        var listaPaisesComa = [String]();

        listaPaisesPunto.append("CL");
        listaPaisesPunto.append("AR");
        listaPaisesPunto.append("BR");
        listaPaisesPunto.append("CO");
        listaPaisesPunto.append("CR");
        listaPaisesPunto.append("EC");
        listaPaisesPunto.append("PA");
        listaPaisesPunto.append("PY");
        listaPaisesPunto.append("PE");
        listaPaisesPunto.append("UY");
        listaPaisesComa.append("DO");
        listaPaisesComa.append("GT");
        listaPaisesComa.append("HN");
        listaPaisesComa.append("NI");
        listaPaisesComa.append("PR");
        listaPaisesComa.append("SV");

        let pais = self.getGeneralConfig()!.country!.code!.uppercased()
        if (listaPaisesPunto.first(where: {$0 == pais})?.count ?? 0) > 0{
            return ".";
        } else if (listaPaisesComa.first(where: {$0 == pais})?.count ?? 0) > 0 {
            return ",";
        } else {
            return "";
        }
    }

    func shouldRefresh() -> Bool {
        if let last = SessionSingleton.sharedInstance.getLastRefreshDate() {
            let elapsedTime = abs(Date().timeIntervalSince(last))
            guard let maxTime = SessionSingleton.sharedInstance.getGeneralConfig()?.cachedServices?.initServicesCache else {
                return false;
            }
            return elapsedTime > TimeInterval(maxTime)
        } else {
            if nil == SessionSingleton.sharedInstance.getLastRefreshDate() {
                SessionSingleton.sharedInstance.setLastRefreshDate(fecha: Date());
            }
            return false;
        }
    }
    
    func setUserOnlyPrepaidAccount(onlyPrepaid : Bool) {
        let nombre = "onlyPrepaidAccount";
        
        let objectData = onlyPrepaid 
            UserDefaults.standard.set(objectData, forKey: nombre);
            UserDefaults.standard.synchronize()
        /*} else {
            UserDefaults.standard.removeObject(forKey: nombre);
            UserDefaults.standard.synchronize();
        }*/
    }
    
    func getUserOnlyPrepaidAccount() -> Bool {
        let nombre = "onlyPrepaidAccount";
        guard let prepaid = UserDefaults.standard.value(forKey: nombre) as? Bool else {
            return false
        }
        
        return prepaid;
    }
    
    func setActionType(type: Int?) {
        let nombre = "actionType"
        UserDefaults.standard.set(type, forKey: nombre);
        UserDefaults.standard.synchronize()
    }
    
    func getActionType() -> Int? {
        let nombre = "actionType";
        guard let actionType = UserDefaults.standard.value(forKey: nombre) as? Int else {
            return nil
        }
        
        return actionType
    }
    
    func setIsDigitalBirth(isDigital: Bool?) {
        let nombre = "isDigitalBirth"
        UserDefaults.standard.set(isDigital, forKey: nombre);
        UserDefaults.standard.synchronize()
    }
    
    func getDigitalBirth() -> Bool? {
        let nombre = "isDigitalBirth";
        guard let digital = UserDefaults.standard.value(forKey: nombre) as? Bool else {
            return false
        }
        
        return digital
    }
    
    func setUserProfileID(userProfileID: String?) {
        let name = "userProfileID"
        UserDefaults.standard.set(userProfileID, forKey: name)
        UserDefaults.standard.synchronize()
    }
    
    func removeUserProfileID() {
        let name = "userProfileID"
        UserDefaults.standard.removeObject(forKey: name)
        UserDefaults.standard.synchronize()
    }
    
    func getUserProfileID() -> String? {
        let name = "userProfileID"
        guard let user = UserDefaults.standard.value(forKey: name) as? String else {
            return ""
        }
        return user
    }
    
    func getNameImagePerfil() -> String{
        if ((self.getCurrentSession()?.retrieveProfileInformationResponse?.personalDetailsInformation?.rUT) != nil){
            let nameNumber = self.getCurrentSession()?.retrieveProfileInformationResponse?.personalDetailsInformation?.rUT
            return  (nameNumber?.enmascararRut().maskedString)! + "FotoPerfil.png"
        }
      return ""
    }
    
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    func checkImageExists(fileName: String) -> Bool{
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let url = URL(fileURLWithPath: path)
        
        let filePath = url.appendingPathComponent(fileName).path
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: filePath) {
            print("FILE AVAILABLE")
            return true
        } else {
            print("FILE NOT AVAILABLE")
        }
        return false
    }
    
    func setCanUpdateApp(canUpdateApp : Bool?) {
        let nombre = "canUpdateApp"
        guard let data = canUpdateApp else {
            UserDefaults.standard.removeObject(forKey: nombre)
            UserDefaults.standard.synchronize()
            return;
        }
        
        UserDefaults.standard.set(data, forKey: nombre);
        UserDefaults.standard.synchronize()
    }
    
    func getCanUpdateApp() -> Bool! {
        let nombre = "canUpdateApp"
        
        guard let flag = UserDefaults.standard.value(forKey: nombre) as? Bool else {
            return false;
        }
        
        return flag;
    }
    
    func setIsUpdateAppAvailable(isUpdateAppAvailable : Bool?) {
        let nombre = "isUpdateAppAvailable"
        guard let data = isUpdateAppAvailable else {
            UserDefaults.standard.removeObject(forKey: nombre)
            UserDefaults.standard.synchronize()
            return;
        }
        
        UserDefaults.standard.set(data, forKey: nombre);
        UserDefaults.standard.synchronize()
    }
    
    
    func getIsUpdateAppAvailable() -> Bool! {
        let nombre = "isUpdateAppAvailable"
        
        guard let flag = UserDefaults.standard.value(forKey: nombre) as? Bool else {
            return false;
        }
        
        return flag;
    }


}
