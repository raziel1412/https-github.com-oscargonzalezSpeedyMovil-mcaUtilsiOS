//
//  ContainerVC.swift
//  MiClaro
//
//  Created by Roberto Gutierrez Resendiz on 31/07/17.
//  Copyright © 2017 am. All rights reserved.
//

import UIKit
import SidebarOverlay
import ObjectMapper

class ContainerVC: SOContainerViewController {

    private var pagerTabMenu : PagerTabMenuVC?
    private var accounts : [ServiceAccount]?
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate;
    private var homeView: HomeManagementViewController?
    var refreshAccounts: Bool! = false

    override func viewDidLoad() {
        super.viewDidLoad()

        self.menuSide = .left;
        self.sideMenuWidth = self.view.frame.size.width * 0.85;
        self.view.backgroundColor = institutionalColors.claroWhiteColor;
            let bkg = UIImageView(image: UIImage(named: "MiClaroWalkthrough"));
            bkg.frame = UIScreen.main.bounds;
            bkg.contentMode = .scaleAspectFit
            self.view.addSubview(bkg);

        let cached = SessionSingleton.sharedInstance.getFullAccountData();
        
        let conf = SessionSingleton.sharedInstance.getGeneralConfig()

        if nil == cached && showModal == false {
            accounts = nil;
            let reqRAA = RetrieveAssociatedAccountsRequest();
            reqRAA.retrieveAssociatedAccounts?.lineOfBusiness = "0"
            WebServicesWithObjects.executeRetrieveAssociatedAccounts(params: reqRAA,
                 onSuccess: { (result : RetrieveAssociatedAccountsResult, rt : ResultType) in
                    if (rt == ResultType.OnlineResult || rt == ResultType.CachedResult) {
                        self.fetchAccountDetails(accountsResult: result);
                    } else if (rt == ResultType.EmptyDataSetResult) {
                        
                        let acknowledgementCodes = conf?.translations?.data?.acknowledgementCodes
                        
                        for text in acknowledgementCodes! {
                            if text.aSSCMACCMANRETASSACCBSERR2 != nil {
                                if(result.retrieveAssociatedAccountsResponse?.acknowledgementCode == "ASSCM-ACCMAN-RETASSACC-BSERR-2" /*text.aSSCMACCMANRETASSACCBSERR2*/ ){
                                    showModal = true
                                }
                            }
                        }
                        
                        if showModal == false{
                            let alerta = AlertAcceptOnly();
                            alerta.title = "";
                            alerta.icon = AlertIconType.IconoAlertaError
                            //                        alerta.text = result.retrieveAssociatedAccountsResponse?.acknowledgementDescription ?? "Información no actualizada por el momento"
                            alerta.text = conf?.translations?.data?.generales?.serviceNotRespond ?? "Información no actualizada por el momento"
                            AnalyticsInteractionSingleton.sharedInstance.ADBTrackView(viewName: "Mis servicios|Resumen|Informacion no disponible", detenido: false)
                            alerta.onAcceptEvent = {
                                self.appDelegate.killEntities();
                                self.appDelegate.loadMainScreen();
                            }
                            NotificationCenter.default.post(name: Observers.ObserverList.AcceptOnlyAlert.name,
                                                            object: alerta);
                        }
                      
                    }
            },
                 onFailure: { (result : RetrieveAssociatedAccountsResult?, error : Error) in
                    let alerta = AlertAcceptOnly();
                    alerta.icon = AlertIconType.IconoAlertaError
                    alerta.text = conf?.translations?.data?.generales?.serviceNotRespond ?? "Información no actualizada por el momento"
                    alerta.onAcceptEvent = {
                        self.appDelegate.killEntities();
                        self.appDelegate.loadMainScreen();
                    }
                    NotificationCenter.default.post(name: Observers.ObserverList.AcceptOnlyAlert.name,
                                                    object: alerta);
            });

            WebServicesWithObjects.taskGroup.notify(queue: DispatchQueue.main, execute: {
//                self.loadMainUI();
                SessionSingleton.sharedInstance.setLastRefreshDate(fecha: Date());
                if(showModal){
                    self.loadMainUI();
                }else{
                    self.cargarDatosMultiples()
                }
            });
        } else {
            accounts = cached;
            self.loadMainUI();
        }
    }

