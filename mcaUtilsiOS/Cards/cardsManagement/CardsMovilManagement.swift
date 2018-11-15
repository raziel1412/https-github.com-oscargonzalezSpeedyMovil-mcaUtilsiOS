//
//  CardsMovilManagement.swift
//  MiClaro
//
//  Created by Jonathan Abimael Cruz Orozco on 27/06/18.
//  Copyright © 2018 am. All rights reserved.
//

import UIKit

enum TypeDetailPlan {
    case None
    case Graphic
    case Table
    case Text
    case SinBolsa
}

class CardsMovilManagement: UIViewController {

    /*********************** Variables ***********************/
    var arrayMovilData: [CardsMovilModel] = []
    var indexAccountSelected: Int = 0
    var typeDetailPlan: TypeDetailPlan = .Graphic
    private var pullToRefresh: UIRefreshControl!
    private var numberPhonePreSelect: String = ""
    /*********************** Variables ***********************/
    
    /*********************** Constantes ***********************/
    let constantTopHeightTabBar: CGFloat = 100.0
    let constantBottomHeightTabBar: CGFloat = 100.0
    let textConfiguration = SessionSingleton.sharedInstance.getGeneralConfig()
    /*********************** Constantes ***********************/
    
    /*********************** Componentes de la interfaz ***********************/
    private var scrollContent: UIScrollView!
    private var viewSelectService: CardSelectServiceView!
    private var viewBalance: CardBalanceView!
    private var viewButtonBoleta: CardButtonBoletaView!
    private var viewHeaderPlan: CardHeaderServiceView!
    private var viewTitleDetailPlan: CardTitleSummaryPlan!
    private var viewContentGraphic: CardContentDetailGraphic!
    /*********************** Componentes de la interfaz ***********************/
    
