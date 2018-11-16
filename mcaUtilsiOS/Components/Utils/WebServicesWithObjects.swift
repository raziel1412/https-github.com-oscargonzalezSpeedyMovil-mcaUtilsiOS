//
//  WebServicesWithObjects.swift
//  MiClaro
//
//  Created by Roberto Gutierrez Resendiz on 10/08/17.
//  Copyright © 2017 am. All rights reserved.
//

import UIKit
import CoreData
import Crashlytics
import ObjectMapper
import IBMMobileFirstPlatformFoundation

/// Enumerado de los Endpoints
enum ServiceEndpoint : String {
    
    case Configuration // 00
    case RetrievePersonalVerificationQuestions // 01
    case ValidatePersonalVerificationQuestions // 02
    case SendNotification // 03
    case CreateNewRegister // 04
    case GetTempPassword // 05
    case RetrieveProfileInformation // 06
    case UpdatePassword // 07
    case UpdateProfileInformation // 08
    case UpdateTransactionPasswordAttempts // 09
    case ValidateTempPassword // 10
    case ValidateTransactionPasswordAttempts // 11
    case RetrievePromotions // 12
    case RetrievePlans // 13
    case ValidateNumber // 14
    case RetrieveAccountDetails // 15
    case RetrieveAccountList // 16
    case RetrieveAssociatedAccounts // 17
    case RetrieveBillDetails // 18
    case RetrieveBillHistoryList // 19
    case RetrieveElectronicDocumentPDF // 20
    case SendBillNotification // 21
    case GetPaperless // 22
    case SetPaperless // 23
    case RetrieveConsumptionDetailInformation // 24
    case RetrieveRechargeOptions // 26
    case RetrieveVASDetails // 27
    case SwitchPlan // 28
    case RetrieveSwitchPlanImplications // 29
    case IdentityLogin // 30
    case ValidateCredentials // 31
    case UpdatePasswordEditProfile // 32
    case AssociateAccount // 33
    case CountryList  // 34

    case retrieveCycleInformation // 38
    case RetrievePortalUser // 39
    case UpdatePortalUser // 40
    case RetrievePlanTicketHistory // 41
    case CreateChangePlanTicket // 42

    case IdentifyUserLoB // 43
    case VerifyAssociationToUserId // 44
    case ValidateRut // 45
    //Suscripcion
    case AddSMSPremiumToBlackList // 46
    case RemoveSMSPremiumFromBlackList // 47
    case RetrieveSMSPremiumBlackListStatus // 48
    case RetrieveSMSPremiumHistory // 49
    case RetrieveSMSPremiumSubscriptions // 50
    case UnsubscribeSMSPremium // 51
    //Bolsas
    case RetrievePackageList // 52
    case AddNewPackage // 53
    //Activación de Canales Premium
    case UpdateChannelStatus // 54
    case RetrieveChannelsOffer // 55
}

/// Enumerado de los Adapters
#if PRODUCCION
private enum ServiceAdapter : String {
    case NO_Adapter
    case MC_CustomerManagementAdapter
    case MC_NotificationManagementAdapter
    case MC_IdentityManagementAdapter
    case MC_BussinesAnalyticsManagementAdapter
    case MC_AccountManagementAdapter
    case MC_AccountManagementAdapter_JB
    case MC_BillingManagementAdapter
    case MC_ServiceManagementAdapter
    case MC_IdentityLoginAdapter
    case NO_AdapterContryList
}
#else
private enum ServiceAdapter : String {
    case NO_Adapter
    case MC_CustomerManagementAdapter_1_7
    case MC_NotificationManagementAdapter_1_7
    case MC_IdentityManagementAdapter_1_7
    case MC_BussinesAnalyticsManagementAdapter_1_7
    case MC_AccountManagementAdapter_1_7
    case MC_BillingManagementAdapter_1_7
    case MC_ServiceManagementAdapter_1_7
    case MC_IdentityLoginAdapter_1_7
    case NO_AdapterCountryList
    case MC_ServiceManagementAdapter_1_9

}
#endif

/// Enumerado ResultState
private enum ResultState : String {
    case SUCCESS
}
/// Enumerado de http methods
enum ServiceMethod : String {
    case POST
    case GET
}
/// Enumerado de los Tipos de Resultados
enum ResultType : String {
    case OnlineResult
    case CachedResult
    case EmptyDataSetResult
}
/// Protocolo localización - internacionalización
protocol ServiceErrorProtocol: Error {
    var localizedTitle: String { get }
    var localizedDescription: String { get }
    var code: Int { get }
}
/// Clase para realizar llamados a los endpoints
class WebServicesWithObjects : NSObject {
    #if PRODUCCION
        internal static let usr = "usrmiclaroobttok";
        internal static let psw = "Sp33dym1c14r0t0k3n";
        internal static let key = "114v3s1m3+rikcifr4d0cu3nt4d3s3rv1ci0"
        internal static let bearer = "fCX1jWyYIrAm07tvQfksYamgJlAa";
        internal static let urlGetToken = "https://config.miclaro.smapps.mx:9011/componentesGenericos/1.0.0/obtenerToken"
        internal static let urlGetCountries = "https://config.miclaro.smapps.mx:9011/componentesGenericos/1.0.0/obtenerPaises"
        internal static let urlGetConfigFile = "https://config.miclaro.smapps.mx:9011/componentesGenericos/1.0.0/obtenerConfiguracion"
    #else
        internal static let usr = "speedy";
        internal static let psw = "sp33dym4";
        internal static let key = "2b2b191a0b5142e8a97ffd81136a832b"
        internal static let bearer = "fCX1jWyYIrAm07tvQfksYamgJlAa";
        internal static let urlGetToken = "http://dev.smapps.mx:8089/miClaroBackend/service/obtenerToken"
        internal static let urlGetCountries = "http://dev.smapps.mx:8089/miClaroBackend/service/obtenerPaises"
        internal static let urlGetConfigFile = "http://dev.smapps.mx:8089/miClaroBackend/service/obtenerConfiguracion"
    #endif

    internal static let showLog = true;

    internal static let jwt_headers = ["typ":"JWT", "alg": "HS256"];

    internal static let timeout = TimeInterval(3*60);
    internal static let HTTP_OK : Int = 200;
    internal static let appDelegate = UIApplication.shared.delegate as! AppDelegate;
    internal static let msgErrorDefault = "Por el momento el servicio no está disponible";
    private static let excludedErrorServices : [ServiceEndpoint] = [.RetrieveBillDetails,
                                                                    .RetrieveBillHistoryList,
                                                                    .RetrieveConsumptionDetailInformation,
                                                                    .RetrieveProfileInformation,
                                                                    .RetrievePlans,
                                                                    .RetrieveAssociatedAccounts,
                                                                    .RetrieveAccountDetails,
                                                                    .RetrievePersonalVerificationQuestions,
                                                                    .AddSMSPremiumToBlackList,
                                                                    .RetrievePackageList,
                                                                    .AddNewPackage,
                                                                    .UpdateChannelStatus,
                                                                    .RetrieveChannelsOffer]

    static var taskGroup = DispatchGroup();

    private class func getAdapterFrom(service : ServiceEndpoint) -> ServiceAdapter {
        #if PRODUCCION
            var adapter : ServiceAdapter = ServiceAdapter.MC_CustomerManagementAdapter;
            switch service {
            case .RetrievePersonalVerificationQuestions, .ValidatePersonalVerificationQuestions:
                adapter = ServiceAdapter.MC_CustomerManagementAdapter;

            case .SendNotification:
                adapter = ServiceAdapter.MC_NotificationManagementAdapter;

            case .CreateNewRegister, .GetTempPassword, .RetrieveProfileInformation, .UpdatePassword, .UpdatePasswordEditProfile,
                 .UpdateProfileInformation, .UpdateTransactionPasswordAttempts, .ValidateTempPassword,
                 .ValidateTransactionPasswordAttempts, .ValidateRut:
                adapter = ServiceAdapter.MC_IdentityManagementAdapter;

            case .RetrievePromotions, .RetrievePlans:
                adapter = ServiceAdapter.MC_BussinesAnalyticsManagementAdapter;

            case .ValidateNumber, .RetrieveAccountList, .RetrieveAssociatedAccounts, .AssociateAccount, .IdentifyUserLoB, .VerifyAssociationToUserId:
                adapter = ServiceAdapter.MC_AccountManagementAdapter;

            case .RetrieveAccountDetails:
                adapter = ServiceAdapter.MC_AccountManagementAdapter_JB

            case .RetrieveBillDetails, .RetrieveBillHistoryList, .RetrieveElectronicDocumentPDF, .SendBillNotification,
                 .GetPaperless, .SetPaperless, .retrieveCycleInformation:
                adapter = ServiceAdapter.MC_BillingManagementAdapter;

            case .RetrieveConsumptionDetailInformation, .RetrieveRechargeOptions, .RetrieveVASDetails, .SwitchPlan,
                 .RetrieveSwitchPlanImplications, .RetrievePlanTicketHistory, .CreateChangePlanTicket, .AddSMSPremiumToBlackList, .RemoveSMSPremiumFromBlackList, .RetrieveSMSPremiumBlackListStatus, .RetrieveSMSPremiumHistory, .RetrieveSMSPremiumSubscriptions, .UnsubscribeSMSPremium, .AddNewPackage, .RetrievePackageList, .UpdateChannelStatus, .RetrieveChannelsOffer:
                adapter = ServiceAdapter.MC_ServiceManagementAdapter;

            case .IdentityLogin, .ValidateCredentials, .RetrievePortalUser, .UpdatePortalUser:
                adapter = ServiceAdapter.MC_IdentityLoginAdapter;

            case .Configuration:
                adapter = ServiceAdapter.NO_Adapter;

            case .CountryList:
                adapter = ServiceAdapter.NO_AdapterContryList
            }
        #else
            var adapter : ServiceAdapter = ServiceAdapter.MC_CustomerManagementAdapter_1_7;
            switch service {
            case .RetrievePersonalVerificationQuestions, .ValidatePersonalVerificationQuestions:
                adapter = ServiceAdapter.MC_CustomerManagementAdapter_1_7;

            case .SendNotification:
                adapter = ServiceAdapter.MC_NotificationManagementAdapter_1_7;

            case .CreateNewRegister, .GetTempPassword, .RetrieveProfileInformation, .UpdatePassword, .UpdatePasswordEditProfile,
                 .UpdateProfileInformation, .UpdateTransactionPasswordAttempts, .ValidateTempPassword,
                 .ValidateTransactionPasswordAttempts, .ValidateRut:
                adapter = ServiceAdapter.MC_IdentityManagementAdapter_1_7;

            case .RetrievePromotions, .RetrievePlans:
                adapter = ServiceAdapter.MC_BussinesAnalyticsManagementAdapter_1_7;

            case .ValidateNumber, .RetrieveAccountList, .RetrieveAssociatedAccounts, .AssociateAccount, .IdentifyUserLoB:
                adapter = ServiceAdapter.MC_AccountManagementAdapter_1_7;

            case .RetrieveAccountDetails:
                adapter = ServiceAdapter.MC_AccountManagementAdapter_1_7

            case .RetrieveBillDetails, .RetrieveBillHistoryList, .RetrieveElectronicDocumentPDF, .SendBillNotification,
                 .GetPaperless, .SetPaperless, .retrieveCycleInformation:
                adapter = ServiceAdapter.MC_BillingManagementAdapter_1_7;

            case .RetrieveConsumptionDetailInformation, .RetrieveRechargeOptions, .RetrieveVASDetails, .SwitchPlan,
                 .RetrieveSwitchPlanImplications, .RetrievePlanTicketHistory,
                 .CreateChangePlanTicket, .VerifyAssociationToUserId, .AddSMSPremiumToBlackList, .RemoveSMSPremiumFromBlackList, .RetrieveSMSPremiumBlackListStatus, .RetrieveSMSPremiumHistory, .RetrieveSMSPremiumSubscriptions, .UnsubscribeSMSPremium:
                adapter = ServiceAdapter.MC_ServiceManagementAdapter_1_7;
                
            case .AddNewPackage, .RetrievePackageList, .UpdateChannelStatus, .RetrieveChannelsOffer:
                adapter = ServiceAdapter.MC_ServiceManagementAdapter_1_9

            case .IdentityLogin, .ValidateCredentials, .RetrievePortalUser, .UpdatePortalUser:
                adapter = ServiceAdapter.MC_IdentityLoginAdapter_1_7;

            case .Configuration:
                adapter = ServiceAdapter.NO_Adapter;

            case .CountryList:
                adapter = ServiceAdapter.NO_AdapterCountryList
            }
        #endif

