//
//  HomeManagementViewController.swift
//  MiClaro
//
//  Created by Jonathan Abimael Cruz Orozco on 10/07/18.
//  Copyright © 2018 am. All rights reserved.
//

import UIKit

class HomeManagementViewController: UIViewController {

    /*********************** Componentes de la interfaz ***********************/
    private var scrollContent: UIScrollView!
    private var pullToRefresh: UIRefreshControl!
    private var bkgAccountArray : [ServiceAccount]?

    private var viewHeaderHome: HomeHeaderView!
    private var viewContainerServiceDetail: HomeContainerServiceView!
    private var viewTitlePromotion: HomeTitleView!
    private var viewContainerPromo: HomeContainerPromo!
    private var viewTitleMoreOptions: HomeTitleView!
    private var viewContainerOptionMenu: HomeContainerOptionMenu!
    /*********************** Componentes de la interfaz ***********************/
    /*********************** Constantes ***********************/
    let textConfiguration = SessionSingleton.sharedInstance.getGeneralConfig()
    /*********************** Constantes ***********************/
    /*********************** Variables ***********************/
    private var arrayServiceAccount: [ServiceAccount] = []
    private var arrayServiceDetail: [HomeServiceDetailModel] = []
    private var arrayPromos: [Promos] = []
    /*********************** Variables ***********************/
    
    /*********************** Textos de la interfaz ***********************/
    private var textPromo: String = ""
    private var textPromoDescriptions: String = ""
    private var textMoreOptions: String = ""
    private var textOptionsDescriptions: String = ""
    var textProfile: String = ""
    private var textProfileDescription: String = ""
    var textMyServices: String = ""
    private var textServicesDescription: String = ""
    /*********************** Textos de la interfaz ***********************/
    
    var refreshAccounts: Bool = false
    
    
    // MARK: - ViewControlelr Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        showUpdateAlertView()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.setTextUI()
        self.createInterface()
        //Con esto hacemos que las opciones del menú se muestren
         NotificationCenter.default.post(name: Notification.Name("refreshTipoPago"), object: nil);
        //Add observers
        NotificationCenter.default.addObserver(self, selector: #selector(self.refreshDataAccount(notification:)), name: Notification.Name("pullToRefresh"), object: nil)
        
         AnalyticsInteractionSingleton.sharedInstance.ADBTrackView(viewName: "Home", detenido: false)
        
        if self.hasUserOnlyPrepaidAccount() {
            let user = SessionSingleton.sharedInstance
            user.setUserOnlyPrepaidAccount(onlyPrepaid: true)
            NotificationCenter.default.post(name: NSNotification.Name("onlyPrepaidAccount"), object: nil);
        }
        if refreshAccounts {
            self.refreshInfo(refresh: self.pullToRefresh)
        }


    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated);

