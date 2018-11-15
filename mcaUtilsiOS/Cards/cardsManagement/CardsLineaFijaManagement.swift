//
//  CardsLineaFijaManagement.swift
//  MiClaro
//
//  Created by Jonathan Abimael Cruz Orozco on 31/07/18.
//  Copyright © 2018 am. All rights reserved.
//

import UIKit

class CardsLineaFijaManagement: UIViewController {

    /*********************** Variables ***********************/
    var arrayLineaFijaData: [CardsLineaFijaModel] = []
    var indexAccountSelected: Int = 0
    var typeDetailPlan: TypeDetailPlan = .Graphic
    private var pullToRefresh: UIRefreshControl!
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
    private var textViewDetailsPlan: String = ""
    private var textAddress: String = ""
    /*********************** Textos de la interfaz ***********************/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.setTextUI()
        self.createInterface()
        self.updateDataServiceSelected()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print("SE SALIO DE LA VISTA DE CARDS TELEVISION")
        for viewTmp in self.view.subviews {
            viewTmp.removeFromSuperview()
        }
    }
    
    init(frame: CGRect, services: [CardsLineaFijaModel]) {
        super.init(nibName: nil, bundle: nil)
        self.view.frame = frame
        self.arrayLineaFijaData = services
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setTextUI() {
        self.textViewDetailsPlan = self.textConfiguration?.translations?.data?.generales?.viewDetailsPlan ?? ""
        self.textAddress = self.textConfiguration?.translations?.data?.generales?.address ?? ""
    }
    
    private func createInterface() {
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
        
        let widthView = self.view.bounds.width
        
        /***********************Agregar el view selector de servicio**********************+*/
        let frameViewSelect = CGRect(x: 0, y: 10, width: widthView, height: 90)
        self.viewSelectService = CardSelectServiceView(frame: frameViewSelect)
        self.scrollContent.addSubview(self.viewSelectService)
        self.viewSelectService.disableActionButtonArrow()
        /***********************Agregar el view con el nombre del plan**********************/
        let frameHeaderService = CGRect(x: 0, y: self.viewSelectService.frame.maxY, width: widthView, height: 80)
        self.viewHeaderPlan = CardHeaderServiceView(frame: frameHeaderService)
        self.scrollContent.addSubview(self.viewHeaderPlan)
        /************************Agregar el view de saldo***********************************/
        let frameViewBalance = CGRect(x: 0, y: self.viewHeaderPlan.frame.maxY, width: widthView, height: 120)
        self.viewBalance = CardBalanceView(frame: frameViewBalance)
        self.scrollContent.addSubview(self.viewBalance)
        self.viewBalance.delegate = self
        /************************Agregar el view con los botones de boleta*******************/
        let frameBoletas = CGRect(x: 0, y: self.viewBalance.frame.maxY, width: widthView, height: 110)
        self.viewButtonBoleta = CardButtonBoletaView(frame: frameBoletas)
        self.scrollContent.addSubview(self.viewButtonBoleta)
        self.viewButtonBoleta.setTextView()
        self.viewButtonBoleta.delegate = self
        self.viewButtonBoleta.viewBorder.addBottomGrecas()
        /************************Agregar el view con el titulo del detalle o resumen del plan*******/
        let frameTitleDetail = CGRect(x: 0, y: self.viewButtonBoleta.frame.maxY, width: widthView, height: 50)
        self.viewTitleDetailPlan = CardTitleSummaryPlan(frame: frameTitleDetail)
        self.scrollContent.addSubview(self.viewTitleDetailPlan)
        self.viewTitleDetailPlan.setTitle(title: self.textViewDetailsPlan)
        /************************Agregar el view contenedor de las graficas y detalle del plan*******/
        let frameContentGraphic = CGRect(x: 0, y: self.viewTitleDetailPlan.frame.maxY, width: widthView, height: 300)
        self.viewContentGraphic = CardContentDetailGraphic(frame: frameContentGraphic, typeAccount: .LineaFija)
        self.scrollContent.addSubview(self.viewContentGraphic)
        self.viewContentGraphic.hiddeButtonSelection()
    }
    
    func updateDataServiceSelected() {
        if self.arrayLineaFijaData.count > 0 {
            let tvData = self.arrayLineaFijaData[indexAccountSelected]
            //Informacion del selector
            let addressHome = tvData.addressHome
            self.viewSelectService.setDataInformation(titleOption: self.textAddress, namePlanOption: addressHome)
            
            self.viewHeaderPlan.updateDataHeader(typeCard: .Teléfono, typeService: .LineaFija, namePlan: tvData.planDetail.namePlan)
            
            self.viewBalance.setDataBalance(balance: tvData.planDetail.balancePlan, dateVigency: tvData.planDetail.datePlanVigency, typeAccount: .LineaFija)
            
            self.viewContentGraphic.setDataPlanDetail(detailPlan: tvData.planDetail)
            self.viewContentGraphic.updateInterface(typeView: .Table)
            
            self.updateHeightScroll()
            
            let str = " $ "
            var strSaldo = String(format:"%.2f", tvData.planDetail.balancePlan)
            strSaldo = str + strSaldo
            
            AnalyticsInteractionSingleton.sharedInstance.ADBTrackViewServicios(viewName: "Mis servicios|Telefono fijo", type: "3", nombreServicio: "Telefonia Fija", detalleServicio: tvData.planDetail.namePlan, fechaVencimiento: (tvData.planDetail.datePlanVigency), estatus: "", saldo: strSaldo)
        }
    }
    
    /// Actualizar la altura del scroll
    func updateHeightScroll() {
        let heightView = self.view.frame.height - (self.constantBottomHeightTabBar + self.constantTopHeightTabBar)
        let posYcontentGraphic = self.viewContentGraphic.frame.minY
        let heightContentGraphic = self.viewContentGraphic.getHeightContentDetailGraphic()
        let heightTmpScroll = posYcontentGraphic + heightContentGraphic
        
        if heightTmpScroll > heightView {
            let extraHeight = heightTmpScroll - heightView
            let newHeightScroll = self.view.frame.height + extraHeight
            self.scrollContent.contentSize = CGSize(width: self.view.frame.width, height: newHeightScroll)
        }else {
            self.scrollContent.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height)
        }
    }
    
    //MARK: Pull to refresh
    /// Realizar el pull to refresh
    /// - Parameter refresh: refresh control
    func refreshInfo(refresh: UIRefreshControl) {
        if SessionSingleton.sharedInstance.shouldRefresh() {
            //Volver a llamar los servicios
            print("REFRESH SERVICES CARDS TELEVISION")
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
    
    //
    func showTicketBoleta() {
        let accountAs : [ServiceAccount]? = SessionSingleton.sharedInstance.getFullAccountData()
        let boletas = AccountManagement(arrayServices: accountAs!)
        boletas.filterArrayPlanCards()
        let arrayBoletas : [PlanCard] = boletas.getArrayPlanCard()
        
        var planCardsFilteredArray : [PlanCard] = [PlanCard]() //arreglo de plancards filtradas por tipo de servicio
        var addressesArray : [String] = [String]() //arreglo de direcciones
        
        for planCard in arrayBoletas{
            if planCard.serviceType! == "3" {
                if planCard.lineOfBusiness! != "2"{
                    var planAddress = ""
                    if planCard.lineOfBusiness! == "3"{
                        planAddress = planCard.serviceId!
                    }else{
                        planAddress = planCard.plan!.planHomeAddress!
                    }
                    
                    if addressesArray.contains(planAddress) == false{
                        addressesArray.append(planAddress)
                    }
                    
                    var containsPlanCard = false
                    for p in planCardsFilteredArray{
                        if p.accountId! == planCard.accountId!{
                            containsPlanCard = true
                        }
                    }
                    if containsPlanCard == false{
                        planCardsFilteredArray.append(planCard)
                    }
                }
            }
        }
        
        var arrayPlanCards = [[PlanCard]]()
        
        for address in addressesArray{
            var planArray = [PlanCard]()
            for planCard in planCardsFilteredArray{
                var planAddress = ""
                if planCard.lineOfBusiness! == "3"{
                    planAddress = planCard.serviceId!
                }else{
                    planAddress = planCard.plan!.planHomeAddress!
                }
                if address == planAddress{
                    planArray.append(planCard)
                }
            }
            arrayPlanCards.append(planArray)
        }
        
        let vcShowTicket = ShowTicketVC()
        vcShowTicket.selectedTypeService = "3"/*selectedServiceType*/
        vcShowTicket.addressesArray = addressesArray
        vcShowTicket.planCards = arrayPlanCards
        self.navigationController?.pushViewController(vcShowTicket, animated: true)
    }

}

//MARK: CardBalanceViewDelegate
extension CardsLineaFijaManagement: CardBalanceViewDelegate {
    func btnBalanceAction(webId: String) {
        AnalyticsInteractionSingleton.sharedInstance.ADBTrackCustomLink(viewName: "Mis servicios|Telefono fijo:Pagar boleta")
        let webView = GenericWebViewVC()
        webView.serviceSelected = webId
        self.so_containerViewController?.topViewController = UINavigationController(rootViewController: webView)
    }
}

//MARK: CardButtonBoletaViewDelegate
extension CardsLineaFijaManagement: CardButtonBoletaViewDelegate {
    func actionActiveBoleta() {
        self.showTicketBoleta()
        AnalyticsInteractionSingleton.sharedInstance.ADBTrackCustomLink(viewName: "Mis servicios|Telefono fijo:Activar boleta electronica")
    }
    
    func actionSendBoleta() {
        self.showTicketBoleta()
        AnalyticsInteractionSingleton.sharedInstance.ADBTrackCustomLink(viewName: "Mis servicios|Telefono fijo:Enviar boleta email")
    }
    
    func actionDownloadBoleta() {
        self.showTicketBoleta()
        AnalyticsInteractionSingleton.sharedInstance.ADBTrackCustomLink(viewName: "Mis servicios|Telefono fijo:Descargar boleta")
    }
}
//MARK: CardContentDetailDelegate
extension CardsLineaFijaManagement: CardContentDetailDelegate {
    func consumingOptionSelected() {
        AnalyticsInteractionSingleton.sharedInstance.ADBTrackCustomLink(viewName: "Mis servicios|Telefono fijo:Consumo")
    }
    func detailPlanSelected() {
        AnalyticsInteractionSingleton.sharedInstance.ADBTrackCustomLink(viewName: "Mis servicios|Telefono fijo:Detalle de plan")
    }
    func saldoDataSelected() {
        
    }
    func showDescriptionPlan(messageDescriptionPlan: String) {
        //no hago nada
    }
}