        return adapter;
    }

    private class func displayLog(log_string : String) {
        if showLog {
            print(log_string);
        }
    }

    private class func getCurrentResultsFor(serviceName: ServiceEndpoint) -> [CachedData]? {
        let predicate = NSPredicate(format: "serviceName == %@", serviceName.rawValue);

        let fetchRequest : NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "CachedData");
        fetchRequest.predicate = predicate

        do {
            return try appDelegate.managedObjectContext.fetch(fetchRequest) as? [CachedData];
        } catch {
            return nil;
        }
    }

    struct ServiceError: ServiceErrorProtocol {
        var localizedTitle: String
        var localizedDescription: String
        var code: Int

        init(localizedTitle: String?, localizedDescription: String, code: Int) {
            self.localizedTitle = localizedTitle ?? "Error"
            self.localizedDescription = localizedDescription
            self.code = code
        }
    }

    private class func evaluateExclusionError(codeToSearch : ServiceEndpoint) -> Bool {
        let isExcludedError = excludedErrorServices.contains(where: {$0 == codeToSearch});

        return isExcludedError;
    }

    private class func getErrorMessageFrom(response: BaseResponse) -> String {
        let cnf = SessionSingleton.sharedInstance.getGeneralConfig();
        let codeToSearch = response.acknowledgementCode?.uppercased() ?? "Desconocido";
        var msg = msgErrorDefault;
        if let dictionaryCodes = cnf?.translations?.data?.acknowledgementCodes?.toJSON() {
            if let selected = dictionaryCodes.first?.first(where: {$0.key.uppercased() == codeToSearch}) {
                msg = (selected.value as? String) ?? msgErrorDefault;
                displayLog(log_string: String.init(format: "Atributo: %@; Valor: %@;", selected.key, msg));
            } else {
                if(codeToSearch == "FFCM-SERMAN-RETSUBS-SC-0"){
                    msg = (response.acknowledgementDescription) ?? msgErrorDefault;
                    displayLog(log_string: String.init(format: "Atributo: %@; Valor: %@;", codeToSearch, msg));
                    
                }else{
                    displayLog(log_string: String(format: "El código %@ no se encuentra en el archivo de configuración. Mostrando mensaje %@", codeToSearch, msgErrorDefault));
                }
            }
        }

        return msg;
    }

    private class func invokeAlert(myError : ServiceError, httpCode : Int) {
        let config = SessionSingleton.sharedInstance.getGeneralConfig();

        if config != nil{
            let accept = AlertAcceptOnly();
            accept.title = String.init(format: "%@", myError.localizedTitle);
            accept.text = String.init(format: "%@", myError.localizedDescription);
            accept.acceptTitle = config?.translations?.data?.generales?.acceptBtn ?? ""
            accept.onAcceptEvent = {}
            accept.icon = AlertIconType.IconoAlertaError
            
            NotificationCenter.default.post(name: Observers.ObserverList.AcceptOnlyAlert.name,
                                            object: accept);
        }
       
    }

    class func executeExternalService<I : Mappable, O : Mappable>(requestURL: String,
                                          withRequest: I?,
                                          serviceMethod: ServiceMethod,
                                          onSuccess: ((_ result : O?) ->  Void)?,
                                          onFailure: ((_ result : O?, _ resultError : ServiceError) -> Void)?) {
        if (false == SessionSingleton.sharedInstance.isNetworkConnected()) {
            let config = SessionSingleton.sharedInstance.getGeneralConfig();
            let sin_internet = "Revisa que tengas acceso a Internet";

            if config != nil{
                let accept = AlertAcceptOnly();
                accept.title = "Sin conexión";
                accept.text = sin_internet;
                accept.icon = AlertIconType.IconoAlertaError
                accept.acceptTitle = config?.translations?.data?.generales?.acceptBtn ?? "Aceptar";
                accept.onAcceptEvent = {
                }

                NotificationCenter.default.post(name: Observers.ObserverList.AcceptOnlyAlert.name,
                                                object: accept);
            }
            let e = ServiceError(localizedTitle: "Error",
                                 localizedDescription: sin_internet,
                                 code: -2);
            onFailure?(nil, e);

            return;
        }

        let url = URL(string: requestURL)
        let noInformation = SessionSingleton.sharedInstance.getGeneralConfig()?.translations?.data?.generales?.serviceNotRespond ?? "Información no actualizada por el momento"

        let method = .POST == serviceMethod ? WLHttpMethodPost : WLHttpMethodGet;

        NotificationCenter.default.post(name: Observers.ObserverList.ShowWaitDialog.name, object: nil);
        let request = WLResourceRequest(url: url, method: method, timeout: timeout);
        let auth_header = String(format: "Bearer %@", bearer) as NSObject
        request?.addHeaderValue(auth_header, forName: "Authorization");

        let completion : ((WLResponse?, Error?) -> Void) = { (response, myError) in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false;
            NotificationCenter.default.post(name: Observers.ObserverList.HideWaitDialog.name, object: nil);
            displayLog(log_string: String(format: "\n\n\t**************** Servicio %@ ***********************\nRequest: %@\n", url!.absoluteString, String(format: "[%@]", withRequest?.toJSONString() ?? "")));
            displayLog(log_string: String(format: "Response: %@\n\t**************** Fin servicio %@ ***********************\n\n", (response?.responseText ?? ""), url!.absoluteString));

            if let r = response?.responseText {
                if let resp = O(JSONString: r) {
                    onSuccess?(resp);
                } else {
                    let e = ServiceError(localizedTitle: "Error",
                                         localizedDescription: noInformation,
                                         code: -2);
                    displayLog(log_string: "Failure: " + e.localizedDescription)
                    invokeAlert(myError: e, httpCode: response!.status)
                    onFailure?(nil, e);
                }
            } else {
                let e = ServiceError(localizedTitle: "Error",
                                     localizedDescription: noInformation,
                                     code: -2);
                displayLog(log_string: "Failure: " + e.localizedDescription)
                invokeAlert(myError: e, httpCode: response!.status)
                onFailure?(nil, e);
            }
        };

        UIApplication.shared.isNetworkActivityIndicatorVisible = true;
        if (nil != withRequest) {
            request?.send(withJSON: withRequest?.toJSON(), completionHandler: completion);
        } else {
            request?.send(completionHandler: completion);
        }

    }

    class func executeGetService<O : Mappable>(requestURL: String,
                                 serviceType: ServiceEndpoint,
                                 shouldPersistData: Bool,
                                 onSuccess: ((_ result : O, _ resultType : ResultType) ->  Void)?,
                                 onFailure: ((_ result : O?, _ resultError : ServiceError) -> Void)?) {
        let url = URL(string: requestURL)

        if (false == SessionSingleton.sharedInstance.isNetworkConnected()) {
            if let r = getLastResponseFromService(service: serviceType, ofType: O.self) {
                onSuccess?(r, ResultType.CachedResult);
                return;
            }
        }

        if let r = getLastResponseFromService(service: serviceType, ofType: O.self) {
            onSuccess?(r, ResultType.CachedResult);
            return;
        }
        let noInformation = SessionSingleton.sharedInstance.getGeneralConfig()?.translations?.data?.generales?.serviceNotRespond ?? "Información no actualizada por el momento"

        NotificationCenter.default.post(name: Observers.ObserverList.ShowWaitDialog.name, object: nil);
        let request = WLResourceRequest(url: url, method: WLHttpMethodGet, timeout: timeout)
        UIApplication.shared.isNetworkActivityIndicatorVisible = true;
        request?.send(completionHandler: { (response, myError) in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false;
            NotificationCenter.default.post(name: Observers.ObserverList.HideWaitDialog.name, object: nil);

            if let r = response?.responseText {
                if let resp = O(JSONString: r) {
                    if (true == shouldPersistData) {
                        self.saveData(data: response!.responseData, currentServiceName: serviceType);
                    }

                    onSuccess?(resp, ResultType.OnlineResult);
                } else {
                    let e = ServiceError(localizedTitle: "Error",
                                         localizedDescription: noInformation,
                                         code: -2);
                    displayLog(log_string: "Failure: " + e.localizedDescription)
                    invokeAlert(myError: e, httpCode: response!.status)
                    onFailure?(nil, e);
                }
            } else {
                let e = ServiceError(localizedTitle: "Error",
                                     localizedDescription: noInformation,
                                     code: -2);
                displayLog(log_string: "Failure: " + e.localizedDescription)
                invokeAlert(myError: e, httpCode: response!.status)
                onFailure?(nil, e);
            }
        })
    }

    class func executePostService<I : Mappable, O : Mappable>(endpoint: ServiceEndpoint,
                            withRequestData: I,
                            shouldPersistData: Bool,
                            onSuccess: ((_ result : O, _ resultType : ResultType) ->  Void)?,
                            onFailure: ((_ result : O?, _ resultError : ServiceError) -> Void)?) {

        SessionSingleton.sharedInstance.isConsumingService(state: true);
        self.taskGroup.enter();
        if (false == SessionSingleton.sharedInstance.isNetworkConnected()) {
            self.taskGroup.leave();
            NotificationCenter.default.post(name: Observers.ObserverList.HideWaitDialog.name, object: nil);
            NotificationCenter.default.post(name: Observers.ObserverList.ShowOfflineMessage.name, object: nil);
            onFailure?(nil, ServiceError(localizedTitle: "", localizedDescription: "", code: 404));
            return;
        }

        let noInformation = SessionSingleton.sharedInstance.getGeneralConfig()?.translations?.data?.generales?.serviceNotRespond ?? "Información no actualizada por el momento"

        let inicio = DispatchTime.now();
        let config = SessionSingleton.sharedInstance.getGeneralConfig();
        let mySession = SessionSingleton.sharedInstance.getCurrentSession();
        let m = Mirror(reflecting: withRequestData);
        for (_, attr) in m.children.enumerated(){
            if let prop = attr.value as? BaseRequest {
                prop.requestingUserId = "user";
                prop.countryCode = config?.country?.code;
                prop.channel = "App";
                prop.isDelegate = "false";
                prop.ownerProfileId = "";
                prop.consumerPreferredLanguage = "es";
                prop.originatingIPAddress = SessionSingleton.sharedInstance.getIpAddress() ?? "localhost";
                prop.uUID = UIDevice.current.identifierForVendor!.uuidString;

                if (false == withRequestData is UpdatePasswordRequest) {
                    if(nil != mySession) {
                        prop.userProfileId = mySession?.retrieveProfileInformationResponse?.personalDetailsInformation?.rUT?.enmascararRut().maskedString;
                    }
                }

            } else {
                continue;
            }
        }

        let enableUserInteraction = (endpoint == .RetrieveConsumptionDetailInformation || endpoint == .RetrieveBillDetails || endpoint == .RetrievePlans); // Poner aqui los servicios que NO queremos que tengan la UI bloqueada
        NotificationCenter.default.post(name: Observers.ObserverList.ShowWaitDialog.name, object: enableUserInteraction);

        let myURL = URL(string: String(format: "%@%@%@%@%@/%@", config?.config?.https == true ? "https://" : "http://",
                                        config?.config?.url ?? "http://mobilefirst8.tmx-internacional.net",
                                        String(format: ":%@",config?.config?.port ?? "80"),
                                        String(format: "%@api/adapters/",config!.config!.context!),
                                        self.getAdapterFrom(service: endpoint).rawValue, endpoint.rawValue));

        let request = WLResourceRequest(url: myURL, method: WLHttpMethodPost, timeout: timeout);
        let jsonArray = String.init(format: "[%@]", withRequestData.toJSONString()!);
        request?.addHeaderValue("application/x-www-form-urlencoded" as NSObject, forName: "Content-Type");
        request?.setQueryParameterValue(jsonArray, forName: "params");
        Crashlytics.sharedInstance().setObjectValue(myURL?.absoluteString ?? "", forKey: "Endpoint");
        Crashlytics.sharedInstance().setObjectValue(jsonArray, forKey: "Request");

        self.taskGroup.notify(queue: DispatchQueue.main) {
            SessionSingleton.sharedInstance.isConsumingService(state: false);
            NotificationCenter.default.post(name: Observers.ObserverList.HideWaitDialog.name, object: nil);
        }
        UIApplication.shared.isNetworkActivityIndicatorVisible = true;
        request?.send(completionHandler: { (response : WLResponse?, error : Error?) in
            defer{
                self.taskGroup.leave();
            }
            Crashlytics.sharedInstance().setObjectValue(response?.responseText ?? "", forKey: "Response");

            UIApplication.shared.isNetworkActivityIndicatorVisible = false;
            displayLog(log_string: String(format: "\n\n\t**************** Servicio %@ ***********************\nRaw Request: %@\n", myURL!.absoluteString, jsonArray));
            displayLog(log_string: String(format: "Raw Response: %@\n\t**************** Fin servicio %@ ***********************\n\n", (response?.responseText ?? ""), myURL!.absoluteString));

            let shouldHandleError : Bool = self.evaluateExclusionError(codeToSearch: endpoint);
            if (HTTP_OK != response?.status) {
                if true == shouldHandleError {
                    if let obj = Mapper<O>().map(JSONString: response?.responseText ?? "") {
                        onSuccess?(obj, ResultType.EmptyDataSetResult);
                    }
                    return;
                } else {
                    let e = ServiceError(localizedTitle: "",
                                         localizedDescription: noInformation,
                                         code: response!.status)
                    displayLog(log_string: "Failure: " + e.localizedDescription)
                    invokeAlert(myError: e, httpCode: response!.status)
                    onFailure?(nil, e);
                    return;
                }
            }

            if let r = response?.responseText {
                if let resp = Mapper<O>().map(JSONString: r) {
                    if let base = resp as? BaseResult {
                        let fin = DispatchTime.now();
                        let tiempo = Double(fin.uptimeNanoseconds - inicio.uptimeNanoseconds) / 1_000_000;
                        let diferencia = tiempo - Double(base.totalTime ?? 0);
                        displayLog(log_string: String(format: "*-*-*-*-*-*- Tiempo Transcurrido Servicio: %d Calculado: %2.0f Diferencia: %2.0f *-*-*-*-*-*-", base.totalTime ?? 0, tiempo, diferencia));
                        if (false == base.isSuccessful) {
                            let e = ServiceError(localizedTitle: "Error",
                                                 localizedDescription: noInformation,
                                                 code: -2);
                            displayLog(log_string: "Failure: " + e.localizedDescription)
                            invokeAlert(myError: e, httpCode: response!.status)
                            onFailure?(resp, e);
                            return;
                        }
                    } else {
                        let e = ServiceError(localizedTitle: "",
                                             localizedDescription: noInformation,
                                             code: -2);
                        displayLog(log_string: "Failure: " + e.localizedDescription)
                        invokeAlert(myError: e, httpCode: response!.status)
                        onFailure?(resp, e);
                        return;
                    }

                    let m = Mirror(reflecting: resp);
                    for (_, attr) in m.children.enumerated(){
                        if let prop = attr.value as? BaseResponse {
                            let msg_ok = getErrorMessageFrom(response: prop);
                            prop.acknowledgementDescription = msg_ok
                            if prop.acknowledgementIndicator == ResultState.SUCCESS.rawValue {
                                if (true == shouldPersistData) {
                                    self.saveData(data: response!.responseData, currentServiceName: endpoint);
                                }
                                onSuccess?(resp, ResultType.OnlineResult);
                                return;
                            } else {
                                if true == shouldHandleError {
                                    onSuccess?(resp, ResultType.EmptyDataSetResult);
                                    return;
                                } else {
                                    let msg = getErrorMessageFrom(response: prop);
                                    let e = ServiceError(localizedTitle: "Error",
                                                         localizedDescription: msg,
                                                         code: -2);
                                    displayLog(log_string: "Failure: " + e.localizedDescription)
                                    onFailure?(resp, e);
                                    return;
                                }
                            }
                        } else if let v = attr.value as? BaseFault {
                            if true == shouldHandleError {
                                if let obj = Mapper<O>().map(JSONString: response?.responseText ?? "") {
                                    onSuccess?(obj, ResultType.EmptyDataSetResult);
                                }
                                return;
                            } else {
                                let e = ServiceError(localizedTitle: "",
                                                     localizedDescription: noInformation,
                                                     code: -2);
                                displayLog(log_string: "Failure: " + (v.message ?? ""))
                                onFailure?(resp, e);
                                return;
                            }
                        } else if nil != (attr.value as? BaseFault)  {
                            if true == shouldHandleError {
                                if let obj = Mapper<O>().map(JSONString: response?.responseText ?? "") {
                                    onSuccess?(obj, ResultType.EmptyDataSetResult);
                                }
                                return;
                            } else {
                                let e = ServiceError(localizedTitle: "",
                                                     localizedDescription: noInformation,
                                                     code: -2);
                                displayLog(log_string: "Failure: " + e.localizedDescription)
                                onFailure?(resp, e);
                                return;
                            }
                        } else {
                            let e = ServiceError(localizedTitle: "",
                                                 localizedDescription: noInformation,
                                                 code: -2);
                            displayLog(log_string: "Failure: " + e.localizedDescription)
                            onFailure?(resp, e);
                            return;
                        }
                    }
                } else {
                    if true == shouldHandleError {
                        if let obj = Mapper<O>().map(JSONString: response?.responseText ?? "") {
                            onSuccess?(obj, ResultType.EmptyDataSetResult);
                        }
                        return;
                    } else {
                        let e = ServiceError(localizedTitle: "",
                                             localizedDescription: noInformation,
                                             code: -2);
                        displayLog(log_string: "Failure: " + e.localizedDescription)
                        invokeAlert(myError: e, httpCode: response!.status)
                        onFailure?(nil, e);
                        return;
                    }
                }
            } else {
                if true == shouldHandleError {
                    if let obj = Mapper<O>().map(JSONString: response?.responseText ?? "") {
                        onSuccess?(obj, ResultType.EmptyDataSetResult);
                    }
                    return;
                } else {
                    let e = ServiceError(localizedTitle: "",
                                         localizedDescription: noInformation,
                                         code: -2);
                    displayLog(log_string: "Failure: " + e.localizedDescription)
                    invokeAlert(myError: e, httpCode: response!.status)
                    onFailure?(nil, e);
                    return;
                }
            }
        })
    }

    internal static func saveData(data : Data, currentServiceName : ServiceEndpoint) {
        if let v = self.getCurrentResultsFor(serviceName: currentServiceName) {
            for item in v {
                if currentServiceName.rawValue == item.serviceName {
                    self.appDelegate.managedObjectContext.delete(item);
                }
            }
        }

        let entity = NSEntityDescription.entity(forEntityName: String(describing: CachedData.self), in: self.appDelegate.managedObjectContext);
        let persist = CachedData(entity: entity!, insertInto: self.appDelegate.managedObjectContext);
        persist.data = data as NSData;
        persist.serviceName = currentServiceName.rawValue;
        persist.lastUpdate = NSDate();
        self.appDelegate.saveContext();
    }

    public static func saveModel(response : BaseResult, ofService : ServiceEndpoint) -> Bool{
        if let cadena = response.toJSONString() {
            if let data = cadena.data(using: String.Encoding.utf8) {
                self.saveData(data: data, currentServiceName: ofService);
                return true;
            } else {
                return false;
            }
        } else {
            return false;
        }
    }

    public static func getLastResponseFromService<T : Mappable>(service : ServiceEndpoint, ofType: T.Type) -> T? {
        if let v = self.getCurrentResultsFor(serviceName: service) {
            if (v.count != 1) {
                return nil;
            }
            
            print(service)
/*
            if (.Configuration == service || .ContryList == service) {
                let lastDate = nil != v.first?.lastUpdate ? v.first!.lastUpdate! as Date : Date();

                let elapsed = Date().timeIntervalSince(lastDate);
                let conf = GeneralConfig(JSONString: String.init(data: v.first!.data! as Data, encoding: .utf8)!)!
                let maxLifeTime = TimeInterval(conf.config?.configFileLifeTime ?? "0.0")!;
                if (maxLifeTime > 0.0 && elapsed > maxLifeTime) {
                    return nil;
                }
            }
*/
            if let json : String = String.init(data: v.first!.data! as Data, encoding: .utf8) {
                return T(JSONString: json);
            } else {
                return nil;
            }
        } else {
            return nil;
        }
    }

    class func executeRetrievePersonalVerificationQuestions(params : RetrievePersonalVerificationQuestionRequest,
                                                            onSuccess: ((_ result : RetrievePersonalVerificationQuestionsResult, _ resultType : ResultType) -> Void)?,
                                                            onFailure : ((_ result : RetrievePersonalVerificationQuestionsResult?, _ resultError : Error) -> Void)?){
        self.executePostService(endpoint: .RetrievePersonalVerificationQuestions,
                                withRequestData: params,
                                shouldPersistData: true,
                                onSuccess: { (result, resultType) in
                                    onSuccess?(result, resultType);
        },
                                onFailure: { (r, myError) in
                                    var result = r;
                                    if nil == result {
                                        result = RetrievePersonalVerificationQuestionsResult();
                                    }
                                    if nil == result?.retrievePersonalVerificationQuestionsResponse {
                                        result?.retrievePersonalVerificationQuestionsResponse = RetrievePersonalVerificationQuestionsResponse()
                                    }
                                    result?.retrievePersonalVerificationQuestionsResponse?.acknowledgementDescription = myError.localizedDescription;
                                    onFailure?(result, myError);

        })
    }

    class func executeValidatePersonalVerificationQuestions(params : ValidatePersonalVerificationQuestionRequest,
                                                            onSuccess: ((_ result : ValidatePersonalVerificationQuestionsResult, _ resultType : ResultType) -> Void)?,
                                                            onFailure : ((_ result : ValidatePersonalVerificationQuestionsResult?, _ resultError : Error) -> Void)?){

        self.executePostService(endpoint: .ValidatePersonalVerificationQuestions,
                                withRequestData: params,
                                shouldPersistData: true,
                                onSuccess: { (result, resultType) in
                                    onSuccess?(result, resultType);
        },
                                onFailure: { (r, myError) in
                                    var result = r;
                                    if nil == result {
                                        result = ValidatePersonalVerificationQuestionsResult();
                                    }
                                    if nil == result?.validatePersonalVerificationQuestionsResponse {
                                        result?.validatePersonalVerificationQuestionsResponse = ValidatePersonalVerificationQuestionsResponse();
                                    }
                                    result?.validatePersonalVerificationQuestionsResponse?.acknowledgementDescription = myError.localizedDescription;
                                    onFailure?(result, myError);

        })
    }

    class func executeSendNotification(params : SendNotificationRequest,
                                       onSuccess: ((_ result : SendNotificationResult, _ resultType : ResultType) -> Void)?,
                                       onFailure : ((_ result : SendNotificationResult?, _ resultError : Error) -> Void)?){

        self.executePostService(endpoint: .SendNotification,
                                withRequestData: params,
                                shouldPersistData: true,
                                onSuccess: { (result, resultType) in
                                    onSuccess?(result, resultType);
        },
                                onFailure: { (r, myError) in
                                    var result = r;
                                    if nil == result {
                                        result = SendNotificationResult();
                                    }
                                    if nil == result?.sendNotificationResponse {
                                        result?.sendNotificationResponse = SendNotificationResponse();
                                    }
                                    result?.sendNotificationResponse?.acknowledgementDescription = myError.localizedDescription;
                                    onFailure?(result, myError);

        })
    }

    class func executeCreateNewRegister(params : CreateNewRegisterRequest,
                                        onSuccess: ((_ result : CreateNewRegisterResult, _ resultType : ResultType) -> Void)?,
                                        onFailure : ((_ result : CreateNewRegisterResult?, _ resultError : Error) -> Void)?){
        self.executePostService(endpoint: .CreateNewRegister,
                                withRequestData: params,
                                shouldPersistData: true,
                                onSuccess: { (result, resultType) in
                                    onSuccess?(result, resultType);
        },
                                onFailure: { (r, myError) in
                                    var result = r;
                                    if nil == result {
                                        result = CreateNewRegisterResult();
                                    }
                                    if nil == result?.createNewRegisterResponse {
                                        result?.createNewRegisterResponse = CreateNewRegisterResponse();
                                    }
                                    result?.createNewRegisterResponse?.acknowledgementDescription = myError.localizedDescription;
                                    onFailure?(result, myError);

        })
    }

    class func executeGetTempPassword(params : GetTempPasswordRequest,
                                      onSuccess: ((_ result : GetTempPasswordResult, _ resultType : ResultType) -> Void)?,
                                      onFailure : ((_ result : GetTempPasswordResult?, _ resultError : Error) -> Void)?){
        self.executePostService(endpoint: .GetTempPassword,
                                withRequestData: params,
                                shouldPersistData: false,
                                onSuccess: { (result, resultType) in
                                    onSuccess?(result, resultType);
        },
                                onFailure: { (r, myError) in
                                    var result = r;
                                    if nil == result {
                                        result = GetTempPasswordResult();
                                    }
                                    if nil == result?.getTempPasswordResponse {
                                        result?.getTempPasswordResponse = GetTempPasswordResponse();
                                    }
                                    result?.getTempPasswordResponse?.acknowledgementDescription = myError.localizedDescription;
                                    onFailure?(result, myError);

        })
    }

    class func executeRetrieveProfileInformation(params : RetrieveProfileInformationRequest,
                                                 onSuccess: ((_ result : RetrieveProfileInformationResult, _ resultType : ResultType) -> Void)?,
                                                 onFailure : ((_ result : RetrieveProfileInformationResult?, _ resultError : Error) -> Void)?){
        self.executePostService(endpoint: .RetrieveProfileInformation,
                                withRequestData: params,
                                shouldPersistData: true,
                                onSuccess: { (result, resultType) in
                                    #if !PRODUCCION
                                        result.retrieveProfileInformationResponse?.personalDetailsInformation?.rUT = params.retrieveProfileInformation?.userProfileId;
                                        _ = saveModel(response: result, ofService: .RetrieveProfileInformation);
                                    #endif
                                    onSuccess?(result, resultType);
        },
                                onFailure: { (r : RetrieveProfileInformationResult?, myError : Error) in
                                    var result = r;
                                    if nil == result {
                                        result = RetrieveProfileInformationResult();
                                    }
                                    if nil == result?.retrieveProfileInformationResponse {
                                        result?.retrieveProfileInformationResponse = RetrieveProfileInformationResponse();
                                    }
                                    result?.retrieveProfileInformationResponse?.acknowledgementDescription = myError.localizedDescription;
                                    onFailure?(result, myError);

        })
    }

    class func executeUpdatePassword(params : UpdatePasswordRequest,
                                                 onSuccess: ((_ result : UpdatePasswordResult, _ resultType : ResultType) -> Void)?,
                                                 onFailure : ((_ result : UpdatePasswordResult?, _ resultError : Error) -> Void)?){
        self.executePostService(endpoint: .UpdatePassword,
                                withRequestData: params,
                                shouldPersistData: true,
                                onSuccess: { (result, resultType) in
                                    onSuccess?(result, resultType);
        },
                                onFailure: { (r, myError) in
                                    var result = r;
                                    if nil == result {
                                        result = UpdatePasswordResult();
                                    }
                                    if nil == result?.updatePasswordResponse {
                                        result?.updatePasswordResponse = UpdatePasswordResponse();
                                    }
                                    result?.updatePasswordResponse?.acknowledgementDescription = myError.localizedDescription;
                                    onFailure?(result, myError);

        })
    }

    class func executeUpdateProfileInformation(params : UpdateProfileInformationRequest,
                                               onSuccess: ((_ result : UpdateProfileInformationResult, _ resultType : ResultType) -> Void)?,
                                               onFailure : ((_ result : UpdateProfileInformationResult?, _ resultError : Error) -> Void)?){
        self.executePostService(endpoint: .UpdateProfileInformation,
                                withRequestData: params,
                                shouldPersistData: true,
                                onSuccess: { (result, resultType) in
                                    onSuccess?(result, resultType);
        },
                                onFailure: { (r, myError) in
                                    var result = r;
                                    if nil == result {
                                        result = UpdateProfileInformationResult();
                                    }
                                    if nil == result?.updateProfileInformationResponse {
                                        result?.updateProfileInformationResponse = UpdateProfileInformationResponse();
                                    }
                                    result?.updateProfileInformationResponse?.acknowledgementDescription = myError.localizedDescription;
                                    onFailure?(result, myError);

        })
    }

    class func executeUpdateTransactionPasswordAttempts(params : UpdateTransactionPasswordAttemptsRequest,
                                                        onSuccess: ((_ result : UpdateTransactionPasswordAttemptsResult, _ resultType : ResultType) -> Void)?,
                                                        onFailure : ((_ result : UpdateTransactionPasswordAttemptsResult?, _ resultError : Error) -> Void)?){
        self.executePostService(endpoint: .UpdateTransactionPasswordAttempts,
                                withRequestData: params,
                                shouldPersistData: true,
                                onSuccess: { (result, resultType) in
                                    onSuccess?(result, resultType);
        },
                                onFailure: { (r, myError) in
                                    var result = r;
                                    if nil == result {
                                        result = UpdateTransactionPasswordAttemptsResult();
                                    }
                                    if nil == result?.updateTransactionPasswordAttemptsResponse {
                                        result?.updateTransactionPasswordAttemptsResponse = UpdateTransactionPasswordAttemptsResponse();
                                    }
                                    result?.updateTransactionPasswordAttemptsResponse?.acknowledgementDescription = myError.localizedDescription;
                                    onFailure?(result, myError);

        })
    }

    class func executeValidateTempPassword(params : ValidateTempPasswordRequest,
                                           onSuccess: ((_ result : ValidateTempPasswordResult, _ resultType : ResultType) -> Void)?,
                                           onFailure : ((_ result : ValidateTempPasswordResult?, _ resultError : Error) -> Void)?){
        self.executePostService(endpoint: .ValidateTempPassword,
                                withRequestData: params,
                                shouldPersistData: false,
                                onSuccess: { (result, resultType) in
                                    onSuccess?(result, resultType);
        },
                                onFailure: { (r, myError) in
                                    var result = r;
                                    if nil == result {
                                        result = ValidateTempPasswordResult();
                                    }
                                    if nil == result?.validateTempPasswordResponse {
                                        result?.validateTempPasswordResponse = ValidateTempPasswordResponse();
                                    }
                                    result?.validateTempPasswordResponse?.acknowledgementDescription = myError.localizedDescription;
                                    onFailure?(result, myError);

        })
    }

    class func executeValidateTransactionPasswordAttempts(params : ValidateTransactionPasswordAttemptsRequest,
                                                          onSuccess: ((_ result : ValidateTransactionPasswordAttemptsResult, _ resultType : ResultType) -> Void)?,
                                                          onFailure : ((_ result : ValidateTransactionPasswordAttemptsResult?, _ resultError : Error) -> Void)?){
        self.executePostService(endpoint: .ValidateTransactionPasswordAttempts,
                                withRequestData: params,
                                shouldPersistData: true,
                                onSuccess: { (result, resultType) in
                                    onSuccess?(result, resultType);
        },
                                onFailure: { (r, myError) in
                                    var result = r;
                                    if nil == result {
                                        result = ValidateTransactionPasswordAttemptsResult();
                                    }
                                    if nil == result?.validateTransactionPasswordAttemptsResponse {
                                        result?.validateTransactionPasswordAttemptsResponse = ValidateTransactionPasswordAttemptsResponse();
                                    }
                                    result?.validateTransactionPasswordAttemptsResponse?.acknowledgementDescription = myError.localizedDescription;
                                    onFailure?(result, myError);

        })
    }

    @available(*, deprecated, message: "Este método ha sido marcada como deprecada el cual es posible que en un futuro deje de ser requerida.")
    class func executeRetrievePromotions(params : RetrievePromotionsRequest,
                                         onSuccess: ((_ result : RetrievePromotionsResult, _ resultType : ResultType) -> Void)?,
                                         onFailure : ((_ result : RetrievePromotionsResult?, _ resultError : Error) -> Void)?){
        self.executePostService(endpoint: .RetrievePromotions,
                                withRequestData: params,
                                shouldPersistData: true,
                                onSuccess: { (result, resultType) in
                                    onSuccess?(result, resultType);
        },
                                onFailure: { (r, myError) in
                                    var result = r;
                                    if nil == result {
                                        result = RetrievePromotionsResult();
                                    }
                                    if nil == result?.retrievePromotionsResponse {
                                        result?.retrievePromotionsResponse = RetrievePromotionsResponse();
                                    }
                                    result?.retrievePromotionsResponse?.acknowledgementDescription = myError.localizedDescription;
                                    onFailure?(result, myError);

        })
    }

    class func executeRetrievePlans(params : RetrievePlansRequest,
                                    onSuccess: ((_ result : RetrievePlansResult, _ resultType : ResultType) -> Void)?,
                                    onFailure : ((_ result : RetrievePlansResult?, _ resultError : Error) -> Void)?){
        self.executePostService(endpoint: .RetrievePlans,
                                withRequestData: params,
                                shouldPersistData: true,
                                onSuccess: { (result, resultType) in
                                    onSuccess?(result, resultType);
        },
                                onFailure: { (r, myError) in
                                    var result = r;
                                    if nil == result {
                                        result = RetrievePlansResult();
                                    }
                                    if nil == result?.retrievePlansResponse {
                                        result?.retrievePlansResponse = RetrievePlansResponse();
                                    }
                                    result?.retrievePlansResponse?.acknowledgementDescription = myError.localizedDescription;
                                    onFailure?(result, myError);

        })
    }

    class func executeValidateNumber(params : ValidateNumberRequest,
                                     onSuccess: ((_ result : ValidateNumberResult, _ resultType : ResultType) -> Void)?,
                                     onFailure : ((_ result : ValidateNumberResult?, _ resultError : Error) -> Void)?){
        self.executePostService(endpoint: .ValidateNumber,
                                withRequestData: params,
                                shouldPersistData: true,
                                onSuccess: { (result, resultType) in
                                    onSuccess?(result, resultType);
        },
                                onFailure: { (r, myError) in
                                    var result = r;
                                    if nil == result {
                                        result = ValidateNumberResult();
                                    }
                                    if nil == result?.validateNumberResponse {
                                        result?.validateNumberResponse = ValidateNumberResponse();
                                    }
                                    result?.validateNumberResponse?.acknowledgementDescription = myError.localizedDescription;
                                    onFailure?(result, myError);

        })
    }

    class func executeRetrieveAccountDetails(params : RetrieveAccountDetailsRequest,
                                                  onSuccess: ((_ result : RetrieveAccountDetailsResult, _ resultType : ResultType) -> Void)?,
                                                  onFailure : ((_ result : RetrieveAccountDetailsResult?, _ resultError : Error) -> Void)?){
        self.executePostService(endpoint: .RetrieveAccountDetails,
                                withRequestData: params,
                                shouldPersistData: true,
                                onSuccess: { (result : RetrieveAccountDetailsResult, resultType) in
                                    onSuccess?(result, resultType);
        },
                                onFailure: { (r, myError) in
                                    var result = r;
                                    if nil == result {
                                        result = RetrieveAccountDetailsResult();
                                    }
                                    if nil == result?.retrieveAccountDetailsResponse {
                                        result?.retrieveAccountDetailsResponse = RetrieveAccountDetailsResponse();
                                    }
                                    result?.retrieveAccountDetailsResponse?.acknowledgementDescription = myError.localizedDescription;
                                    onFailure?(result, myError);

        })
    }

    @available(*, deprecated, message: "Este método ha sido marcada como deprecada el cual es posible que en un futuro deje de ser requerida.")
    class func executeRetrieveAccountList(params : RetrieveAccountListRequest,
                                          onSuccess: ((_ result : RetrieveAccountListResult, _ resultType : ResultType) -> Void)?,
                                          onFailure : ((_ result : RetrieveAccountListResult?, _ resultError : Error) -> Void)?){
        self.executePostService(endpoint: .RetrieveAccountList,
                                withRequestData: params,
                                shouldPersistData: true,
                                onSuccess: { (result, resultType) in
                                    onSuccess?(result, resultType);
        },
                                onFailure: { (r, myError) in
                                    var result = r;
                                    if nil == result {
                                        result = RetrieveAccountListResult();
                                    }
                                    if nil == result?.retrieveAccountListResponse {
                                        result?.retrieveAccountListResponse = RetrieveAccountListResponse();
                                    }
                                    result?.retrieveAccountListResponse?.acknowledgementDescription = myError.localizedDescription;
                                    onFailure?(result, myError);

        })
    }

    class func executeRetrieveAssociatedAccounts(params : RetrieveAssociatedAccountsRequest,
                                                 onSuccess: ((_ result : RetrieveAssociatedAccountsResult, _ resultType : ResultType) -> Void)?,
                                                 onFailure : ((_ result : RetrieveAssociatedAccountsResult?, _ resultError : Error) -> Void)?){
        self.executePostService(endpoint: .RetrieveAssociatedAccounts,
                                withRequestData: params,
                                shouldPersistData: true,
                                onSuccess: { (result, resultType) in
                                    onSuccess?(result, resultType);
        },
                                onFailure: { (r, myError) in
                                    var result = r;
                                    if nil == result {
                                        result = RetrieveAssociatedAccountsResult();
                                    }
                                    if nil == result?.retrieveAssociatedAccountsResponse{
                                        result?.retrieveAssociatedAccountsResponse = RetrieveAssociatedAccountsResponse();
                                    }
                                    result?.retrieveAssociatedAccountsResponse?.acknowledgementDescription = myError.localizedDescription;
                                    onFailure?(result, myError);

        })
    }

    class func executeRetrieveBillDetails(params : RetrieveBillDetailsRequest,
                                          onSuccess: ((_ result : RetrieveBillDetailsResult, _ resultType : ResultType) -> Void)?,
                                          onFailure : ((_ result : RetrieveBillDetailsResult?, _ resultError : Error) -> Void)?){
        self.executePostService(endpoint: .RetrieveBillDetails,
                                withRequestData: params,
                                shouldPersistData: true,
                                onSuccess: { (result : RetrieveBillDetailsResult, resultType) in
                                    onSuccess?(result, resultType);
        },
                                onFailure: { (r, myError) in
                                    var result = r;
                                    if nil == result {
                                        result = RetrieveBillDetailsResult();
                                    }
                                    if nil == result?.retrieveBillDetailsResponse {
                                        result?.retrieveBillDetailsResponse = RetrieveBillDetailsResponse();
                                    }
                                    result?.retrieveBillDetailsResponse?.acknowledgementDescription = myError.localizedDescription;
                                    onFailure?(result, myError);

        })
    }

    class func executeRetrieveBillHistoryList(params : RetrieveBillHistoryListRequest,
                                              onSuccess: ((_ result : RetrieveBillHistoryListResult, _ resultType : ResultType) -> Void)?,
                                              onFailure : ((_ result : RetrieveBillHistoryListResult?, _ resultError : Error) -> Void)?){
        self.executePostService(endpoint: .RetrieveBillHistoryList,
                                withRequestData: params,
                                shouldPersistData: true,
                                onSuccess: { (result, resultType) in
                                    onSuccess?(result, resultType);
        },
                                onFailure: { (r, myError) in
                                    var result = r;
                                    if nil == result {
                                        result = RetrieveBillHistoryListResult();
                                    }
                                    if nil == result?.retrieveBillHistoryListResponse {
                                        result?.retrieveBillHistoryListResponse = RetrieveBillHistoryListResponse();
                                    }
                                    result?.retrieveBillHistoryListResponse?.acknowledgementDescription = myError.localizedDescription;
                                    onFailure?(result, myError);

        })
    }

    class func executeRetrieveElectronicDocumentPDF(params : RetrieveElectronicDocumentPDFRequest,
                                                    onSuccess: ((_ result : RetrieveElectronicDocumentPDFResult, _ resultType : ResultType) -> Void)?,
                                                    onFailure : ((_ result : RetrieveElectronicDocumentPDFResult?, _ resultError : Error) -> Void)?){
        self.executePostService(endpoint: .RetrieveElectronicDocumentPDF,
                                withRequestData: params,
                                shouldPersistData: true,
                                onSuccess: { (result, resultType) in
                                    onSuccess?(result, resultType);
        },
                                onFailure: { (r, myError) in
                                    var result = r;
                                    if nil == result {
                                        result = RetrieveElectronicDocumentPDFResult();
                                    }
                                    if nil == result?.retrieveElectronicDocumentPDFResponse {
                                        result?.retrieveElectronicDocumentPDFResponse = RetrieveElectronicDocumentPDFResponse();
                                    }
                                    result?.retrieveElectronicDocumentPDFResponse?.acknowledgementDescription = myError.localizedDescription;
                                    onFailure?(result, myError);

        })
    }

    class func executeSendBillNotification(params : SendBillNotificationRequest,
                                           onSuccess: ((_ result : SendBillNotificationResult, _ resultType : ResultType) -> Void)?,
                                           onFailure : ((_ result : SendBillNotificationResult?, _ resultError : Error) -> Void)?){
        self.executePostService(endpoint: .SendBillNotification,
                                withRequestData: params,
                                shouldPersistData: true,
                                onSuccess: { (result, resultType) in
                                    onSuccess?(result, resultType);
        },
                                onFailure: { (r, myError) in
                                    var result = r;
                                    if nil == result {
                                        result = SendBillNotificationResult();
                                    }
                                    if nil == result?.sendBillNotificationResponse {
                                        result?.sendBillNotificationResponse = SendBillNotificationResponse();
                                    }
                                    result?.sendBillNotificationResponse?.acknowledgementDescription = myError.localizedDescription;
                                    onFailure?(result, myError);

        })
    }

    class func executeGetPaperless(params : GetPaperlessRequest,
                                   onSuccess: ((_ result : GetPaperlessResult, _ resultType : ResultType) -> Void)?,
                                   onFailure : ((_ result : GetPaperlessResult?, _ resultError : Error) -> Void)?){
        self.executePostService(endpoint: .GetPaperless,
                                withRequestData: params,
                                shouldPersistData: true,
                                onSuccess: { (result, resultType) in
                                    onSuccess?(result, resultType);
        },
                                onFailure: { (r, myError) in
                                    var result = r;
                                    if nil == result {
                                        result = GetPaperlessResult();
                                    }
                                    if nil == result?.getPaperlessResponse {
                                        result?.getPaperlessResponse = GetPaperlessResponse();
                                    }
                                    result?.getPaperlessResponse?.acknowledgementDescription = myError.localizedDescription;
                                    onFailure?(result, myError);

        })
    }

    class func executeSetPaperless(params : SetPaperlessRequest,
                                   onSuccess: ((_ result : SetPaperlessResult, _ resultType : ResultType) -> Void)?,
                                   onFailure : ((_ result : SetPaperlessResult?, _ resultError : Error) -> Void)?){
        self.executePostService(endpoint: .SetPaperless,
                                withRequestData: params,
                                shouldPersistData: true,
                                onSuccess: { (result, resultType) in
                                    onSuccess?(result, resultType);
        },
                                onFailure: { (r, myError) in
                                    var result = r;
                                    if nil == result {
                                        result = SetPaperlessResult();
                                    }
                                    if nil == result?.setPaperlessResponse {
                                        result?.setPaperlessResponse = SetPaperlessResponse();
                                    }
                                    result?.setPaperlessResponse?.acknowledgementDescription = myError.localizedDescription;
                                    onFailure?(result, myError);

        })
    }

    class func executeRetrieveConsumptionDetailInformation(params : RetrieveConsumptionDetailInformationRequest,
                                                           onSuccess: ((_ result : RetrieveConsumptionDetailInformationResult, _ resultType : ResultType) -> Void)?,
                                                           onFailure : ((_ result : RetrieveConsumptionDetailInformationResult?, _ resultError : Error) -> Void)?){
        self.executePostService(endpoint: .RetrieveConsumptionDetailInformation,
                                withRequestData: params,
                                shouldPersistData: true,
                                onSuccess: { (result : RetrieveConsumptionDetailInformationResult, resultType) in
                                    onSuccess?(result, resultType);
        },
                                onFailure: { (r, myError) in
                                    var result = r;
                                    if nil == result {
                                        result = RetrieveConsumptionDetailInformationResult();
                                    }
                                    if nil == result?.retrieveConsumptionDetailInformationResponse {
                                        result?.retrieveConsumptionDetailInformationResponse = RetrieveConsumptionDetailInformationResponse();
                                    }
                                    result?.retrieveConsumptionDetailInformationResponse?.acknowledgementDescription = myError.localizedDescription;
                                    onFailure?(result, myError);

        })
    }

    @available(*, deprecated, message: "Este método ha sido marcada como deprecada el cual es posible que en un futuro deje de ser requerida.")
    class func executeRetrieveRechargeOptions(params : RetrieveRechargeOptionsRequest,
                                              onSuccess: ((_ result : RetrieveRechargeOptionsResult, _ resultType : ResultType) -> Void)?,
                                              onFailure : ((_ result : RetrieveRechargeOptionsResult?, _ resultError : Error) -> Void)?){
        self.executePostService(endpoint: .RetrieveRechargeOptions,
                                withRequestData: params,
                                shouldPersistData: true,
                                onSuccess: { (result, resultType) in
                                    onSuccess?(result, resultType);
        },
                                onFailure: { (r, myError) in
                                    var result = r;
                                    if nil == result {
                                        result = RetrieveRechargeOptionsResult();
                                    }
                                    if nil == result?.retrieveRechargeOptionsResponse {
                                        result?.retrieveRechargeOptionsResponse = RetrieveRechargeOptionsResponse();
                                    }
                                    result?.retrieveRechargeOptionsResponse?.acknowledgementDescription = myError.localizedDescription;
                                    onFailure?(result, myError);

        })
    }

    @available(*, deprecated, message: "Este método ha sido marcada como deprecada el cual es posible que en un futuro deje de ser requerida.")
    class func executeRetrieveVASDetails(params : RetrieveVASDetailsRequest,
                                         onSuccess: ((_ result : RetrieveVASDetailsResult, _ resultType : ResultType) -> Void)?,
                                         onFailure : ((_ result : RetrieveVASDetailsResult?, _ resultError : Error) -> Void)?){
        self.executePostService(endpoint: .RetrieveVASDetails,
                                withRequestData: params,
                                shouldPersistData: true,
                                onSuccess: { (result, resultType) in
                                    onSuccess?(result, resultType);
        },
                                onFailure: { (r, myError) in
                                    var result = r;
                                    if nil == result {
                                        result = RetrieveVASDetailsResult();
                                    }
                                    if nil == result?.retrieveVASDetailsResponse {
                                        result?.retrieveVASDetailsResponse = RetrieveVASDetailsResponse();
                                    }
                                    result?.retrieveVASDetailsResponse?.acknowledgementDescription = myError.localizedDescription;
                                    onFailure?(result, myError);

        })
    }

    @available(*, deprecated, message: "Este método ha sido marcada como deprecada el cual es posible que en un futuro deje de ser requerida.")
    class func executeSwitchPlan(params : SwitchPlanRequest,
                                 onSuccess: ((_ result : SwitchPlanResult, _ resultType : ResultType) -> Void)?,
                                 onFailure : ((_ result : SwitchPlanResult?, _ resultError : Error) -> Void)?){
        self.executePostService(endpoint: .SwitchPlan,
                                withRequestData: params,
                                shouldPersistData: true,
                                onSuccess: { (result, resultType) in
                                    onSuccess?(result, resultType);
        },
                                onFailure: { (r, myError) in
                                    var result = r;
                                    if nil == result {
                                        result = SwitchPlanResult();
                                    }
                                    if nil == result?.switchPlanResponse {
                                        result?.switchPlanResponse = SwitchPlanResponse();
                                    }
                                    result?.switchPlanResponse?.acknowledgementDescription = myError.localizedDescription;
                                    onFailure?(result, myError);

        })
    }

    @available(*, deprecated, message: "Este método ha sido marcada como deprecada el cual es posible que en un futuro deje de ser requerida.")
    class func executeRetrieveSwitchPlanImplications(params : RetrieveSwitchPlanImplicationsRequest,
                                                     onSuccess: ((_ result : RetrieveSwitchPlanImplicationsResult, _ resultType : ResultType) -> Void)?,
                                                     onFailure : ((_ result : RetrieveSwitchPlanImplicationsResult?, _ resultError : Error) -> Void)?){
        self.executePostService(endpoint: .RetrieveSwitchPlanImplications,
                                withRequestData: params,
                                shouldPersistData: true,
                                onSuccess: { (result, resultType) in
                                    onSuccess?(result, resultType);
        },
                                onFailure: { (r, myError) in
                                    var result = r;
                                    if nil == result {
                                        result = RetrieveSwitchPlanImplicationsResult();
                                    }
                                    if nil == result?.retrieveSwitchPlanImplicationsResponse {
                                        result?.retrieveSwitchPlanImplicationsResponse = RetrieveSwitchPlanImplicationsResponse();
                                    }
                                    result?.retrieveSwitchPlanImplicationsResponse?.acknowledgementDescription = myError.localizedDescription;
                                    onFailure?(result, myError);

        })
    }

    @available(*, deprecated, message: "Este método ha sido marcada como deprecada el cual es posible que en un futuro deje de ser requerida.")
    class func executeIdentityLogin(params : IdentityLoginRequest,
                                    onSuccess: ((_ result : IdentityLoginResult, _ resultType : ResultType) -> Void)?,
                                    onFailure : ((_ result : IdentityLoginResult?, _ resultError : Error) -> Void)?){
        self.executePostService(endpoint: .IdentityLogin,
                                withRequestData: params,
                                shouldPersistData: true,
                                onSuccess: { (result, resultType) in
                                    onSuccess?(result, resultType);
        },
                                onFailure: { (r, myError) in
                                    var result = r;
                                    if nil == result {
                                        result = IdentityLoginResult();
                                    }
                                    if nil == result?.identityLoginResponse {
                                        result?.identityLoginResponse = IdentityLoginResponse();
                                    }
                                    result?.identityLoginResponse?.acknowledgementDescription = myError.localizedDescription;
                                    onFailure?(result, myError);

        })
    }

    class func executeValidateCredentials(params : ValidateCredentialsRequest,
                                    onSuccess: ((_ result : ValidateCredentialsResult, _ resultType : ResultType) -> Void)?,
                                    onFailure : ((_ result : ValidateCredentialsResult?, _ resultError : Error) -> Void)?){
        self.executePostService(endpoint: .ValidateCredentials,
                                withRequestData: params,
                                shouldPersistData: true,
                                onSuccess: { (result, resultType) in
                                    onSuccess?(result, resultType);
        },
                                onFailure: { (r, myError) in
                                    var result = r;
                                    if nil == result {
                                        result = ValidateCredentialsResult();
                                    }
                                    if nil == result?.validateCredentialsResponse {
                                        result?.validateCredentialsResponse = ValidateCredentialsResponse();
                                    }
                                    result?.validateCredentialsResponse?.acknowledgementDescription = myError.localizedDescription;
                                    onFailure?(result, myError);
        })
    }

    class func executeUpdatePasswordEditProfile(params : UpdatePasswordEditProfileRequest,
                                          onSuccess: ((_ result : UpdatePasswordEditProfileResult, _ resultType : ResultType) -> Void)?,
                                          onFailure : ((_ result : UpdatePasswordEditProfileResult?, _ resultError : Error) -> Void)?){
        self.executePostService(endpoint: .UpdatePassword,
                                withRequestData: params,
                                shouldPersistData: false,
                                onSuccess: { (result, resultType) in
                                    onSuccess?(result, resultType);
        },
                                onFailure: { (r, myError) in
                                    var result = r;
                                    if nil == result {
                                        result = UpdatePasswordEditProfileResult();
                                    }
                                    if nil == result?.updatePasswordEditProfileResponse {
                                        result?.updatePasswordEditProfileResponse = UpdatePasswordEditProfileResponse();
                                    }
                                    result?.updatePasswordEditProfileResponse?.acknowledgementDescription = myError.localizedDescription;
                                    onFailure?(result, myError);
        })
    }

    class func executeAssociateAccount(params : AssociateAccountRequest,
                                          onSuccess: ((_ result : AssociateAccountResult, _ resultType : ResultType) -> Void)?,
                                          onFailure : ((_ result : AssociateAccountResult?, _ resultError : Error) -> Void)?){
        self.executePostService(endpoint: .AssociateAccount,
                                withRequestData: params,
                                shouldPersistData: true,
                                onSuccess: { (result, resultType) in
                                    onSuccess?(result, resultType);
        },
                                onFailure: { (r, myError) in
                                    var result = r;
                                    if nil == result {
                                        result = AssociateAccountResult();
                                    }
                                    if nil == result?.associateAccountResponse{
                                        result?.associateAccountResponse = AssociateAccountResponse();
                                    }
                                    result?.associateAccountResponse?.acknowledgementDescription = myError.localizedDescription;
                                    onFailure?(result, myError);
        })
    }

    class func executeRetrieveCycleInformation(params : RetrieveCycleInformationRequest,
                                               onSuccess: ((_ result : RetrieveCycleInformationResult, _ resultType : ResultType) -> Void)?,
                                               onFailure: ((_ result : RetrieveCycleInformationResult?, _ resultError : Error) -> Void)?){
        self.executePostService(endpoint: .retrieveCycleInformation,
                                withRequestData: params,
                                shouldPersistData: true,
                                onSuccess: { (result, resultType) in
                                    onSuccess?(result, resultType);
        },
                                onFailure: { (r, myError) in
                                    var result = r;
                                    if (nil == result) {
                                        result = RetrieveCycleInformationResult();
                                    }
                                    if (nil == result?.retrieveCycleInformationResponse) {
                                        result?.retrieveCycleInformationResponse = RetrieveCycleInformationResponse();
                                    }
                                    result?.retrieveCycleInformationResponse?.acknowledgementDescription = myError.localizedDescription;
                                    onFailure?(result, myError);
        });
    }

    class func executeRetrievePortalUser(params : RetrievePortalUserRequest,
                                         onSuccess: ((_ result : RetrievePortalUserResult, _ resultType : ResultType) -> Void)?,
                                         onFailure: ((_ result : RetrievePortalUserResult?, _ resultError : Error) -> Void)?) {
        self.executePostService(endpoint: .RetrievePortalUser,
                                withRequestData: params,
                                shouldPersistData: true,
                                onSuccess: { (result, resultType) in
                                    onSuccess?(result, resultType);
        },
                                onFailure: { (r, myError) in
                                    var result = r;
                                    if (nil == result) {
                                        result = RetrievePortalUserResult();
                                    }
                                    if (nil == result?.retrievePortalUserResponse) {
                                        result?.retrievePortalUserResponse = RetrievePortalUserResponse();
                                    }
                                    result?.retrievePortalUserResponse?.acknowledgementDescription = myError.localizedDescription;
                                    onFailure?(result, myError);
        })
    }

    class func executeUpdatePortalUser(params : UpdatePortalUserRequest,
                                       onSuccess: ((_ result : UpdatePortalUserResult, _ resultType : ResultType) -> Void)?,
                                       onFailure: ((_ result : UpdatePortalUserResult?, _ resultError : Error) -> Void)?) {
        self.executePostService(endpoint: .UpdatePortalUser,
                                withRequestData: params,
                                shouldPersistData: true,
                                onSuccess: { (result, resultType) in
                                    onSuccess?(result, resultType);
        },
                                onFailure: { (r, myError) in
                                    var result = r;
                                    if (nil == result) {
                                        result = UpdatePortalUserResult();
                                    }
                                    if (nil == result?.updatePortalUserResponse) {
                                        result?.updatePortalUserResponse = UpdatePortalUserResponse();
                                    }
                                    result?.updatePortalUserResponse?.acknowledgementDescription = myError.localizedDescription;
                                    onFailure?(result, myError);
        });
    }

    class func executeRetrievePlanTicketHistory(params : RetrievePlanTicketHistoryRequest,
                                                onSuccess: ((_ result : RetrievePlanTicketHistoryResult, _ resultType : ResultType) -> Void)?,
                                                onFailure: ((_ result : RetrievePlanTicketHistoryResult?, _ resultError : Error) -> Void)?) {
        self.executePostService(endpoint: .RetrievePlanTicketHistory,
                                withRequestData: params,
                                shouldPersistData: true,
                                onSuccess: { (result, resultType) in
                                    onSuccess?(result, resultType);
        },
                                onFailure: { (r, myError) in
                                    var result = r;
                                    if (nil == result) {
                                        result = RetrievePlanTicketHistoryResult()
                                    }
                                    if (nil == result?.retrievePlanTicketHistoryResponse) {
                                        result?.retrievePlanTicketHistoryResponse = RetrievePlanTicketHistoryResponse()
                                    }
                                    result?.retrievePlanTicketHistoryResponse?.acknowledgementDescription = myError.localizedDescription;
                                    onFailure?(result, myError);
        });
    }

    class func executeCreateChangePlanTicket(params : CreateChangePlanTicketRequest,
                                             onSuccess: ((_ result : CreateChangePlanTicketResult, _ resultType : ResultType) -> Void)?,
                                             onFailure: ((_ result : CreateChangePlanTicketResult?, _ resultError : Error) -> Void)?) {
        self.executePostService(endpoint: .CreateChangePlanTicket,
                                withRequestData: params,
                                shouldPersistData: true,
                                onSuccess: { (result, resultType) in
                                    onSuccess?(result, resultType);
        },
                                onFailure: { (r, myError) in
                                    var result = r;
                                    if (nil == result) {
                                        result = CreateChangePlanTicketResult();
                                    }
                                    if (nil == result?.createChangePlanTicketResponse) {
                                        result?.createChangePlanTicketResponse = CreateChangePlanTicketResponse();
                                    }
                                    result?.createChangePlanTicketResponse?.acknowledgementDescription = myError.localizedDescription;
                                    onFailure?(result, myError);
        });
    }

    class func executeIdentifyUserLoB(params : IdentifyUserLoBRequest,
                                      onSuccess: ((_ result : IdentifyUserLoBResult, _ resultType : ResultType) -> Void)?,
                                      onFailure: ((_ result : IdentifyUserLoBResult?, _ resultError : Error) -> Void)?) {
        self.executePostService(endpoint: .IdentifyUserLoB,
                                withRequestData: params,
                                shouldPersistData: true,
                                onSuccess: { (result, resultType) in
                                    onSuccess?(result, resultType);
        },
                                onFailure: { (r, myError) in
                                    var result = r;
                                    if (nil == result) {
                                        result = IdentifyUserLoBResult();
                                    }

                                    if (nil == result?.identifyUserLoBResponse) {
                                        result?.identifyUserLoBResponse = IdentifyUserLoBResponse();
                                    }
                                    result?.identifyUserLoBResponse?.acknowledgementDescription = myError.localizedDescription
                                    onFailure?(result, myError);
        });
    }

    class func executeVerifyASsociationToUserId(params : VerifyAssociationToUserIdRequest,
                                                onSuccess: ((_ result : VerifyAssociationToUserIdResult, _ resultType : ResultType) -> Void)?,
                                                onFailure: ((_ result : VerifyAssociationToUserIdResult?, _ resultError : Error) -> Void)?) {
        self.executePostService(endpoint: .VerifyAssociationToUserId,
                                withRequestData: params,
                                shouldPersistData: true,
                                onSuccess: { (result, resultType) in
                                    onSuccess?(result, resultType);
        },
                                onFailure: { (r, myError) in
                                    var result = r;
                                    if (nil == result) {
                                        result = VerifyAssociationToUserIdResult();
                                    }

                                    if (nil == result?.verifyAssociationToUserIdResponse){
                                        result?.verifyAssociationToUserIdResponse = VerifyAssociationToUserIdResponse();
                                    }
                                    result?.verifyAssociationToUserIdResponse?.acknowledgementDescription = myError.localizedDescription;
                                    onFailure?(result, myError);
        })
    }

    class func executeValidateRUT(params: ValidateRUTRequest,
                                  onSuccess: ((_ result : ValidateRUTResult, _ resultType : ResultType) -> Void)?,
                                  onFailure: ((_ result: ValidateRUTResult?, _ resultError : Error) -> Void)?) {
        self.executePostService(endpoint: .ValidateRut,
                                withRequestData: params,
                                shouldPersistData: true,
                                onSuccess: { (result, resultType) in
                                    onSuccess?(result, resultType);
        },
                                onFailure: { (r, myError) in
                                    var result = r;
                                    if (nil == result) {
                                        result = ValidateRUTResult();
                                    }

                                    if (nil == result?.validateRUTResponse) {
                                        result?.validateRUTResponse = ValidateRUTResponse();
                                    }
                                    result?.validateRUTResponse?.acknowledgementDescription = myError.localizedDescription;
                                    onFailure?(result, myError);
        })
    }
    class func executeAddSMSPremiumToBlackList(params : AddSMSPremiumToBlackListRequest,
                                               onSuccess: ((_ result : AddSMSPremiumToBlackListResult, _ resultType : ResultType) -> Void)?,
                                               onFailure: ((_ result : AddSMSPremiumToBlackListResult?, _ resultError : Error) -> Void)?){
        self.executePostService(endpoint: .AddSMSPremiumToBlackList,
                                withRequestData: params,
                                shouldPersistData: true,
                                onSuccess: { (result, resultType) in
                                    onSuccess?(result, resultType);
        },
                                onFailure: { (r, myError) in
                                    var result = r;
                                    if (nil == result) {
                                        result = AddSMSPremiumToBlackListResult();
                                    }
                                    if (nil == result?.addSMSPremiumToBlackListResponse) {
                                        result?.addSMSPremiumToBlackListResponse = AddSMSPremiumToBlackListResponse();
                                    }
                                    result?.addSMSPremiumToBlackListResponse?.acknowledgementDescription = myError.localizedDescription;
                                    onFailure?(result, myError);
        });
    }
    class func executeRemoveSMSPremiumFromBlackList(params : RemoveSMSPremiumFromBlackListRequest,
                                               onSuccess: ((_ result : RemoveSMSPremiumFromBlackListResult, _ resultType : ResultType) -> Void)?,
                                               onFailure: ((_ result : RemoveSMSPremiumFromBlackListResult?, _ resultError : Error) -> Void)?){
        self.executePostService(endpoint: .RemoveSMSPremiumFromBlackList,
                                withRequestData: params,
                                shouldPersistData: true,
                                onSuccess: { (result, resultType) in
                                    onSuccess?(result, resultType);
        },
                                onFailure: { (r, myError) in
                                    var result = r;
                                    if (nil == result) {
                                        result = RemoveSMSPremiumFromBlackListResult();
                                    }
                                    if (nil == result?.removeSMSPremiumFromBlackListResponse) {
                                        result?.removeSMSPremiumFromBlackListResponse = RemoveSMSPremiumFromBlackListResponse();
                                    }
                                    result?.removeSMSPremiumFromBlackListResponse?.acknowledgementDescription = myError.localizedDescription;
                                    onFailure?(result, myError);
        });
    }
    class func executeRetrieveSMSPremiumBlackListStatus(params : RetrieveSMSPremiumBlackListStatusRequest,
                                               onSuccess: ((_ result : RetrieveSMSPremiumBlackListStatusResult, _ resultType : ResultType) -> Void)?,
                                               onFailure: ((_ result : RetrieveSMSPremiumBlackListStatusResult?, _ resultError : Error) -> Void)?){
        self.executePostService(endpoint: .RetrieveSMSPremiumBlackListStatus,
                                withRequestData: params,
                                shouldPersistData: true,
                                onSuccess: { (result, resultType) in
                                    onSuccess?(result, resultType);
        },
                                onFailure: { (r, myError) in
                                    var result = r;
                                    if (nil == result) {
                                        result = RetrieveSMSPremiumBlackListStatusResult();
                                    }
                                    if (nil == result?.retrieveSMSPremiumBlackListStatusResponse) {
                                        result?.retrieveSMSPremiumBlackListStatusResponse = RetrieveSMSPremiumBlackListStatusResponse();
                                    }
                                    result?.retrieveSMSPremiumBlackListStatusResponse?.acknowledgementDescription = myError.localizedDescription;
                                    onFailure?(result, myError);
        });
    }
    class func executeRetrieveSMSPremiumHistory(params : RetrieveSMSPremiumHistoryRequest,
                                               onSuccess: ((_ result : RetrieveSMSPremiumHistoryResult, _ resultType : ResultType) -> Void)?,
                                               onFailure: ((_ result : RetrieveSMSPremiumHistoryResult?, _ resultError : Error) -> Void)?){
        self.executePostService(endpoint: .RetrieveSMSPremiumHistory,
                                withRequestData: params,
                                shouldPersistData: true,
                                onSuccess: { (result, resultType) in
                                    onSuccess?(result, resultType);
        },
                                onFailure: { (r, myError) in
                                    var result = r;
                                    if (nil == result) {
                                        result = RetrieveSMSPremiumHistoryResult();
                                    }
                                    if (nil == result?.retrieveSMSPremiumHistoryResponse) {
                                        result?.retrieveSMSPremiumHistoryResponse = RetrieveSMSPremiumHistoryResponse();
                                    }
                                    result?.retrieveSMSPremiumHistoryResponse?.acknowledgementDescription = myError.localizedDescription;
                                    onFailure?(result, myError);
        });
    }
    class func executeRetrieveSMSPremiumSubscriptions(params : RetrieveSMSPremiumSubscriptionsRequest,
                                               onSuccess: ((_ result : RetrieveSMSPremiumSubscriptionsResult, _ resultType : ResultType) -> Void)?,
                                               onFailure: ((_ result : RetrieveSMSPremiumSubscriptionsResult?, _ resultError : Error) -> Void)?){
        self.executePostService(endpoint: .RetrieveSMSPremiumSubscriptions,
                                withRequestData: params,
                                shouldPersistData: true,
                                onSuccess: { (result, resultType) in
                                    onSuccess?(result, resultType);
        },
                                onFailure: { (r, myError) in
                                    var result = r;
                                    if (nil == result) {
                                        result = RetrieveSMSPremiumSubscriptionsResult();
                                    }
                                    if (nil == result?.retrieveSMSPremiumSubscriptionsResponse) {
                                        result?.retrieveSMSPremiumSubscriptionsResponse = RetrieveSMSPremiumSubscriptionsResponse();
                                    }
                                    result?.retrieveSMSPremiumSubscriptionsResponse?.acknowledgementDescription = myError.localizedDescription;
                                    onFailure?(result, myError);
        });
    }
    class func executeUnsubscribeSMSPremium(params : UnsubscribeSMSPremiumRequest,
                                               onSuccess: ((_ result : UnsubscribeSMSPremiumResult, _ resultType : ResultType) -> Void)?,
                                               onFailure: ((_ result : UnsubscribeSMSPremiumResult?, _ resultError : Error) -> Void)?){
        self.executePostService(endpoint: .UnsubscribeSMSPremium,
                                withRequestData: params,
                                shouldPersistData: true,
                                onSuccess: { (result, resultType) in
                                    onSuccess?(result, resultType);
        },
                                onFailure: { (r, myError) in
                                    var result = r;
                                    if (nil == result) {
                                        result = UnsubscribeSMSPremiumResult();
                                    }
                                    if (nil == result?.unsubscribeSMSPremiumResponse) {
                                        result?.unsubscribeSMSPremiumResponse = UnsubscribeSMSPremiumResponse();
                                    }
                                    result?.unsubscribeSMSPremiumResponse?.acknowledgementDescription = myError.localizedDescription;
                                    onFailure?(result, myError);
        });
    }
    
    //Bolsas
    class func executeRetrievePackageList(params : RetrievePackageListRequest,
                                            onSuccess: ((_ result : RetrievePackageListResult, _ resultType : ResultType) -> Void)?,
                                            onFailure: ((_ result : RetrievePackageListResult?, _ resultError : Error) -> Void)?){
        self.executePostService(endpoint: .RetrievePackageList,
                                withRequestData: params,
                                shouldPersistData: true,
                                onSuccess: { (result, resultType) in
                                    onSuccess?(result, resultType);
        },
                                onFailure: { (r, myError) in
                                    var result = r;
                                    if (nil == result) {
                                        result = RetrievePackageListResult();
                                    }
                                    if (nil == result?.retrievePackageListResponse) {
                                        result?.retrievePackageListResponse = RetrievePackageListResponse();
                                    }
                                    result?.retrievePackageListResponse?.acknowledgementDescription = myError.localizedDescription;
                                    onFailure?(result, myError);
        });
    }

    class func executeAddNewPackage(params : AddNewPackageRequest,
                                            onSuccess: ((_ result : AddNewPackageResult, _ resultType : ResultType) -> Void)?,
                                            onFailure: ((_ result : AddNewPackageResult?, _ resultError : Error) -> Void)?){
        self.executePostService(endpoint: .AddNewPackage,
                                withRequestData: params,
                                shouldPersistData: true,
                                onSuccess: { (result, resultType) in
                                    onSuccess?(result, resultType);
        },
                                onFailure: { (r, myError) in
                                    var result = r;
                                    if (nil == result) {
                                        result = AddNewPackageResult();
                                    }
                                    if (nil == result?.addNewPackageResponse) {
                                        result?.addNewPackageResponse = AddNewPackageResponse();
                                    }
                                    result?.addNewPackageResponse?.acknowledgementDescription = myError.localizedDescription;
                                    onFailure?(result, myError);
        });
    }

    //Activacion de canales
    class func executeUpdateChannelStatus(params : UpdateChannelStatusRequest,
                                    onSuccess: ((_ result : UpdateChannelStatusResult, _ resultType : ResultType) -> Void)?,
                                    onFailure: ((_ result : UpdateChannelStatusResult?, _ resultError : Error) -> Void)?){
        self.executePostService(endpoint: .UpdateChannelStatus,
                                withRequestData: params,
                                shouldPersistData: true,
                                onSuccess: { (result, resultType) in
                                    onSuccess?(result, resultType);
        },
                                onFailure: { (r, myError) in
                                    var result = r;
                                    if (nil == result) {
                                        result = UpdateChannelStatusResult();
                                    }
                                    if (nil == result?.updateChannelStatusResponse) {
                                        result?.updateChannelStatusResponse = UpdateChannelStatusResponse();
                                    }
                                    result?.updateChannelStatusResponse?.acknowledgementDescription = myError.localizedDescription;
                                    onFailure?(result, myError);
        });
    }
    
    class func executeRetrieveChannelsOffer(params : RetrieveChannelsOfferRequest,
                                          onSuccess: ((_ result : RetrieveChannelsOfferResult, _ resultType : ResultType) -> Void)?,
                                          onFailure: ((_ result : RetrieveChannelsOfferResult?, _ resultError : Error) -> Void)?){
        self.executePostService(endpoint: .RetrieveChannelsOffer,
                                withRequestData: params,
                                shouldPersistData: true,
                                onSuccess: { (result, resultType) in
                                    onSuccess?(result, resultType);
        },
                                onFailure: { (r, myError) in
                                    var result = r;
                                    if (nil == result) {
                                        result = RetrieveChannelsOfferResult();
                                    }
                                    if (nil == result?.retrieveChannelsOfferResponse) {
                                        result?.retrieveChannelsOfferResponse = RetrieveChannelsOfferResponse();
                                    }
                                    result?.retrieveChannelsOfferResponse?.acknowledgementDescription = myError.localizedDescription;
                                    onFailure?(result, myError);
        });
    }

}