    func loadMainUI() {
        SessionSingleton.sharedInstance.setFullAccountData(account: self.accounts)
        pagerTabMenu = PagerTabMenuVC();
        self.pagerTabMenu?.tabDataSource = self.accounts;
        self.pagerTabMenu?.associatedAccountList = nil
        self.pagerTabMenu?.accountDetailList = nil
        
        //Agregar validación para mostrar la vista de finalizar registro
        let isDigital = SessionSingleton.sharedInstance.getDigitalBirth() ?? false
        /**** CODIGOPARA HARDCODE
//        SessionSingleton.sharedInstance.setActionType(type: 0)
//        showModal = true
         ****/
        let actionType = SessionSingleton.sharedInstance.getActionType() ?? -1

        //se elimino la bandera del showmodal puesto que si se debe de mostrar el completeRegister y al finalizar lanzar al modal.
        if(isDigital && (actionType == 1 || actionType == 2)){
            let completeRegister = CompleteRegisterDBViewController(nibName: "CompleteRegisterDBViewController", bundle: nil)
            completeRegister.view.frame = self.view.frame
            let nav = UINavigationController(rootViewController: completeRegister);
            nav.navigationBar.layer.shadowColor = institutionalColors.claroLightGrayColor.cgColor;
            nav.navigationBar.layer.shadowOpacity = 0.8;
            nav.navigationBar.layer.shadowOffset = CGSize(width: 0, height: 2);
            nav.navigationBar.layer.shadowRadius = 2;
            
            self.topViewController = nav
           
        }else {
            //Mostrar home de la aplicación
            if(showModal){
                self.homeView = HomeManagementViewController(frame: self.view.frame, services:[ServiceAccount]())
            }else{
                self.homeView = HomeManagementViewController(frame: self.view.frame, services: self.accounts!)
                self.homeView?.refreshAccounts = refreshAccounts
                self.refreshAccounts = false
            }
            let nav = UINavigationController(rootViewController: TabBarContainerVC(front: self.homeView!/*self.pagerTabMenu!*/));
            nav.navigationBar.layer.shadowColor = institutionalColors.claroLightGrayColor.cgColor;
            nav.navigationBar.layer.shadowOpacity = 0.8;
            nav.navigationBar.layer.shadowOffset = CGSize(width: 0, height: 2);
            nav.navigationBar.layer.shadowRadius = 2;
            self.topViewController = nav
            
            //para remover el tap en caso de que este presente el modal de DigitalBorn
            if(isDigital || showModal){
                for recognizer in (self.topViewController?.view.gestureRecognizers!)! {
                    self.topViewController?.view.removeGestureRecognizer(recognizer)
                }
            }
            let lateral = LateralMenuVC();
            lateral.widthMenu = self.sideMenuWidth;
            self.sideViewController = lateral;
        }
        
        
    }