    /*********************** Textos de la interfaz ***********************/
    private var textNumberLine: String = ""
    private var textLineResume: String = ""
    var textMobile: String = ""
    /*********************** Textos de la interfaz ***********************/
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.createInterface()
        self.updateDataServiceSelected()
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1136:
                self.scrollContent.frame = CGRect(x: self.scrollContent.frame.origin.x, y: self.scrollContent.frame.origin.y, width: self.scrollContent.frame.size.width, height: self.scrollContent.frame.size.height - self.constantBottomHeightTabBar)
                print("iPhone 5 or 5S or 5C")
            case 1334:
                self.scrollContent.frame = CGRect(x: self.scrollContent.frame.origin.x, y: self.scrollContent.frame.origin.y, width: self.scrollContent.frame.size.width, height: self.scrollContent.frame.size.height - self.constantBottomHeightTabBar)
                print("iPhone 6/6S/7/8")
            case 1920, 2208:
                self.scrollContent.frame = CGRect(x: self.scrollContent.frame.origin.x, y: self.scrollContent.frame.origin.y, width: self.scrollContent.frame.size.width, height: self.scrollContent.frame.size.height - self.constantBottomHeightTabBar)
                print("iPhone 6+/6S+/7+/8+")
            case 2436:
                if #available(iOS 11.0, *) {
                    self.scrollContent.frame = CGRect(x: self.scrollContent.frame.origin.x, y: self.scrollContent.frame.origin.y, width: self.scrollContent.frame.size.width, height: (self.scrollContent.frame.size.height - self.constantBottomHeightTabBar - (UIApplication.shared.keyWindow?.safeAreaInsets.bottom)! - 10))
                }
                print("iPhone X, Xs")
            case 2688:
                print("iPhone Xs Max")
            case 1792:
                print("iPhone Xr")
            default:
                self.scrollContent.frame = CGRect(x: self.scrollContent.frame.origin.x, y: self.scrollContent.frame.origin.y, width: self.scrollContent.frame.size.width, height: self.scrollContent.frame.size.height - self.constantBottomHeightTabBar)
                print("unknown")
            }
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        print("SE SALIO DE LA VISTA DE CARDS MOVIL")
        for viewTmp in self.view.subviews {
            viewTmp.removeFromSuperview()
        }
    }
    
    init(frame: CGRect, services: [CardsMovilModel], phonePreselect: String = "") {
        super.init(nibName: nil, bundle: nil)
        self.view.frame = frame
        self.setPreSelectPhone(phone: phonePreselect)
        self.arrayMovilData = services
        //self.getDataCycleInformation()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    ///Obtener los textos a mostrar
    private func setTextUI() {
        self.textLineResume = self.textConfiguration?.translations?.data?.generales?.lineResume ?? ""
        self.textNumberLine = self.textConfiguration?.translations?.data?.generales?.lineNumber ?? ""
        self.textMobile = self.textConfiguration?.translations?.data?.generales?.mobile ?? ""
    }
    
    func setPreSelectPhone(phone: String) {
        self.numberPhonePreSelect = phone
    }
    
    /// Crear la interfaz
    private func createInterface() {
        //En caso de haber seleccionado un numero movil desde la seccion resumen
        self.setIndexPhonePreselect()
        //Obtener los textos
        self.setTextUI()
        //Crear pull torefresh
        self.pullToRefresh = UIRefreshControl()
        self.pullToRefresh.addTarget(self, action: #selector(self.refreshInfo), for: .valueChanged)
        
        if let last = SessionSingleton.sharedInstance.getLastRefreshDate() {
            let date = getStringDateTime(date: last)
            self.pullToRefresh.attributedTitle = NSAttributedString(string: String(format: "Última actualización: %@", date))
        }
        //Crear scroll
        self.scrollContent = UIScrollView(frame: self.view.frame)
        self.scrollContent.backgroundColor = institutionalColors.claroGrayNavColor
        self.scrollContent.addSubview(self.pullToRefresh)
        self.view.addSubview(self.scrollContent)
        
        let movilData = self.arrayMovilData[self.indexAccountSelected]
        let widthView = self.view.bounds.width
        
        /***********************Agregar el view selector de servicio**********************+*/
        let frameViewSelect = CGRect(x: 0, y: 10, width: widthView, height: 90)
        self.viewSelectService = CardSelectServiceView(frame: frameViewSelect)
        self.viewSelectService.delegate = self
        self.scrollContent.addSubview(self.viewSelectService)
        /***********************Agregar el view con el nombre del plan**********************/
        let frameHeaderService = CGRect(x: 0, y: self.viewSelectService.frame.maxY, width: widthView, height: 80)
        self.viewHeaderPlan = CardHeaderServiceView(frame: frameHeaderService)
        self.viewHeaderPlan.upgradePlanDelegate = self;
        self.scrollContent.addSubview(self.viewHeaderPlan)
        /************************Agregar el view de saldo***********************************/
        let frameViewBalance = CGRect(x: 0, y: self.viewHeaderPlan.frame.maxY, width: widthView, height: 120)
        self.viewBalance = CardBalanceView(frame: frameViewBalance)
        self.scrollContent.addSubview(self.viewBalance)
        self.viewBalance.delegate = self
        self.viewBalance.viewBorder.addBottomGrecas()
        
        let posYDetailPlan: CGFloat = self.viewBalance.frame.maxY
        /************************Agregar el view con los botones de boleta*******************/
        /*NOTA: CAMBIO DE ULTIMO MOMENTO, SE DECIDIO QUE YA NUNCA SE IBAN A MOSTRAR LOS BOTONES DE BOLETA SOLO PARA EL CASO DE MOVIL*/
        /*switch movilData.typeAccount {
        case .MovilPospago, .Television:
            let frameBoletas = CGRect(x: 0, y: self.viewBalance.frame.maxY, width: widthView, height: 110)
            self.viewButtonBoleta = CardButtonBoletaView(frame: frameBoletas)
            self.scrollContent.addSubview(self.viewButtonBoleta)
            posYDetailPlan = self.viewButtonBoleta.frame.maxY
            self.viewButtonBoleta.viewBorder.addBottomGrecas()
            self.viewBalance.deleteBottomGrecas()
            break
        default:
            break
        }*/
        /*FIN DE LA NOTA*/
        /************************Agregar el view con el titulo del detalle o resumen del plan*******/
        let frameTitleDetail = CGRect(x: 0, y: posYDetailPlan, width: widthView, height: 50)
        self.viewTitleDetailPlan = CardTitleSummaryPlan(frame: frameTitleDetail)
        self.scrollContent.addSubview(self.viewTitleDetailPlan)
        self.viewTitleDetailPlan.setTitle(title: self.textLineResume)
        /************************Agregar el view contenedor de las graficas y detalle del plan*******/
        let frameContentGraphic = CGRect(x: 0, y: self.viewTitleDetailPlan.frame.maxY, width: widthView, height: 300)
        self.viewContentGraphic = CardContentDetailGraphic(frame: frameContentGraphic, typeAccount: movilData.typeAccount)
        self.scrollContent.addSubview(self.viewContentGraphic)
        let dataGraphic = movilData.arrayDataGraphic
        var cycleFacturation: CycleInformation?
        if movilData.cycleInformation != nil {
            cycleFacturation = movilData.cycleInformation
        }
        self.viewContentGraphic.setDataGraphics(dataGraohic: dataGraphic, facturationData: cycleFacturation)
        self.viewContentGraphic.showSaldoSection(showSaldo: movilData.showSaldoSection)
        /*let detailPlan = movilData.arrayPlans
        self.viewContentGraphic.setDataPlanDetail(detailPlan: detailPlan.first!)*/
        
        //Actualizar el detalle del plan
        self.viewContentGraphic.delegate = self
        if(movilData.arrayDataGraphic.count == 0 && movilData.typeAccount == .MovilPrepago){
            self.viewContentGraphic.updateInterface(typeView: .SinBolsa)
        }else{
             self.viewContentGraphic.updateInterface(typeView: self.typeDetailPlan)
        }
    }
    
    func cleanInterface() {
        for viewTmp in scrollContent.subviews {
            viewTmp.removeFromSuperview()
        }
    }
    
    /// Actualizar la informacion seleccionada
    func updateDataServiceSelected() {
        //Obtener la informacion de la cuenta seleccionada
        if self.arrayMovilData.count > 0 {
            let movilData = self.arrayMovilData[self.indexAccountSelected]
            //Informacion del selector
            let serviceName = movilData.arrayServices.first?.nameService
            self.viewSelectService.setDataInformation(titleOption: self.textNumberLine, namePlanOption: serviceName!)
            
            let planName = movilData.arrayPlans.first?.namePlan
            self.viewHeaderPlan.updateDataHeader(typeCard: .Móvil, typeService: movilData.typeAccount, namePlan: planName!)
            
            let serviceUsage = movilData.arrayDataGraphic
            var cycleFacturation: CycleInformation?
            if movilData.cycleInformation != nil {
                cycleFacturation = movilData.cycleInformation
            }
            self.viewContentGraphic.updateTypeAccount(typeAccount: movilData.typeAccount)
            self.viewContentGraphic.setDataGraphics(dataGraohic: serviceUsage, facturationData: cycleFacturation)
            
            let detailPlan = movilData.arrayPlans
            self.viewContentGraphic.setDataPlanDetail(detailPlan: detailPlan.first!)
            
            //Actualizar la informacion en el detalle del plan
            if(movilData.arrayDataGraphic.count == 0 && movilData.typeAccount == .MovilPrepago){
                self.viewContentGraphic.updateInterface(typeView: .SinBolsa)
            }else{
                self.viewContentGraphic.updateInterface(typeView: self.typeDetailPlan)
            }
            self.viewContentGraphic.showSaldoSection(showSaldo: movilData.showSaldoSection)
            if movilData.showSaldoSection {
                self.viewContentGraphic.setDataSaldos(data: movilData.saldosSection!)
            }
            
            let detailBalance = movilData.arrayPlans.first
            self.viewBalance.setDataBalance(balance: (detailBalance?.balancePlan)!, dateVigency: (detailBalance?.datePlanVigency)!, typeAccount: movilData.typeAccount)
            let str = " $ "
            var strSaldo = String(format:"%.2f", (detailBalance?.balancePlan)!)
            strSaldo = str + strSaldo
     
            AnalyticsInteractionSingleton.sharedInstance.ADBTrackViewServicios(viewName: "Mis servicios|Movil", type: "4", nombreServicio: "Movil", detalleServicio: planName!, fechaVencimiento: (detailBalance?.datePlanVigency)!, estatus: "", saldo: strSaldo)
            
            /*NOTA YA NO SE MOSTRARAN LOS BOTONES DE BOLETA*/
            /*self.updateViewPositionByTypeAccount(typeAccount: movilData.typeAccount)*/
            /*FIN DE LA NOTA*/

            //Ajustar la altura del scroll
            self.updateHeightScroll()
        }
    }
    
    ///Funcion para encontrar el index del numero movil previamente seleccionado desde la seccion de resumen
    func setIndexPhonePreselect() {
        var indexPhonePreselect: Int = 0
        
        if self.numberPhonePreSelect != "" {
            for movil in self.arrayMovilData {
                if self.numberPhonePreSelect == movil.arrayServices.first?.nameService {
                    break
                }
                indexPhonePreselect += 1
            }
            self.indexAccountSelected = indexPhonePreselect
        }
    }
    
    /*NOTA: EN CASO DE QUERER QUE NUEVAMENTE SE MUESTREN LOS BOTONES DE BOLETA DESCOMENTAR EL SIGUIENTE METODO*/
    /*func updateViewPositionByTypeAccount(typeAccount: TypeAccountService) {
        let posYmaxBalanceView = self.viewBalance.frame.maxY
        var newPosYdetailPlanView: CGFloat = posYmaxBalanceView
        
        switch typeAccount {
        case .MovilPospago, .Television:
            if self.viewButtonBoleta == nil {
                let frameBoletas = CGRect(x: 0, y: posYmaxBalanceView, width: self.view.bounds.width, height: 110)
                self.viewButtonBoleta = CardButtonBoletaView(frame: frameBoletas)
                self.scrollContent.addSubview(self.viewButtonBoleta)
                newPosYdetailPlanView = self.viewButtonBoleta.frame.maxY
                self.viewButtonBoleta.viewBorder.addBottomGrecas()
                self.viewBalance.deleteBottomGrecas()
            }else {
                newPosYdetailPlanView = self.viewButtonBoleta.frame.maxY
            }
            break
        case .MovilPrepago:
            if self.viewButtonBoleta != nil {
                self.viewButtonBoleta.removeFromSuperview()
                self.viewButtonBoleta = nil
            }
            self.viewBalance.viewBorder.addBottomGrecas()
            break
        default:
            break
        }
        
        //Recorrer la posisción de las vistas posteriores al boton de plan
        self.viewTitleDetailPlan.frame = CGRect(x: self.viewTitleDetailPlan.frame.origin.x, y: newPosYdetailPlanView, width: self.viewTitleDetailPlan.bounds.width, height: self.viewTitleDetailPlan.frame.height)
        self.viewContentGraphic.frame = CGRect(x: self.viewContentGraphic.frame.origin.x, y: self.viewTitleDetailPlan.frame.maxY, width: self.viewContentGraphic.bounds.width, height: self.viewContentGraphic.frame.height)
    }*/
    
    func updateDetailPlanType() {
        let movilTmp = self.arrayMovilData[self.indexAccountSelected]
        if movilTmp.typeAccount == .MovilPospago && self.typeDetailPlan == .Table {
            self.typeDetailPlan = .Text
        }else if movilTmp.typeAccount == .MovilPrepago && self.typeDetailPlan == .Text {
            self.typeDetailPlan = .Table
        }else {
            self.typeDetailPlan = .Graphic
        }
    }
    
    /// Actualizar la altura del scroll
    func updateHeightScroll() {
        self.scrollContent.contentSize = CGSize(width: self.view.frame.width, height: self.viewContentGraphic.frame.maxY)
    }
    
    //MARK: Pull to refresh
    /// Realizar el pull to refresh
    /// - Parameter refresh: refresh control
    func refreshInfo(refresh: UIRefreshControl) {
        if SessionSingleton.sharedInstance.shouldRefresh() {
            //Volver a llamar los servicios
            print("REFRESH SERVICES CARDS MOVIL")
            let tabActual = SessionSingleton.sharedInstance.getCurrentTab()
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
    
    //MARK: Web service RetrieveCycleInformation
    func getDataCycleInformation() {
        for index in 0..<arrayMovilData.count {
            if arrayMovilData[index].typeAccount == .MovilPospago {
                //Crear request
                let request = RetrieveCycleInformationRequest()
                request.retrieveCycleInformation = RetrieveCycleInformation()
                request.retrieveCycleInformation?.lineOfBusiness = "3"
                request.retrieveCycleInformation?.mSISDN = arrayMovilData[index].arrayServices.first?.nameService
                
                WebServicesWithObjects.executeRetrieveCycleInformation(params: request, onSuccess: { (result, resultType) in
                    print("Esta es la respuesta")
                    let startDate = result.retrieveCycleInformationResponse?.rechargeHistory?.first?.startDate ?? ""
                    let endDate = result.retrieveCycleInformationResponse?.rechargeHistory?.first?.endDate ?? ""
                    let remainingDays = result.retrieveCycleInformationResponse?.rechargeHistory?.first?.remainingDays ?? 0
                    
                    let cycleInformation = CycleInformation()
                    cycleInformation.setStartDate(date: startDate)
                    cycleInformation.setEndDate(date: endDate)
                    cycleInformation.setRemainingDays(days: remainingDays)
                    self.arrayMovilData[index].setCycleInformation(cycleData: cycleInformation)
                    
                }) { (result, error) in
                    print("Error en el servicio")
                }
            }
        }
        
        print("Terminar servicio y actualizar")
    }
}

//MARK: UpgradePlanDelegate
extension CardsMovilManagement: UpgradePlanDelegate {
    func upgradePlan() {
        print("AQUI SE CAMBIA DESDE CARDS HACIA LAS PANTALLAS DE CAMBIO DE PLAN");
        guard let currentService = self.arrayMovilData[safe: self.indexAccountSelected] else {
            return;
        }

        let req = RetrievePlansRequest()
        req.retrievePlans = RetrievePlans();
        req.retrievePlans?.accountId = currentService.accountID;
        req.retrievePlans?.lineOfBusiness = "3"; // Es 3 porque siempre es postpago

        WebServicesWithObjects.executeRetrievePlans(params: req,
            onSuccess: { (result, rt) in
                    let newPlanView = NewUserPlanMainViewController(nibName: String(describing: NewUserPlanMainViewController.self),
                                                                    bundle: Bundle.main)
                    newPlanView.setServiceData(newServiceData: currentService);
                    newPlanView.setPlanDetailList(pdl: result.retrievePlansResponse?.plansDetailList);
                    let nav = UINavigationController(rootViewController: newPlanView);
                    nav.navigationBar.layer.shadowColor = institutionalColors.claroLightGrayColor.cgColor;
                    nav.navigationBar.layer.shadowOpacity = 0.8;
                    nav.navigationBar.layer.shadowOffset = CGSize(width: 0, height: 2);
                    nav.navigationBar.layer.shadowRadius = 2
                    self.so_containerViewController?.topViewController = nav;
        },
            onFailure: { (result, theError) in
                    let alerta = AlertAcceptOnly();
                    alerta.icon = AlertIconType.IconoAlertaError
                    alerta.title = SessionSingleton.sharedInstance.getGeneralConfig()?.translations?.data?.generales?.serviceNotRespond ?? "Información no actualizada por el momento"
                    NotificationCenter.default.post(name: Observers.ObserverList.AcceptOnlyAlert.name,
                                                    object: alerta);
        });
    }
}

//MARK: CardSelectServiceDelegate
extension CardsMovilManagement: CardSelectServiceDelegate {
    func showPopupServices() {
        let popupServices = PopupSelectServiceViewController(nibName: "PopupSelectServiceViewController", bundle: nil)
        popupServices.modalPresentationStyle = .overFullScreen
        popupServices.setDataInformationServices(arrayServices: self.arrayMovilData, title: self.textMobile, indexSelect: self.indexAccountSelected)
        popupServices.delegate = self
        self.present(popupServices, animated: true, completion: nil)
    }
}

//MARK: PopupSelectServiceDelegate
extension CardsMovilManagement: PopupSelectServiceDelegate {
    func popupSelectServiceAcceptAction(indexService: Int) {
        self.indexAccountSelected = indexService
        self.updateDetailPlanType()
        self.updateDataServiceSelected()
    }
}

//MARK: CardContentDetailDelegate
extension CardsMovilManagement: CardContentDetailDelegate {
    func consumingOptionSelected() {
        AnalyticsInteractionSingleton.sharedInstance.ADBTrackCustomLink(viewName: "Mis servicios|Movil:Consumo")
        self.typeDetailPlan = .Graphic
        self.updateHeightScroll()
    }
    
    func detailPlanSelected() {
        AnalyticsInteractionSingleton.sharedInstance.ADBTrackCustomLink(viewName: "Mis servicios|Movil:Detalle de plan")
        let tmpAccount = self.arrayMovilData[self.indexAccountSelected]
        self.typeDetailPlan = .Table
        
        if tmpAccount.typeAccount == .MovilPospago {
            self.typeDetailPlan = .Text
        }
        self.updateHeightScroll()
    }
    
    func saldoDataSelected() {
        self.typeDetailPlan = .None
        self.updateHeightScroll()
    }
    
    func showDescriptionPlan(messageDescriptionPlan: String) {
        let popupDescriptionPlan = PopupDescriptionPlanViewController(nibName: "PopupDescriptionPlanViewController", bundle: nil)
        popupDescriptionPlan.modalPresentationStyle = .overFullScreen
        popupDescriptionPlan.setInformation(title: "Marco Regulatorio", description: messageDescriptionPlan)
        self.present(popupDescriptionPlan, animated: true, completion: nil)
    }
}

//MARK: CardBalanceViewDelegate
extension CardsMovilManagement: CardBalanceViewDelegate {
    func btnBalanceAction(webId: String) {
        AnalyticsInteractionSingleton.sharedInstance.ADBTrackCustomLink(viewName: "Mis servicios|Movil:Pagar boleta")
        let webView = GenericWebViewVC()
        webView.serviceSelected = webId
        self.so_containerViewController?.topViewController = UINavigationController(rootViewController: webView)
    }
}

//MARK: CardButtonBoletaViewDelegate
extension CardsMovilManagement: CardButtonBoletaViewDelegate {
    func actionActiveBoleta() {
         AnalyticsInteractionSingleton.sharedInstance.ADBTrackCustomLink(viewName: "Mis servicios|Movil:Activar boleta electronica")
    }
    
    func actionSendBoleta() {
        AnalyticsInteractionSingleton.sharedInstance.ADBTrackCustomLink(viewName: "Mis servicios|Movil:Enviar boleta email")
    }
    
    func actionDownloadBoleta() {
         AnalyticsInteractionSingleton.sharedInstance.ADBTrackCustomLink(viewName: "Mis servicios|Movil:Descargar boleta")
    }
}