class UserAgent {
    static func getUserAgent() -> String {
        let bundleDict = Bundle.main.infoDictionary!
        let appName = bundleDict["CFBundleName"] as! String
        let appVersion = bundleDict["CFBundleShortVersionString"] as! String
        let appBundleVersion = bundleDict["CFBundleVersion"] as! String
        let appDescriptor = String(format: "%@/%@.%@", appName, appVersion, appBundleVersion)

        let currentDevice = UIDevice.current;
        let osDescriptor = "iOS/" + currentDevice.systemVersion

        let hardwareString = self.getHardwareString()

        return String(format: "%@ %@ (%@)", appDescriptor, osDescriptor, hardwareString)
    }

    private static func getHardwareString() -> String {
        let name: [Int32] = [CTL_HW, HW_MACHINE]
        var size: Int = 2
        sysctl(UnsafeMutablePointer<Int32>(mutating:name), 2, nil, &size, UnsafeMutablePointer<Int32>(mutating:name), 0)
        var hw_machine = [CChar](repeating: 0, count: Int(size))
        sysctl(UnsafeMutablePointer<Int32>(mutating:name), 2, &hw_machine, &size, UnsafeMutablePointer<Int32>(mutating:name), 0)

        let hardware: String = String(cString: hw_machine)
        return hardware
    }
}