    func fetchAccountDetails(accountsResult : RetrieveAssociatedAccountsResult) {
        guard let associatedAccountList = accountsResult.retrieveAssociatedAccountsResponse?.associatedAccountList else {
            return;
        }

        for element in associatedAccountList {
            let req = RetrieveAccountDetailsRequest()
            req.retrieveAccountDetails?.accountId = element.accountId
            req.retrieveAccountDetails?.lineOfBusiness = element.lineOfBusiness
            WebServicesWithObjects.executeRetrieveAccountDetails(params: req,
                onSuccess: { (accountDetailsResult : RetrieveAccountDetailsResult?, resultType : ResultType) in
                    if resultType == ResultType.OnlineResult || resultType == ResultType.CachedResult {

                        if nil == self.accounts {
                            self.accounts = [ServiceAccount]();
                        }

                        let acc = ServiceAccount();
                        acc.account = element;
                        acc.detail = accountDetailsResult?.retrieveAccountDetailsResponse;
                        acc.detailServices = DetailServices();
                        acc.detailServices?.accountDetail = accountDetailsResult?.retrieveAccountDetailsResponse?.accountDetails;
                        acc.detailServices?.associatedService = accountDetailsResult?.retrieveAccountDetailsResponse?.accountDetails?.associatedServices;
                        self.accounts?.append(acc);
                    }
            },
                onFailure: { (result: RetrieveAccountDetailsResult?, error) in
            })
        }
    }

//    func regresar()
//    {
//        self.navigationController?.popViewController(animated: true)
//    }
//
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //MARK: Consumir servicios
    func cargarDatosMultiples() {
        var indexAccount = 0
        guard let accountsTMP = self.accounts else {
            return
        }
        
        for account in accountsTMP {
            print("LLAMADA NUMERO \(indexAccount)")
            
            var contador = 0;
            let planCard = PlanCard()
            planCard.lineOfBusiness = account.account?.lineOfBusiness
//            planCard.tabName = tabName
            planCard.accountId = account.account?.accountId
            
            guard let services = account.detailServices?.associatedService else {
                return;
            }
            
            for service in services {
                if "2" == service.serviceType {
                    continue;
                }
                
                if ("1" == service.serviceType || "3" == service.serviceType) {
                    planCard.serviceId = service.serviceID
                    planCard.serviceType = service.serviceType
                    if account.isMovilPospagoAccount() {
                        self.getDataCycleInformation(indexAccount: indexAccount, serviceID: service.serviceID!)
                    }
                    consumeRetrieveBillDetails(index: contador, accountId: account.account!.accountId!, lob: account.account!.lineOfBusiness!, indexAccount: indexAccount);
                    contador += 1;
                } else {
                    consumeRetrieveBillDetails(index: contador, accountId: account.account!.accountId!, lob: account.account!.lineOfBusiness!, indexAccount: indexAccount);
                    contador += 1;
                }
            }
            
            indexAccount += 1
        }
        
        WebServicesWithObjects.taskGroup.notify(queue: DispatchQueue.main, execute: {
            SessionSingleton.sharedInstance.setLastRefreshDate(fecha: Date());
            self.loadMainUI();
        });
    }
    
    //Ciclo de facturación
    //MARK: Web service RetrieveCycleInformation
    func getDataCycleInformation(indexAccount: Int, serviceID: String) {
        //Crear request
        let request = RetrieveCycleInformationRequest()
        request.retrieveCycleInformation = RetrieveCycleInformation()
        request.retrieveCycleInformation?.lineOfBusiness = "3"
        request.retrieveCycleInformation?.mSISDN = serviceID
        
        WebServicesWithObjects.executeRetrieveCycleInformation(params: request, onSuccess: { (result, resultType) in
            print("Esta es la respuesta, la guardamos en la cuenta")
            self.accounts![indexAccount].retrieveCycleInformation = result.retrieveCycleInformationResponse
            
            /*let startDate = result.retrieveCycleInformationResponse?.rechargeHistory?.first?.startDate ?? ""
             let endDate = result.retrieveCycleInformationResponse?.rechargeHistory?.first?.endDate ?? ""
             let remainingDays = result.retrieveCycleInformationResponse?.rechargeHistory?.first?.remainingDays ?? 0
             
             let cycleInformation = CycleInformation()
             cycleInformation.setStartDate(date: startDate)
             cycleInformation.setEndDate(date: endDate)
             cycleInformation.setRemainingDays(days: remainingDays)*/
            
        }) { (result, error) in
            print("Error en el servicio")
        }
        
        print("Terminar servicio y actualizar")
    }
    
    /// Comienza las siguientes peticiones:  **RetrieveBillDetails**
    func consumeRetrieveBillDetails(index: Int, accountId: String, lob: String, indexAccount: Int) {
        print("INDEX RETRIEVE BILL DETAILS EN GENERICHOMEVC \(index)")
        
        if "" == accountId {
            return;
        }
        
        //TEST JONATHAN
        let accountTmp = self.accounts![indexAccount]
        //TEST JONATHAN
        
        let req = RetrieveBillDetailsRequest()
        req.retrieveBillDetails?.accountId = accountId
        req.retrieveBillDetails?.lineOfBusiness = lob;
        
        WebServicesWithObjects.executeRetrieveBillDetails(params: req,
                                                          onSuccess: { (result: RetrieveBillDetailsResult, resultType : ResultType) in
                                                            if (ResultType.EmptyDataSetResult == resultType) {
                                                                self.accounts!.first?.status = resultType
                                                            }
                                                            
                                                            let dp = DetailPlan();
                                                            dp.retrieveBillDetailsResponse = result.retrieveBillDetailsResponse;
                                                            
                                                            accountTmp.detailServices?.detailPlan?.append(dp);
                                                            
                                                            self.accounts![indexAccount].detailServices?.detailPlan?[safe: index]?.retrieveBillDetailsResponse = dp.retrieveBillDetailsResponse
                                                            
                                                            if "2" == lob || "3" == lob {
                                                                self.retreiveConsumptionDetailInformation(index: index, accountId: accountId, lob: lob, indexAccount: indexAccount)
                                                            }
                                                            
        }) { (result: RetrieveBillDetailsResult?, error) in
            self.accounts!.first?.status = ResultType.EmptyDataSetResult
            
            let dp = DetailPlan();
            dp.retrieveBillDetailsResponse = nil;
            
            if (0 == index) {
                //                accountTmp.detailServices?.detailPlan?.removeAll();
            }
            accountTmp.detailServices?.detailPlan?.append(dp);
            self.accounts![indexAccount].detailServices?.detailPlan?[safe: index]?.retrieveBillDetailsResponse = dp.retrieveBillDetailsResponse
            
            if "2" == lob || "3" == lob {
                self.retreiveConsumptionDetailInformation(index: index, accountId: accountId, lob: lob, indexAccount: indexAccount)
            }
        }
    }
    