        NotificationCenter.default.removeObserver(self, name: Notification.Name("pullToRefresh"), object: nil)
    }

    init(frame: CGRect, services: [ServiceAccount]) {
        super.init(nibName: nil, bundle: nil)
        self.view.frame = frame
        self.arrayServiceAccount = services
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        print("SE SALIO DE LA VISTA HOME")
        for viewTmp in self.view.subviews {
            viewTmp.removeFromSuperview()
        }
    }
    
    private func setTextUI() {
        self.textPromo = self.textConfiguration?.translations?.data?.home?.promo ?? ""
        self.textPromoDescriptions = self.textConfiguration?.translations?.data?.home?.promoDescriptions ?? ""
        self.textMoreOptions = self.textConfiguration?.translations?.data?.home?.moreOptions ?? ""
        self.textOptionsDescriptions = self.textConfiguration?.translations?.data?.home?.optionsDescriptions ?? ""
        self.textProfile = self.textConfiguration?.translations?.data?.profile?.title ?? ""
        self.textProfileDescription = self.textConfiguration?.translations?.data?.home?.profileDescription ?? ""
        self.textMyServices = self.textConfiguration?.translations?.data?.generales?.myService ?? ""
        self.textServicesDescription = self.textConfiguration?.translations?.data?.home?.servicesDescription ?? ""
        
    }
    
    @objc private func createInterface() {
        let widhtView = self.view.bounds.width
        //Crear scroll
        if nil == self.scrollContent {
            self.scrollContent = UIScrollView(frame: self.view.frame)
        }

        if nil == self.pullToRefresh {
            self.pullToRefresh = UIRefreshControl()
        }
        self.pullToRefresh.addTarget(self, action: #selector(self.refreshInfo), for: .valueChanged)
        if let last = SessionSingleton.sharedInstance.getLastRefreshDate() {
            let date = getStringDateTime(date: last)
            self.pullToRefresh.attributedTitle = NSAttributedString(string: String(format: "Última actualización: %@", date))
        }
        if false == self.scrollContent.subviews.contains(where: { return $0 == self.pullToRefresh }) {
            self.scrollContent.addSubview(self.pullToRefresh)
        }

        self.scrollContent.backgroundColor = institutionalColors.claroGrayNavColor
        if false == self.view.subviews.contains(where: { return $0 == self.scrollContent }) {
            self.view.addSubview(self.scrollContent)
        }
        //Agregar el header
        let frameHeader = CGRect(x: 0, y: 10, width: widhtView, height: 180)
        self.viewHeaderHome = HomeHeaderView(frame: frameHeader)
        if false == self.scrollContent.subviews.contains(where: { return $0 == self.viewHeaderHome }) {
            self.scrollContent.addSubview(self.viewHeaderHome)
        }
        self.viewHeaderHome.setNameUser()
        //Agregar detalle de servicios
        let heightContainerServiceDetail = self.getHeightContainerServiceView()
        let frameContainer = CGRect(x: 0, y: self.viewHeaderHome.frame.maxY, width: widhtView, height: heightContainerServiceDetail)
        if nil == self.viewContainerServiceDetail {
            self.viewContainerServiceDetail = HomeContainerServiceView(frame: frameContainer)
        }

        if false == self.scrollContent.subviews.contains(where: { return $0 == self.viewContainerServiceDetail}) {
            self.scrollContent.addSubview(self.viewContainerServiceDetail)
        }

        self.viewContainerServiceDetail.setDataHomeServiceDetail(arrayHomeServices: self.arrayServiceDetail)
        self.viewContainerServiceDetail.delegate = self
        //Agregar titulo de promocion
        let frameTitlePromotion = CGRect(x: 0, y: self.viewContainerServiceDetail.frame.maxY, width: widhtView, height: 90)
        if nil == self.viewTitlePromotion {
            self.viewTitlePromotion = HomeTitleView(frame: frameTitlePromotion)
        }

        if false == self.scrollContent.subviews.contains(where: { return $0 == self.viewTitlePromotion }) {
            self.scrollContent.addSubview(self.viewTitlePromotion)
        }
        self.viewTitlePromotion.setDataText(title: self.textPromo, subtitle: self.textPromoDescriptions)
        //Agregar contenedor de promociones
        let heightContainerPromo = self.getHeightContainerPromo()
        let frameContainerPromo = CGRect(x: 0, y: self.viewTitlePromotion.frame.maxY, width: widhtView, height: heightContainerPromo)
        if nil == self.viewContainerPromo {
            self.viewContainerPromo = HomeContainerPromo(frame: frameContainerPromo)
        }

        if false == self.scrollContent.subviews.contains(where: { return $0 == self.viewContainerPromo }) {
            self.scrollContent.addSubview(self.viewContainerPromo)
        }
        self.viewContainerPromo.setDataPromos(arrayPromos: self.arrayPromos)
        self.viewContainerPromo.delegate = self
        //Agregar titulo de mas opciones
        let frameTitleMoreOptions = CGRect(x: 0, y: self.viewContainerPromo.frame.maxY, width: widhtView, height: 90)
        if nil == self.viewTitleMoreOptions {
            self.viewTitleMoreOptions = HomeTitleView(frame: frameTitleMoreOptions)
        }

        if false == self.scrollContent.subviews.contains(where: { return $0 == self.viewTitleMoreOptions }) {
            self.scrollContent.addSubview(self.viewTitleMoreOptions)
        }
        self.viewTitleMoreOptions.setDataText(title: self.textMoreOptions, subtitle: self.textOptionsDescriptions )
        //Agregar opciones tipo menu (Celdas inferiores)
        let heightContainerOptionMenu = self.getHeightContainerMenuOption()
        let frameContainerOptionMenu = CGRect(x: 0, y: self.viewTitleMoreOptions.frame.maxY, width: widhtView, height: heightContainerOptionMenu)
        if nil == self.viewContainerOptionMenu {
            self.viewContainerOptionMenu = HomeContainerOptionMenu(frame: frameContainerOptionMenu)
        }

        if false == self.scrollContent.subviews.contains(where: { return $0 == self.viewContainerOptionMenu }) {
            self.scrollContent.addSubview(self.viewContainerOptionMenu)
        }
        self.viewContainerOptionMenu.addOptionsMenu()
        self.viewContainerOptionMenu.delegate = self
        
        self.updateHeightScroll()
        
//        let actionType = SessionSingleton.sharedInstance.getActionType() ?? -1
//        if(SessionSingleton.sharedInstance.getDigitalBirth()! && actionType == 0){
        if(showModal){
            self.showModalView()
        }
    }

    private func hasUserOnlyPrepaidAccount() -> Bool {
        var isOnlyAccountPrepaid: Bool = true
        
        //Para identificar si existen solo cuentas de prepago
        for service in self.arrayServiceDetail {
            if service.typeAccount != .MovilPrepago {
                isOnlyAccountPrepaid = false
            }
        }
        
        return isOnlyAccountPrepaid
    }
    
    func showModalView(){
        let modalController = DigitalBornViewController()
        modalController.view.bounds = self.view.bounds
        modalController.delegate = self
        modalController.modalPresentationStyle = .overFullScreen
        self.present(modalController, animated: true, completion: nil)
    }
    
    /// Realizar el pull to refresh
    /// - Parameter refresh: refresh control
    @objc private func refreshInfo(refresh: UIRefreshControl) {
        if SessionSingleton.sharedInstance.shouldRefresh() || refreshAccounts {
            //Volver a llamar los servicios
            print("REFRESH SERVICES CARDS")
            let tabActual = "HOME";
            DispatchQueue.main.async {
                self.pullToRefresh.beginRefreshing()
            }
            NotificationCenter.default.post(name: Notification.Name("pullToRefresh"), object: nil, userInfo:["tabName":tabActual, "refreshObject" : refresh])
        } else {
            DispatchQueue.main.async {
                refresh.endRefreshing()
            }
            if let last = SessionSingleton.sharedInstance.getLastRefreshDate() {
                let date = getStringDateTime(date: last)
                refresh.attributedTitle = NSAttributedString(string: String(format: "Última actualización: %@", date))
            }
        }
    }

    func refreshDataAccount(notification: Notification) {
        if SessionSingleton.sharedInstance.shouldRefresh() || refreshAccounts {
            let nameTab = notification.userInfo!["tabName"] as! String
            print("REALOAD DATA IN THIS TAB \(nameTab)")

            self.bkgAccountArray = [ServiceAccount]();
            print("Iniciando clonación");
            for item in self.arrayServiceAccount {
                if let i = ServiceAccount(JSON: item.toJSON()) {
                    self.bkgAccountArray?.append(i);
                }
            }
            print("Clonación terminada");
            SessionSingleton.sharedInstance.setLastRefreshDate(fecha: Date());
            DispatchQueue.main.async {
                self.cargaDatos()
            }
        } else {
            DispatchQueue.main.async {
                self.pullToRefresh?.endRefreshing()
            }
            if let last = SessionSingleton.sharedInstance.getLastRefreshDate() {
                let date = getStringDateTime(date: last)
                self.pullToRefresh?.attributedTitle = NSAttributedString(string: String(format: "Última actualización: %@", date))
            }
        }
    }

    @objc private func cargaDatos() {
        self.arrayServiceAccount.first?.status = ResultType.OnlineResult
        self.cargarDatosMultiples()
        DispatchQueue.main.async {
            self.pullToRefresh?.endRefreshing()
        }

        WebServicesWithObjects.taskGroup.notify(queue: DispatchQueue.main, execute: {
            SessionSingleton.sharedInstance.isConsumingService(state: false);
            SessionSingleton.sharedInstance.setLastRefreshDate(fecha: Date());
            self.createInterface()
        })
    }

    //TEST
    func cargarDatosMultiples() {
        var indexAccount = 0
        if refreshAccounts {
            refreshAccounts = false
        }
        for account in self.arrayServiceAccount {
            print("LLAMADA NUMERO \(indexAccount)")
            
            var contador = 0;

            guard let services = account.detailServices?.associatedService else {
                return;
            }

            for service in services {
                if "2" == service.serviceType {
                    continue;
                }

                if ("1" == service.serviceType || "3" == service.serviceType) {
                    consumeRetrieveBillDetails(index: contador, accountId: account.account!.accountId!, lob: account.account!.lineOfBusiness!, indexAccount: indexAccount);
                    contador += 1;
                } else {
                    consumeRetrieveBillDetails(index: contador, accountId: account.account!.accountId!, lob: account.account!.lineOfBusiness!, indexAccount: indexAccount);
                    contador += 1;
                }
            }

            indexAccount += 1
        }
        
    }
    
    
    //TEST

    /// Comienza las siguientes peticiones:  **RetrieveBillDetails**
    func consumeRetrieveBillDetails(index: Int, accountId: String, lob: String, indexAccount: Int) {
        print("INDEX RETRIEVE BILL DETAILS EN GENERICHOMEVC \(index)")

        if "" == accountId {
            return;
        }

        //TEST JONATHAN
        let accountTmp = self.arrayServiceAccount[indexAccount]
        //TEST JONATHAN

        let req = RetrieveBillDetailsRequest()
        req.retrieveBillDetails?.accountId = accountId
        req.retrieveBillDetails?.lineOfBusiness = lob;

        WebServicesWithObjects.executeRetrieveBillDetails(params: req,
                                                          onSuccess: { (result: RetrieveBillDetailsResult, resultType : ResultType) in
                                                            if (ResultType.EmptyDataSetResult == resultType) {
                                                                self.arrayServiceAccount.first?.status = resultType
                                                            }

                                                            let dp = DetailPlan();
                                                            dp.retrieveBillDetailsResponse = result.retrieveBillDetailsResponse;

                                                            accountTmp.detailServices?.detailPlan?.append(dp);

                                                            self.arrayServiceAccount[indexAccount].detailServices?.detailPlan?[safe: index]?.retrieveBillDetailsResponse = dp.retrieveBillDetailsResponse

                                                            if "2" == lob || "3" == lob {
                                                                self.retreiveConsumptionDetailInformation(index: index, accountId: accountId, lob: lob, indexAccount: indexAccount)
                                                            }

        }) { (result: RetrieveBillDetailsResult?, error) in
            self.arrayServiceAccount.first?.status = ResultType.EmptyDataSetResult

            let dp = DetailPlan();
            dp.retrieveBillDetailsResponse = nil;

            if (0 == index) {
                //                accountTmp.detailServices?.detailPlan?.removeAll();
            }
            accountTmp.detailServices?.detailPlan?.append(dp);
            self.arrayServiceAccount[indexAccount].detailServices?.detailPlan?[safe: index]?.retrieveBillDetailsResponse = dp.retrieveBillDetailsResponse

            if "2" == lob || "3" == lob {
                self.retreiveConsumptionDetailInformation(index: index, accountId: accountId, lob: lob, indexAccount: indexAccount)
            }
        }
    }

    /// Comienza las siguientes peticiones:  **RetrieveConsumptionDetailInformation**
    func retreiveConsumptionDetailInformation(index: Int,accountId: String, lob : String, indexAccount: Int) {

        print("INDEX RETRIEVE BILL CONSUMPTION \(index)")

        //TEST JONATHAN
        let accountTmp = self.arrayServiceAccount[indexAccount]
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
                                                                                self.arrayServiceAccount.first?.status = resultType
                                                                            }

                                                                            let total = accountTmp.detailServices?.detailPlan?.count ?? 0

                                                                            if index >= total {
                                                                                let faltantes = index - total;
                                                                                for _ in 0...faltantes {
                                                                                    accountTmp.detailServices?.detailPlan?.append(DetailPlan());
                                                                                }
                                                                            }

                                                                            //                do {
                                                                            accountTmp.detailServices?.detailPlan?[safe: index]?.retrieveConsumptionDetailInformation = result.retrieveConsumptionDetailInformationResponse;
                                                                            //                    accountTmp.detailServices?.detailPlan?[index].retrieveConsumptionDetailInformation = result.retrieveConsumptionDetailInformationResponse
                                                                            //                }catch {
                                                                            //
                                                                            //                }
                                                                            self.arrayServiceAccount[indexAccount].detailServices?.detailPlan?[safe: index]?.retrieveConsumptionDetailInformation = result.retrieveConsumptionDetailInformationResponse

                                                                            SessionSingleton.sharedInstance.setFullAccountData(account: self.arrayServiceAccount);

        }, onFailure: { (result : RetrieveConsumptionDetailInformationResult?, error : Error) in
            self.arrayServiceAccount.first?.status = ResultType.EmptyDataSetResult
            accountTmp.detailServices?.detailPlan?[safe: index]?.retrieveConsumptionDetailInformation = nil
            self.arrayServiceAccount[indexAccount].detailServices?.detailPlan?[safe: index]?.retrieveConsumptionDetailInformation = nil
        });
    }

    //Altura dinamica acorde a los objetos que cotiene la vista contenedora
    private func updateHeightScroll() {
        self.scrollContent.contentSize = CGSize(width: self.view.bounds.width, height: self.viewContainerOptionMenu.frame.maxY)
    }
    
    private func getHeightContainerServiceView() -> CGFloat {
        let serviceManagement = AccountManagement(arrayServices: self.arrayServiceAccount)
        serviceManagement.filterHomeServiceDetail()
        self.arrayServiceDetail = serviceManagement.getHomeServiceData()
        var heightView: CGFloat = 160.0
        for _ in self.arrayServiceDetail {
            heightView += 80
        }
        return heightView
    }
    
    private func getHeightContainerPromo() -> CGFloat {
        var heightView: CGFloat = 0.0
        let conf = SessionSingleton.sharedInstance.getGeneralConfig()
        if let promos = conf?.homePromo?.promos {
            self.arrayPromos = promos
            for _ in self.arrayPromos {
                heightView += 140
            }
        }
        
        return heightView
    }
    
    private func getHeightContainerMenuOption()  -> CGFloat {
        return 315
    }
    //MARK: Funciones "GO"
    func goToAgendarCAC(){
        let nav = UINavigationController(rootViewController: ScheduleCACVC());
        nav.navigationBar.layer.shadowColor = institutionalColors.claroLightGrayColor.cgColor;
        nav.navigationBar.layer.shadowOpacity = 0.8;
        nav.navigationBar.layer.shadowOffset = CGSize(width: 0, height: 2);
        nav.navigationBar.layer.shadowRadius = 2;
        self.so_containerViewController?.topViewController = nav;
    }
    
    func goToServicesAccount() {
        AnalyticsInteractionSingleton.sharedInstance.ADBTrackCustomLink(viewName: "Home:Mis servicios")
        let pagerTabMenu = PagerTabMenuVC();
        pagerTabMenu.tabDataSource = SessionSingleton.sharedInstance.getFullAccountData()
        pagerTabMenu.associatedAccountList = nil
        pagerTabMenu.accountDetailList = nil
        let nav = UINavigationController(rootViewController: pagerTabMenu/*EditarPerfilVC()*/);
        nav.navigationBar.layer.shadowColor = institutionalColors.claroLightGrayColor.cgColor;
        nav.navigationBar.layer.shadowOpacity = 0.8;
        nav.navigationBar.layer.shadowOffset = CGSize(width: 0, height: 2);
        nav.navigationBar.layer.shadowRadius = 2;
        self.so_containerViewController?.topViewController = nav;
    }
    
    func identifyTypeAccountTab(typeAccount: TypeAccountService) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let tabAccount = ["TypeAccount": typeAccount]
            NotificationCenter.default.post(name: Notification.Name("detailInformation"), object: nil, userInfo:  tabAccount)
        }
        
    }
    
    func goToProfile() {
        AnalyticsInteractionSingleton.sharedInstance.ADBTrackCustomLink(viewName: "Home:Mi perfil")
        let nav = UINavigationController(rootViewController: EditarPerfilVC());
        nav.navigationBar.layer.shadowColor = institutionalColors.claroLightGrayColor.cgColor;
        nav.navigationBar.layer.shadowOpacity = 0.8;
        nav.navigationBar.layer.shadowOffset = CGSize(width: 0, height: 2);
        nav.navigationBar.layer.shadowRadius = 2;
        self.so_containerViewController?.topViewController = nav;
        
        self.removeGestureMenuLateral(nav: nav)

    }
    
    func goToPayBoleta(webID: String) {
        AnalyticsInteractionSingleton.sharedInstance.ADBTrackCustomLink(viewName: "Home:Pagar boleta")
        if false == SessionSingleton.sharedInstance.isNetworkConnected() {
            NotificationCenter.default.post(name: Observers.ObserverList.ShowOfflineMessage.name, object: nil);
            return;
        }
        
        let webView = GenericWebViewVC()
        webView.fromMenu = true
        webView.serviceSelected = webID
        let nav = UINavigationController(rootViewController: webView);
        nav.navigationBar.layer.shadowColor = institutionalColors.claroLightGrayColor.cgColor;
        nav.navigationBar.layer.shadowOpacity = 0.8;
        nav.navigationBar.layer.shadowOffset = CGSize(width: 0, height: 2);
        nav.navigationBar.layer.shadowRadius = 2;
        self.so_containerViewController?.topViewController = nav
        
        self.removeGestureMenuLateral(nav: nav)

    }
    
    //For digital born
    func goToReload() {
        if false == SessionSingleton.sharedInstance.isNetworkConnected() {
            NotificationCenter.default.post(name: Observers.ObserverList.ShowOfflineMessage.name, object: nil);
            return;
        }
        
        let webView = GenericWebViewVC()
        webView.fromMenu = true
        webView.serviceSelected = "reload"
        
        let nav = UINavigationController(rootViewController: webView);
        nav.navigationBar.layer.shadowColor = institutionalColors.claroLightGrayColor.cgColor;
        nav.navigationBar.layer.shadowOpacity = 0.8;
        nav.navigationBar.layer.shadowOffset = CGSize(width: 0, height: 2);
        nav.navigationBar.layer.shadowRadius = 2;
        self.so_containerViewController?.topViewController = nav;
        
        self.removeGestureMenuLateral(nav: nav)
    }
    
    func goToPrepaidRegister() {
        let nav = UINavigationController(rootViewController: AddPrepaidStep1VC());
        nav.navigationBar.layer.shadowColor = institutionalColors.claroLightGrayColor.cgColor;
        nav.navigationBar.layer.shadowOpacity = 0.8;
        nav.navigationBar.layer.shadowOffset = CGSize(width: 0, height: 2);
        nav.navigationBar.layer.shadowRadius = 2;
        self.so_containerViewController?.topViewController = nav;
        
        self.removeGestureMenuLateral(nav: nav)

    }
    
    func removeGestureMenuLateral(nav: UINavigationController){
        if(SessionSingleton.sharedInstance.getDigitalBirth()! || showModal){
            for recognizer in (nav.view.gestureRecognizers!) {
                nav.view.removeGestureRecognizer(recognizer)
            }
        }
    }
}
//MARK: Extensiones de Clases
extension HomeManagementViewController: HomeContainerPromoDelegate {
    func showPromotionWeb(url: String) {
        if let url = URL(string: url) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:])
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
}