    /// Comienza las siguientes peticiones:  **RetrieveConsumptionDetailInformation**
    func retreiveConsumptionDetailInformation(index: Int,accountId: String, lob : String, indexAccount: Int) {
        
        print("INDEX RETRIEVE BILL CONSUMPTION \(index)")
        
        //TEST JONATHAN
        let accountTmp = self.accounts![indexAccount]
        //TEST JONATHAN
        
        let session = SessionSingleton.sharedInstance.getCurrentSession();
        
        if  index >= accountTmp.detailServices!.associatedService!.count {
            return
        }
        
        guard let service = accountTmp.detailServices?.associatedService?[safe: index] else {
            return;
        }
        
        let req = RetrieveConsumptionDetailInformationRequest()
        req.retrieveConsumptionDetailInformation?.accountId = service.serviceID
        req.retrieveConsumptionDetailInformation?.lineOfBusiness = lob;
        
        req.retrieveConsumptionDetailInformation?.isTermsAndConditionsAccepted = true;
        req.retrieveConsumptionDetailInformation?.serviceId = accountTmp.detailServices?.associatedService?[safe: index]?.serviceID;
        req.retrieveConsumptionDetailInformation?.userMobileNumberforPaperless = session?.retrieveProfileInformationResponse?.contactMethods?.first?.mobileContactMethodDetail?.mobileNumber;
        req.retrieveConsumptionDetailInformation?.userEmailforPaperless = session?.retrieveProfileInformationResponse?.contactMethods?.first?.emailContactMethodDetail?.emailAddress;
        WebServicesWithObjects.executeRetrieveConsumptionDetailInformation(params: req,
                                                                           onSuccess: { (result : RetrieveConsumptionDetailInformationResult, resultType : ResultType) in
                                                                            if (ResultType.EmptyDataSetResult == resultType) {
                                                                                self.accounts!.first?.status = resultType
                                                                            }
                                                                            
                                                                            let total = accountTmp.detailServices?.detailPlan?.count ?? 0;
                                                                            
                                                                            if index >= total {
                                                                                let faltantes = index - total;
                                                                                for _ in 0...faltantes {
                                                                                    accountTmp.detailServices?.detailPlan?.append(DetailPlan());
                                                                                }
                                                                            }
                                                                            accountTmp.detailServices?.detailPlan?[safe: index]?.retrieveConsumptionDetailInformation = result.retrieveConsumptionDetailInformationResponse;
                                                                            self.accounts![indexAccount].detailServices?.detailPlan?[safe: index]?.retrieveConsumptionDetailInformation = result.retrieveConsumptionDetailInformationResponse
                                                                            
                                                                            SessionSingleton.sharedInstance.setFullAccountData(account: self.accounts!);
                                                                            
//                                                                            self.loadMainUI()
                                                                            
        }, onFailure: { (result : RetrieveConsumptionDetailInformationResult?, error : Error) in
            self.accounts!.first?.status = ResultType.EmptyDataSetResult
            accountTmp.detailServices?.detailPlan?[safe: index]?.retrieveConsumptionDetailInformation = nil
            self.accounts![indexAccount].detailServices?.detailPlan?[safe: index]?.retrieveConsumptionDetailInformation = nil
        });
    }

}