extension HomeManagementViewController: HomeContainerOptionMenuDelegate {
    func showSectionOptionView(nameSection: String) {
        if nameSection == self.textProfile {
            self.goToProfile()
        }else if nameSection == self.textMyServices {
            self.goToServicesAccount()
        }
       if nameSection ==  "Agendar Hora" {
            self.goToAgendarCAC()
        }
    }
}

//self.textServicesDescriptionCAC = "Agenda y revisa citas en sucursal"


extension HomeManagementViewController: HomeContainerServiceViewDelegate {
    func payBoleta(webID: String) {
        self.goToPayBoleta(webID: webID)
    }
    
    func showDetailAccount(typeAccount: TypeAccountService) {
        switch typeAccount {
        case .MovilPospago, .MovilPrepago:
             AnalyticsInteractionSingleton.sharedInstance.ADBTrackCustomLink(viewName: "Home:Movil:Ver detalle")
            break
        case .Internet:
            AnalyticsInteractionSingleton.sharedInstance.ADBTrackCustomLink(viewName: "Home:Internet:Ver detalle")
            break
        case .Television:
            AnalyticsInteractionSingleton.sharedInstance.ADBTrackCustomLink(viewName: "Home:Television:Ver detalle")
            break
        default:
            break
        }
       
        self.goToServicesAccount()
        self.identifyTypeAccountTab(typeAccount: typeAccount)
    }
}

extension HomeManagementViewController: DigitalBornViewDelegate {
    func pressProfileUser() {
        self.goToProfile()
    }
    func pressReload() {
        self.goToReload()
    }
    
    func pressPrepaidRegister() {
        self.goToPrepaidRegister()
    }
}