public class ServiceAccount : NSObject, Mappable {

    var status : ResultType?
    var account : AssociatedAccountList?
    var detail : RetrieveAccountDetailsResponse?
    var detailServices : DetailServices?
    var retrieveCycleInformation: RetrieveCycleInformationResponse?

    override init() {
        super.init();
    }

    required public init?(map: Map) {
        super.init();
    }

    public func mapping(map: Map)
    {
        account <- map["Account"];
        detail <- map["RetrieveAccountDetailsResponse"];
        detailServices <- map["DetailServices"];
        retrieveCycleInformation <- map["RetrieveCycleInformationResponse"]
    }
}

extension ServiceAccount {
    func isTodoClaro() -> Bool {
        if let lineOfBusiness = account?.lineOfBusiness, lineOfBusiness == "1", let qtyAssociatedServices = self.detailServices?.associatedService?.count, qtyAssociatedServices > 1 {
            if let services = (self.detailServices?.associatedService?.filter { $0.serviceType! == "3" || $0.serviceType! == "4" || $0.serviceType! == "5" }) {
                var servicesTypes : [String] = []
                for service in services {
                    if !servicesTypes.contains(service.serviceType!) {
                        servicesTypes.append(service.serviceType!)
                    }
                }
                return servicesTypes.count > 1
            }
        }
        return false
    }
    func getIndexForAssociatedService() -> (isTodoClaro : Bool , majorService : String?) {
        var sortedDetails = self.detailServices?.associatedService
        if !self.isTodoClaro() {
            sortedDetails?.removeAll()
            let movils = self.detailServices!.associatedService!.filter({ $0.serviceType == "1" })
            sortedDetails?.append(contentsOf: movils)
            //let others = self.detailServices!.associatedService!.filter({ $0.serviceType == "2" })
            let dedicated = self.detailServices!.associatedService!.filter({ $0.serviceType == "3" })
            sortedDetails?.append(contentsOf: dedicated)
            let tv = self.detailServices!.associatedService!.filter({ $0.serviceType == "4" })
            sortedDetails?.append(contentsOf: tv)
            let internet = self.detailServices!.associatedService!.filter({ $0.serviceType == "5" })
            sortedDetails?.append(contentsOf: internet)
        }
        return (isTodoClaro: self.isTodoClaro(), majorService: sortedDetails!.first?.serviceType)
    }
    
    func isMovilPospagoAccount() -> Bool {
        var isPospago: Bool = false
        if (account?.lineOfBusiness == "3") {
            if detailServices?.associatedService?.first?.serviceType == "1" {
                isPospago = true
            }
        }
        
        return isPospago
    }
    
    func isMovilPrepagoAccount() -> Bool {
        var isPrepago: Bool = false
        if (account?.lineOfBusiness == "2") {
            if detailServices?.associatedService?.first?.serviceType == "1" {
                isPrepago = true
            }
        }
        
        return isPrepago
    }
}

public class DetailServices : NSObject, Mappable {

    var accountDetail : AccountDetail?
    var associatedService : [AssociatedService]?
    var detailPlan : [DetailPlan]?

    override init() {
        super.init();
        setup();
    }

    required public init?(map: Map) {
        super.init();
        setup();
    }

    private func setup() {
        accountDetail = AccountDetail();
        detailPlan = [DetailPlan]();
        associatedService = [AssociatedService]();
    }

    public func mapping(map: Map)
    {
        accountDetail <- map["AccountDetail"];
        associatedService <- map["AssociatedService"]
        detailPlan <- map["DetailPlan"]
    }
}

public class DetailPlan : NSObject, Mappable {
    var retrieveBillDetailsResponse : RetrieveBillDetailsResponse?
    var retrieveConsumptionDetailInformation : RetrieveConsumptionDetailInformationResponse?

    override init() {
        super.init();
        retrieveBillDetailsResponse = nil;
        retrieveConsumptionDetailInformation = nil;
    }

    required public init?(map: Map) {
        super.init();
        retrieveBillDetailsResponse = nil;
        retrieveConsumptionDetailInformation = nil;
    }

    public func mapping(map: Map)
    {
        retrieveBillDetailsResponse <- map["RetrieveBillDetailsResponse"]
        retrieveConsumptionDetailInformation <- map["RetrieveConsumptionDetailInformationResponse"]
    }
}
