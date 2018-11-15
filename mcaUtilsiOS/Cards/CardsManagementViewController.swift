//
//  CardsManagementViewController.swift
//  MiClaro
//
//  Created by Jonathan Abimael Cruz Orozco on 27/11/17.
//  Copyright © 2017 am. All rights reserved.
//

import UIKit
import Cartography
import MTPopup

/// Enumerado de Típo de card
enum TypeCardView : String {
    case None
    case Resumen
    case Móvil
    case Internet
    case Televisión
    case TodoClaro = "Todo Claro"
    case Teléfono
    case Suscripción
}
/// Enumerado Tipo de cuenta
enum TypeAccounts {
    case Postpago
    case Prepago
    case PostpagoAndPrepago
    case None
}
/// Estructura SideView
struct SideView {
    var Left: Bool
    var Right: Bool
    var Top: Bool
    var Bottom: Bool
}

enum TypeSocialNetwork {
    case Facebook// 1
    case Twitter // 2
    case Whatsapp // 3
    case Instagram // 4
    case ClaroMusica // 5
    case Snapchat // 6
    case Waze // 7
    case ColaboraCloud// 8
    case Gmail // 9
    case Hotmail // 10
    case Yahoo // 11
    case facebookMessenger // 12
}

/// Colocar el borde dependiendo el lado elegido
enum Sides {
    case left
    case right
    case top
    case bottom
}


class CardsManagementViewController: UIViewController {
    
    internal var tmpPlanCardData : [[PlanCard]]?
    
    internal var alreadyDrawn : Bool?;
    
    var scrollview: UIScrollView!
    var pullToRefresh: UIRefreshControl!
    var tabItemArray : [TabInformation]?;
    //For get the information
    internal var accountData : ServiceAccount?
    internal var accountArray: [ServiceAccount] = [ServiceAccount]()
    internal var accountArraySorted : [ServiceAccount] = [ServiceAccount]()
    //For identifier the type of card
    var typeCard: TypeCardView = TypeCardView.Resumen
    internal var typeAccounts: TypeAccounts = TypeAccounts.None
    
    //For Text
    let conf = SessionSingleton.sharedInstance.getGeneralConfig()
    
    var popupRut : MTPopupController?;
    
    var heightScroll: CGFloat = 0.0
    private let tabBarHeight : CGFloat = 85.0;
    var rect : CGRect? = nil
    var accountID: Int = 0
    
    /// Constructor de la administrador de las cards
    /// - Parameter frame: frame del contenedor
    /// - Parameter accountData: Cuenta con la información necesaria para ser mostrada
    /// - Parameter typeCard: Tipo de card a mostrar
    init(frame: CGRect, accountData: ServiceAccount, typeCard: TypeCardView) {
        super.init(nibName: nil, bundle: nil)
        self.accountData = accountData
        self.typeCard = typeCard
        self.view.frame = frame
        self.alreadyDrawn = false;
        self.interfaceView()
    }
    
    /// Constructor de la administrador de las cards
    /// - Parameter frame: frame del contenedor
    /// - Parameter accountDataArray: Arreglo de cuentas con la información necesaria para ser mostrada
    /// - Parameter typeCard: Tipo de card a mostrar
    init(frame: CGRect, accountDataArray: [ServiceAccount], typeCard: TypeCardView) {
        super.init(nibName: nil, bundle: nil)
        self.accountArray = accountDataArray
        self.typeCard = typeCard
        self.view.frame = frame
        self.alreadyDrawn = false;
        self.interfaceView()
        self.scrollTo()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /// ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    /// ViewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        if false == SessionSingleton.sharedInstance.isConsumingService() {
            interfaceView()
        } else {
            self.alreadyDrawn = false
            cleanScrollView()
        }
    }
    /// ViewDidAppear
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.interfaceView();
        if nil != self.scrollview {
            self.scrollTo()
            self.scrollview.frame.origin.x = 0;
            self.scrollview.setNeedsDisplay()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    /// Remover los views dentro del scroll
    func cleanScrollView() {
        if let sv = self.scrollview{
            for view in sv.subviews {
                view.removeFromSuperview()
            }
        }
    }
    
    //MARK: TYPE OF CARDS
    /// Mostrar las cards dependiendo el tipo de sección seleccionada
    func interfaceView() {
        if true == self.alreadyDrawn {
            return;
        }
        self.pullToRefresh = UIRefreshControl()
        self.pullToRefresh.addTarget(self, action: #selector(self.refreshInfo), for: .valueChanged)
        
        if let last = SessionSingleton.sharedInstance.getLastRefreshDate() {
            let date = getStringDateTime(date: last)
            self.pullToRefresh.attributedTitle = NSAttributedString(string: String(format: "Última actualización: %@", date))
        }
        
        if nil != self.scrollview {
            self.cleanScrollView()
            self.scrollview.removeFromSuperview();
            self.scrollview = nil;
        }
        
        self.scrollview = UIScrollView(frame: self.view.frame)
        self.scrollview.frame.origin.x = 0;
        self.scrollview.frame.origin.y = 0;
        self.scrollview.addSubview(self.pullToRefresh)
        self.scrollview.backgroundColor = institutionalColors.claroPerlColor
        self.scrollview.alwaysBounceVertical = true
        
        self.view.addSubview(self.scrollview)
        
        //We have identifier the type of section
        switch self.typeCard {
        case .Resumen:
            self.createCardsResume()
            self.alreadyDrawn = true;
            break
        case .Móvil:
            if false == SessionSingleton.sharedInstance.isConsumingService() {
                self.createCardsMovil()
                self.alreadyDrawn = true;
            }
            break
        case .Internet:
            if false == SessionSingleton.sharedInstance.isConsumingService() {
                self.createCardsInternet()
                self.alreadyDrawn = true;
            }
            break
        case .Televisión:
            if false == SessionSingleton.sharedInstance.isConsumingService() {
                self.createCardsTelevision()
                self.alreadyDrawn = true;
            }
            break
        case .TodoClaro:
            if false == SessionSingleton.sharedInstance.isConsumingService() {
                self.createCardsTodoClaro()
                self.alreadyDrawn = true;
            }
            break
        case .Teléfono:
            break;
        default:
            break
        }
        
        self.view.setNeedsDisplay()
        self.scrollview.setNeedsDisplay()
        
        //self.alreadyDrawn = true;
    }

    /// Realizar el pull to refresh
    /// - Parameter refresh: refresh control
    func refreshInfo(refresh: UIRefreshControl) {
        if SessionSingleton.sharedInstance.shouldRefresh() {
            //Volver a llamar los servicios
            print("REFRESH SERVICES CARDS")
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
    
    
    /// Identificar el tipo de cuenta en base a el line of business, los tipos de cuenta pueden ser Postpago, Prepago y Postpago&Prepago
    func getTypeAccounts() {
        var hasPrepago = false //lob = 2
        var hasPostpago = false //lob = 3
        
        for account in self.accountArray {
            let lob = account.account?.lineOfBusiness
            
            if lob == "2" {
                hasPrepago = true
            }
            if lob == "3" || lob == "1" {
                hasPostpago = true
            }
        }
        
        if hasPostpago && hasPrepago {
            self.typeAccounts = TypeAccounts.PostpagoAndPrepago
        }else {
            if hasPostpago {
                self.typeAccounts = TypeAccounts.Postpago
            }
            if hasPrepago {
                self.typeAccounts = TypeAccounts.Prepago
            }
        }
    }
    
    /// Obtener el texto de algunas etiquetas dependiendo el tipo de cuenta obtenida
    /// - Parameter lob: Line of business
    /// - Return (String, String): Tupla con las leyendas a mostrar
    func getTitleText(lob: String) -> (String, String) {
        var title: String = "..."
        var title2: String = "..."
        
        switch self.typeAccounts {
        case .Postpago:
            title = conf?.translations?.data?.generales?.amountPayable ?? "Monto a pagar:"
            title2 = conf?.translations?.data?.generales?.paidBefore ?? "Antes del:"
            break
        case .Prepago:
            title = conf?.translations?.data?.mobile?.balance ?? "Saldo"
            title2 = "Vigencia:"
            break
        case .PostpagoAndPrepago:
            if lob == "2" {
                title = conf?.translations?.data?.mobile?.balance ?? "Saldo"
                title2 = "Vigencia:"
            }
            if lob == "1" || lob == "3" {
                title = conf?.translations?.data?.generales?.amountPayable ?? "Monto a pagar:"
                title2 = conf?.translations?.data?.generales?.paidBefore ?? "Antes del:"
            }
            
            break
        case .None:
            break
        }
        
        return (title, title2)
    }
    
    //MARK: CREATE CARDS
    //Identify the type of account
    // 1.- Fijo
    // 2.- Prepago
    // 3.- Postpago
    
    /// Crear las cards para la vista de resumen
    private func createCardsResume() {
        self.getTypeAccounts()
        
        self.accountArraySorted = self.accountArray.sortServiceAccount()
        let auxiliar = self.accountArraySorted//self.accountArray.sortServiceAccount()
        
        //Header de la card
        createPlanCardStructure()
        let frameHeader: CGRect = CGRect(x: 0.0, y: self.scrollview.frame.origin.y, width: self.scrollview.bounds.width - 20.0, height: 120.0)
        
        let containerCard = HeaderCardView(frame: frameHeader,//self.scrollview.frame,
            accountDataArray: auxiliar,
            typeCard: .Resumen,
            indexAccount: 0,
            typeAccount: self.typeAccounts)
        containerCard.delegate = self
        scrollview.addSubview(containerCard)
        
        self.createBorderHeader(view: containerCard)
        //Debemos identificar cuantos View expand debemos mostrar, esto es mediante el número de cuentas que existan
        let posInitForFirstHeaderExpand = containerCard.getHeightHeaderView()
        addViewHeaderExpand(posYinit: posInitForFirstHeaderExpand/*containerCard.frame.maxY*/, tagHeaderCard: 0)
    }
    
    
    /// Crear las cards para la vista de Movil
    private func createCardsMovil() {
        var posYcontainer: CGFloat = 40.0
        var tagViewHeader: Int = 1
//        let tagServiceUsage: Int = 1001
        
        self.typeCard = .Móvil
        
        for indexAccount in 0 ..< self.accountArray.count {
            print("ALTURA DEL SCROLLVIEW \(self.heightScroll)")
            let account = self.accountArray[indexAccount]
            if !("2" == account.account?.lineOfBusiness || "3" == account.account?.lineOfBusiness) {
                continue;
            }
            
            print("POSICION DONDE SE MOSTRARA LA CARD HEADER \(self.heightScroll)")
            print("CARD \(account.account?.accountId ?? "" )");
            
            let totalServices = account.detailServices?.associatedService?.count ?? 0;
            for idxService in 0 ..< totalServices {
                
                let frameHeader: CGRect = CGRect(x: 0.0/*self.scrollview.frame.origin.x*/, y: /*self.heightScroll*/posYcontainer, width: self.scrollview.bounds.width - 20.0, height: 120.0)
                let containerCard = HeaderCardView(frame: frameHeader,
                                                   accountData: account,
                                                   typeCard: .Móvil,
                                                   indexAssociateService: idxService,/*indexAssociateService,*/
                                                   indexAccount: indexAccount)
                
                //            if let height = containerCard.subviews.last?.frame.maxY {
                //                containerCard.frame = CGRect(x: containerCard.frame.origin.x, y: containerCard.frame.origin.y, width: containerCard.frame.width, height: height/* + 10*/)
                //            }
                //TEST
                posYcontainer = self.heightScroll
                //Para que la primer card tenga una separación de 40 con respecto al top de la vista
                if tagViewHeader == 1 {
                    posYcontainer = 40.0
                }
                
                containerCard.delegate = self
                containerCard.frame.origin.y = posYcontainer
                containerCard.tag = tagViewHeader
                scrollview.addSubview(containerCard)
                self.createBorderHeader(view: containerCard)
                
                let internet = account.detailServices?.detailPlan?[safe: idxService]?.retrieveConsumptionDetailInformation?.serviceUsage?.first(where: {$0.serviceType?.uppercased() == "INTERNET" })
                
                /*let total = Int(internet?.serviceFeatureUsage?.first?.serviceFeatureUsageLimit?.quantity ?? "0") ?? 0
                
                if 0 != total {
                    //Agregamos la vista de la gráfica
                    let frameGraphic: CGRect = CGRect(x: 0.0, y: containerCard.frame.maxY, width: self.scrollview.bounds.width, height: 380.0)
                    let graphicView = GraphicViewHeader(frame: frameGraphic, accountData: account, emptyView: false, idxService: idxService)
                    graphicView.tag = tagViewHeader
                    
                    scrollview.addSubview(graphicView)
                    posYcontainer = posYcontainer + containerCard.getHeightHeaderView() + graphicView.getHeightGraphicView()
                    
                    self.createBorderGraphicView(view: graphicView)
                    
                } else {*/
                    posYcontainer = posYcontainer + containerCard.getHeightHeaderView()
//                }
                
                //Obtenemos el uso de servicios
                let idAccount = account.account?.accountId
                addViewHeaderExpand(posYinit: posYcontainer, tagHeaderCard: tagViewHeader, accountID: idAccount!)
                /* JONATHAAAAAAn
                let arrayServiceUsage = account.detailServices?.detailPlan![safe: idxService]?.retrieveConsumptionDetailInformation?.serviceUsage
                var countService: Int = 0
                var tagService: Int = 0
                
                for serviceUsage in arrayServiceUsage! {
                    //Agregar los View Expand para cada cuenta o plan
                    //Creamos el tag dependiendo el tag header
                    tagService = tagServiceUsage * tagViewHeader + countService
                    
                    addViewHeaderExpand(posYinit: posYcontainer, tagHeaderCard: tagService, indxService : idxService)
                    posYcontainer = posYcontainer + 70.0
                    countService += 2
                }
                
                tagService += 2
                //Actualización de consumo
                
                //Agregar los View Expand para cada cuenta o plan
                addViewHeaderExpand(posYinit: posYcontainer, tagHeaderCard: tagService/*tagViewHeader*/, indxService : idxService)
                JONATHAAAAAN*/
                //Sumamos a posYcontainer la altura del ViewExpand y ViewBodyExpand
//                posYcontainer = posYcontainer + 70.0
                
                print("HEIGHT OF SCROLL VIEW \(self.heightScroll)")
                
                //El tag del view Header es el mismo que el del ViewExpand, para identificar la posición de la card
                tagViewHeader += 2
                self.scrollview.setNeedsDisplay()
            }
        }
        if self.view.frame.height >= 676 {
            self.heightScroll += 120
            self.scrollview.setNeedsDisplay()
        }
        
    }
    
    /// Crear las cards para la vista de Internet
    func createCardsInternet() {
        var posYcontainer: CGFloat = 40.0
        var tagViewHeader: Int = 1
        
        for indexAccount in 0 ..< self.accountArray.count {
            print("POSICION DONDE SE MOSTRARA LA CARD HEADER \(posYcontainer)")
            print("ALTURA DEL SCROLLVIEW \(self.heightScroll)")
            let account = self.accountArray[indexAccount]
            if ("2" == account.account?.lineOfBusiness || "3" == account.account?.lineOfBusiness) {
                continue;
            }
            
            let frameHeader: CGRect = CGRect(x: 0.0/*self.scrollview.frame.origin.x*/, y: self.heightScroll/*posYcontainer*/, width: self.scrollview.bounds.width - 20.0, height: 120.0)
            let containerCard = HeaderCardView(frame: frameHeader,
                                               accountData: account,
                                               typeCard: .Internet,
                                               indexAssociateService: 0,/*indexAssociateService,*/
                indexAccount: indexAccount)
            
            containerCard.delegate = self
            containerCard.frame.origin.y = posYcontainer
            containerCard.tag = tagViewHeader
            scrollview.addSubview(containerCard)
            self.createBorderHeader(view: containerCard)
            
            posYcontainer = posYcontainer + containerCard.getHeightHeaderView()
            
            //Agregar los View Expand para cada cuenta o plan
            addViewHeaderExpand(posYinit: posYcontainer, tagHeaderCard: tagViewHeader)
            
            //Sumamos a posYcontainer la altura del ViewExpand y ViewBodyExpand
            posYcontainer = posYcontainer + 60.0
            
            print("HEIGHT OF SCROLL VIEW \(self.heightScroll)")
            
            //El tag del view Header es el mismo que el del ViewExpand, para identificar la posición de la card
            tagViewHeader += 2
        }
    }
    /// Crear las cards para la vista de teléfono
    func createCardsTelefono() {
        
    }
    
    /// Crear las cards para la vista de televisión
    func createCardsTelevision() {
        var posYcontainer: CGFloat = 40.0
        var tagViewHeader: Int = 1
        
        for indexAccount in 0 ..< self.accountArray.count {
            print("POSICION DONDE SE MOSTRARA LA CARD HEADER \(posYcontainer)")
            print("ALTURA DEL SCROLLVIEW \(self.heightScroll)")
            let account = self.accountArray[indexAccount]
            if ("2" == account.account?.lineOfBusiness || "3" == account.account?.lineOfBusiness || account.isTodoClaro()) {
                continue;
            }
            
            let frameHeader: CGRect = CGRect(x: 0.0/*self.scrollview.frame.origin.x*/, y: self.heightScroll/*posYcontainer*/, width: self.scrollview.bounds.width - 20.0, height: 120.0)
            let containerCard = HeaderCardView(frame: frameHeader,
                                               accountData: account,
                                               typeCard: .Televisión,
                                               indexAssociateService: 0,/*indexAssociateService,*/
                indexAccount: indexAccount)
            
            containerCard.delegate = self
            containerCard.frame.origin.y = posYcontainer
            containerCard.tag = tagViewHeader
            scrollview.addSubview(containerCard)
            self.createBorderHeader(view: containerCard)
            
            posYcontainer = posYcontainer + containerCard.getHeightHeaderView()
            
            //Agregar los View Expand para cada cuenta o plan
            addViewHeaderExpand(posYinit: posYcontainer , tagHeaderCard: tagViewHeader)
            
            //Sumamos a posYcontainer la altura del ViewExpand y ViewBodyExpand
            posYcontainer = posYcontainer + 60.0
            
            print("HEIGHT OF SCROLL VIEW \(self.heightScroll)")
            
            //El tag del view Header es el mismo que el del ViewExpand, para identificar la posición de la card
            tagViewHeader += 2
        }
    }
    
    /// Crear las cards para la vista de Todo Claro
    func createCardsTodoClaro() {
        var posYcontainer: CGFloat = 40.0
        var tagViewHeader: Int = 1
        
        for indexAccount in 0 ..< self.accountArray.count {
            print("POSICION DONDE SE MOSTRARA LA CARD HEADER \(posYcontainer)")
            print("ALTURA DEL SCROLLVIEW \(self.heightScroll)")
            let account = self.accountArray[indexAccount]
            //            if ("2" == account.account?.lineOfBusiness || "3" == account.account?.lineOfBusiness) {
            //if account.account?.lineOfBusiness != "1" && (account.detailServices?.associatedService?.count)! < 2 {
            if !account.isTodoClaro() {
                continue;
            }
            
            let testFrame: CGRect = CGRect(x: 0.0, y: self.heightScroll/*posYcontainer*/, width: self.scrollview.bounds.width - 20.0, height: 120.0)
            let containerCard = HeaderCardView(frame: testFrame,
                                               accountData: account,
                                               typeCard: .TodoClaro,
                                               indexAssociateService: 0,
                                               indexAccount: indexAccount)
            
            containerCard.delegate = self
            containerCard.frame.origin.y = posYcontainer
            containerCard.tag = tagViewHeader
            
            scrollview.addSubview(containerCard)
            self.createBorderHeader(view: containerCard)
            
            posYcontainer = posYcontainer + containerCard.getHeightHeaderView() //containerCard.frame.maxY
            
            //Agregar los View Expand para cada cuenta o plan
            addViewHeaderExpand(posYinit: posYcontainer , tagHeaderCard: tagViewHeader)
            
            //Sumamos a posYcontainer la altura del ViewExpand y ViewBodyExpand
            posYcontainer = posYcontainer + 60.0
            
            print("HEIGHT OF SCROLL VIEW \(self.heightScroll)")
            //El tag del view Header es el mismo que el del ViewExpand, para identificar la posición de la card
            tagViewHeader += 2
        }
    }
    
    //MARK: Borders Cards
    /// Crear bordes del header de todas cards
    /// - Parameter view: Vista a la que se le agregaran los bordes
    func createBorderHeader(view: UIView) {
        let side = SideView(Left: true, Right: true, Top: true, Bottom: false)
        view.addBorder(sides: side, color: institutionalColors.claroLightGrayColor, thickness: 0.5)
    }
    
    /// Crear bordes del view con el botón para mostrar y ocultar la información
    /// - Parameter view: Vista a la que se le agregaran los bordes
    func createBorderViewExpand(view: UIView) {
        let side = SideView(Left: true, Right: true, Top: false, Bottom: false)
        view.addBorder(sides: side, color: institutionalColors.claroLightGrayColor, thickness: 0.5)
    }
    
    /// Crear bordes del view que contiene la gráfica
    /// - Parameter view: Vista a la que se le agregaran los bordes
    func createBorderGraphicView(view: UIView) {
        let side = SideView(Left: true, Right: true, Top: false, Bottom: false)
        view.addBorder(sides: side, color: institutionalColors.claroLightGrayColor, thickness: 0.5)
    }
    
    /// Crear bordes del view que se muestra y se oculta
    /// - Parameter view: Vista a la que se le agregaran los bordes
    func createBorderBodyExpand(view: ViewBodyExpand) {
        let side = SideView(Left: true, Right: true, Top: false, Bottom: false)
        view.setLayers(sides: side)
        view.addBorderWithLayer(sides: side, color: institutionalColors.claroLightGrayColor, thickness: 0.5, layers: view.getLayers())
    }
    
    /// Crear bordes del ultimo view de todas cards, para agregar el borde inferior
    /// - Parameter view: Vista a la que se le agregaran los bordes
    func createBorderLastView(view: ViewBodyExpand) {
        let side = SideView(Left: true, Right: true, Top: false, Bottom: true)
        view.setLayers(sides: side)
        view.addBorderWithLayer(sides: side, color: institutionalColors.claroLightGrayColor, thickness: 0.5, layers: view.getLayers())
    }
    
    /// Actualizar la altura de los bordes de la vista expandible
    /// - Parameter view: Vista a la que se le agregaran los bordes
    func updateBorderLastView(view: ViewBodyExpand) {
        var side = SideView(Left: true, Right: true, Top: false, Bottom: false)
        
        if view.getLayers().count > 2 {
            side.Bottom = true
        }
        
        view.updateLayer(sides: side, thickness: 0.5, layers: view.getLayers())
    }
    
    //MARK: VIEW EXPAND FOR CARDS
    /// Crear las vistas encargadas de activar la acción de ocultar y mostrar la información de las cards
    /// - Parameter posYinit: Posición en la coordenada Y para posicionar la card
    /// - Parameter tagHeaderCard: Identificador de la card a la que pertenece
    func addViewHeaderExpand(posYinit: CGFloat, tagHeaderCard: Int, indxService : Int = 0, accountID: String = "") {
        var posYViewExpand: CGFloat = posYinit
        
        let arrayExpandView = createViewsExpands(accountID: accountID)
        var tagForView: Int = 1
        
        switch self.typeCard {
        case .Resumen:
            if false == SessionSingleton.sharedInstance.isConsumingService() {
                for indexHeaderInfo in 0 ..< arrayExpandView.count {
                    let frameViewExpand = CGRect(x: 0.0, y: posYViewExpand, width: self.scrollview.bounds.width, height: 100.0)
                    let view1 = ViewExpand(frame: frameViewExpand, arrayExpand: arrayExpandView[indexHeaderInfo], indxService: indexHeaderInfo)
                    view1.tag = tagForView //For identifier the position
                    view1.delegate = self
                    
                    scrollview.addSubview(view1)
                    tagForView += 1
                    self.createBorderViewExpand(view: view1)
                    
                    //Creamos un view vacio para usarlo posteriormente como el detalle de la vista expandible
                    let frameBodyEpand = CGRect(x: view1.frame.origin.x, y: view1.frame.maxY, width: view1.bounds.width, height: 20.0)
                    let tab : [String : Any]? = ["TabName" : arrayExpandView[indexHeaderInfo].first?.titleText ?? "", "AccountId" : arrayExpandView[indexHeaderInfo].last?.descriptionText /*auxiliar[indexHeaderInfo].account?.accountId*/ ?? ""]
                    let body = ViewBodyExpand(frame: frameBodyEpand,
                                              emptyView: true, tab: tab!)
                    body.tag = tagForView
                    
                    scrollview.addSubview(body)
                    
                    if indexHeaderInfo == arrayExpandView.count - 1 {
                        self.createBorderLastView(view: body)
                    }else {
                        self.createBorderBodyExpand(view: body)
                    }
                    
                    tagForView += 1
                    
                    posYViewExpand = body.frame.maxY
                }
            } else {
                let frameViewExpand = CGRect(x: 10.0, y: posYViewExpand, width: self.scrollview.bounds.width - 20, height: 20.0)
                let tab : [String : Any] = ["TabName" : "", "AccountId" : ""]
                
                let body = ViewBodyExpand(frame: frameViewExpand,
                                          emptyView: true, tab: tab)
                body.tag = tagForView
                
                scrollview.addSubview(body)
                self.createBorderViewExpand(view: body)
                self.createBorderLastView(view: body)
                tagForView += 1
                
                posYViewExpand = body.frame.maxY
            }
            
            self.heightScroll = posYViewExpand
            scrollview.contentSize = CGSize(width: self.scrollview.bounds.width, height: self.heightScroll + tabBarHeight)
            break
        case .Móvil:
            if true == SessionSingleton.sharedInstance.isConsumingService() {
                break;
            }
            /*JONATHAAAAAn*/
            //Obtenemos la información de cada servicio usado
            let info = arrayExpandView[safe: tagForView - 1]
            
            //estos headers expand tendran un tag arriba de 1000
            tagForView = tagHeaderCard * 1000//tagHeaderCard
            
            //Este arreglo solo contiene la información de los servicios consumidos
            for indexHeaderInfo in 0 ..< (info?.count ?? 0) {
                //Le sumamos el indexHeaderInfo al tag
                tagForView = tagForView + tagHeaderCard
                
                print("POSICION DONDE SE MOSTRARA EL VIEW EXPAND \(posYViewExpand)")
//                let info = arrayExpandView[indexHeaderInfo]
                let title = info?[safe: indexHeaderInfo]?.descriptionText ?? ""
                let frameViewExpand = CGRect(x: 0.0, y: posYViewExpand, width: self.scrollview.bounds.width, height: 100.0)
                let viewExpand = ViewExpand(frame: frameViewExpand, typeCard: .Móvil, indxService: indexHeaderInfo/*indxService*/, titleView: title, idAccount: accountID)
                viewExpand.tag = tagForView
                viewExpand.delegate = self
                
                scrollview.addSubview(viewExpand)
                tagForView += 1
                
                self.createBorderViewExpand(view: viewExpand)
                
                print("POSICION DONDE SE MOSTRARA EL VIEW BODY EXPAND \(viewExpand.frame.maxY)")
                //TEST, creamos un view vacio para usarlo posteriormente como el detalle de la vista expandible
                let body = ViewBodyExpand(frame: CGRect(x: viewExpand.frame.origin.x, y: viewExpand.frame.maxY, width: viewExpand.bounds.width, height: 20.0), emptyView: true)
                body.tag = tagForView
                
                //Pra mostrar el alert sheet
                body.delegate = self
                
                scrollview.addSubview(body)
                //            tagForView += 1
                
                // Los tag mayores a mil son utilizados solo por movil, para mostrar las gráficas de los servicios usados
                if tagForView > 1000 {
                    self.createBorderBodyExpand(view: body)
                }else {
                    self.createBorderLastView(view: body)
                }
                
                //            addConstraintsTo(viewExpand: viewExpand, view: self.view, lastView: last, bodyView: body)
                posYViewExpand = body.frame.maxY
                
                self.heightScroll = posYViewExpand
                
                if self.view.frame.height >= 752 {
                    self.heightScroll += 50
                }
            }
            //Agregamos ahora el view de Ver detalles del plan
            let indexTag = info?.count ?? 0
            tagForView += 1
            let frameViewExpand = CGRect(x: 0.0, y: posYViewExpand, width: self.scrollview.bounds.width, height: 100.0)
            let viewExpandDetail = ViewExpand(frame: frameViewExpand, typeCard: .Móvil, indxService: indexTag/*indxService*/, idAccount: accountID)
            viewExpandDetail.tag = tagForView
            viewExpandDetail.delegate = self
            
            scrollview.addSubview(viewExpandDetail)
            tagForView += 1
            
            self.createBorderViewExpand(view: viewExpandDetail)
            
            print("POSICION DONDE SE MOSTRARA EL VIEW BODY EXPAND \(viewExpandDetail.frame.maxY)")
            //TEST, creamos un view vacio para usarlo posteriormente como el detalle de la vista expandible
            let body = ViewBodyExpand(frame: CGRect(x: viewExpandDetail.frame.origin.x, y: viewExpandDetail.frame.maxY, width: viewExpandDetail.bounds.width, height: 20.0), emptyView: true)
            body.tag = tagForView
            
            scrollview.addSubview(body)
            
            posYViewExpand = body.frame.maxY
            
            self.heightScroll = posYViewExpand
            
            //Reiniciamos el valor de tagForView
            tagForView = 1
            /*JONATHAAAAAn*/
            
            /*tagForView = tagHeaderCard
            //            let last = scrollview.subviews.last?.subviews.last
            print("POSICION DONDE SE MOSTRARA EL VIEW EXPAND \(posYViewExpand)")
            let frameViewExpand = CGRect(x: 0.0, y: posYViewExpand, width: self.scrollview.bounds.width, height: 100.0)
            let viewExpand = ViewExpand(frame: frameViewExpand, typeCard: .Móvil, indxService: indxService)
            viewExpand.tag = tagForView
            viewExpand.delegate = self
            
            scrollview.addSubview(viewExpand)
            tagForView += 1
            
            self.createBorderViewExpand(view: viewExpand)
            
            print("POSICION DONDE SE MOSTRARA EL VIEW BODY EXPAND \(viewExpand.frame.maxY)")
            //TEST, creamos un view vacio para usarlo posteriormente como el detalle de la vista expandible
            let body = ViewBodyExpand(frame: CGRect(x: viewExpand.frame.origin.x, y: viewExpand.frame.maxY, width: viewExpand.bounds.width, height: 20.0), emptyView: true)
            body.tag = tagForView
            
            scrollview.addSubview(body)
            //            tagForView += 1
            
            // Los tag mayores a mil son utilizados solo por movil, para mostrar las gráficas de los servicios usados
            if tagForView > 1000 {
                self.createBorderBodyExpand(view: body)
            }else {
                self.createBorderLastView(view: body)
            }
            
            //            addConstraintsTo(viewExpand: viewExpand, view: self.view, lastView: last, bodyView: body)
            posYViewExpand = body.frame.maxY
            
            self.heightScroll = posYViewExpand
            
            if self.view.frame.height >= 752 {
                self.heightScroll += 50
            }*/
            
            scrollview.contentSize = CGSize(width: self.scrollview.bounds.width, height: self.heightScroll + tabBarHeight)
            
            break
        case .Internet:
            if true == SessionSingleton.sharedInstance.isConsumingService() {
                break;
            }
            tagForView = tagHeaderCard
            //            let last = scrollview.subviews.last?.subviews.last
            print("POSICION DONDE SE MOSTRARA EL VIEW EXPAND \(posYViewExpand)")
            let frameViewExpand = CGRect(x: 0.0, y: posYViewExpand, width: self.scrollview.bounds.width, height: 100.0)
            let viewExpand = ViewExpand(frame: frameViewExpand, typeCard: .Internet)
            viewExpand.tag = tagForView
            viewExpand.delegate = self
            
            scrollview.addSubview(viewExpand)
            tagForView += 1
            self.createBorderViewExpand(view: viewExpand)
            
            print("POSICION DONDE SE MOSTRARA EL VIEW BODY EXPAND \(viewExpand.frame.maxY)")
            //TEST, creamos un view vacio para usarlo posteriormente como el detalle de la vista expandible
            let body = ViewBodyExpand(frame: CGRect(x: viewExpand.frame.origin.x, y: viewExpand.frame.maxY, width: viewExpand.bounds.width, height: 20.0), emptyView: true)
            body.tag = tagForView
            
            scrollview.addSubview(body)
            //            tagForView += 1
            
            self.createBorderLastView(view: body)
            //            addConstraintsTo(viewExpand: viewExpand, view: self.view, lastView: last, bodyView: body)
            
            posYViewExpand = body.frame.maxY
            
            self.heightScroll = posYViewExpand
            
            
            if self.view.frame.height >= 752 {
                self.heightScroll += 50
            }
            
            scrollview.contentSize = CGSize(width: self.scrollview.bounds.width, height: self.heightScroll + tabBarHeight)
            break
            
        case .Teléfono:
            if true == SessionSingleton.sharedInstance.isConsumingService() {
                break;
            }
            break;
        case .Televisión:
            if true == SessionSingleton.sharedInstance.isConsumingService() {
                break;
            }
            tagForView = tagHeaderCard
            print("POSICION DONDE SE MOSTRARA EL VIEW EXPAND \(posYViewExpand)")
            //            let last = scrollview.subviews.last?.subviews.last
            let frameViewExpand = CGRect(x: 0.0, y: posYViewExpand, width: self.scrollview.bounds.width, height: 100.0)
            let viewExpand = ViewExpand(frame: frameViewExpand, typeCard: .Televisión)
            viewExpand.tag = tagForView
            viewExpand.delegate = self
            
            scrollview.addSubview(viewExpand)
            tagForView += 1
            self.createBorderViewExpand(view: viewExpand)
            
            print("POSICION DONDE SE MOSTRARA EL VIEW BODY EXPAND \(viewExpand.frame.maxY)")
            //TEST, creamos un view vacio para usarlo posteriormente como el detalle de la vista expandible
            let body = ViewBodyExpand(frame: CGRect(x: viewExpand.frame.origin.x, y: viewExpand.frame.maxY, width: viewExpand.bounds.width, height: 20.0), emptyView: true)
            body.tag = tagForView
            
            scrollview.addSubview(body)
            //            tagForView += 1
            
            self.createBorderLastView(view: body)
            
            //            addConstraintsTo(viewExpand: viewExpand, view: self.view, lastView: last, bodyView: body)
            
            posYViewExpand = body.frame.maxY
            
            self.heightScroll = posYViewExpand
            if self.view.frame.height >= 752 {
                self.heightScroll += 50
            }
            scrollview.contentSize = CGSize(width: self.scrollview.bounds.width, height: self.heightScroll + tabBarHeight)
            break
        case .TodoClaro:
            if true == SessionSingleton.sharedInstance.isConsumingService() {
                break;
            }
            //            let last = scrollview.subviews.last?.subviews.last
            let frameViewExpand = CGRect(x: 0.0, y: posYViewExpand, width: self.scrollview.bounds.width, height: 100.0)
            let viewExpand = ViewExpand(frame: frameViewExpand, typeCard: .TodoClaro)
            viewExpand.tag = tagForView
            viewExpand.delegate = self
            
            scrollview.addSubview(viewExpand)
            tagForView += 1
            self.createBorderViewExpand(view: viewExpand)
            
            let body = ViewBodyExpand(frame: CGRect(x: viewExpand.frame.origin.x, y: viewExpand.frame.maxY, width: viewExpand.bounds.width, height: 20.0), emptyView: true)
            body.tag = tagForView
            
            scrollview.addSubview(body)
            tagForView += 1
            
            self.createBorderLastView(view: body)
            
            //            addConstraintsTo(viewExpand: viewExpand, view: self.view, lastView: last, bodyView: body)
            
            posYViewExpand = body.frame.maxY
            
            heightScroll = posYViewExpand
            if self.view.frame.height >= 752 {
                self.heightScroll += 50
            }
            scrollview.contentSize = CGSize(width: self.scrollview.bounds.width, height: heightScroll + tabBarHeight)
            break
        default:
            break
        }
        
    }
    
    //    func addConstraintsTo(viewExpand: UIView, view: UIView, lastView : UIView?, bodyView: UIView) {
    //        if lastView != nil {
    //            constrain(viewExpand, view, lastView!, bodyView) { (expand, view, last, body)  in
    //                expand.top == last.bottom + 10
    //                expand.leading == view.leading
    //                expand.trailing == view.trailing
    //                expand.height >= 40
    //
    //                body.top == expand.bottom
    //                body.leading == view.leading
    //                body.trailing == view.trailing
    //                body.height >= 20
    //            }
    //        }
    //    }
    
    /// Para mostrar los encabezados de las celdas expandibles
    /// return : Arreglo con las opciones a mostrar para que se puedan expandir
    func createViewsExpands(accountID: String = "") -> [[ViewExpandData]] {
        var viewExpandInfo: [[ViewExpandData]] = [[ViewExpandData]]()
        
        switch self.typeCard {
        case .Resumen:
            viewExpandInfo = self.detailResumeViewExpand()
            break
        case .Móvil:
            let serialQueue = DispatchQueue(label: "serialQueue")
            serialQueue.sync {
                do {
                    viewExpandInfo = self.detailMovilViewExpand(accountID: accountID)
                }
//                catch let error {
//                    print("Error \(error)")
//                }
            }
            break
        case .Internet:
            break
        case .Televisión:
            break
        case .Teléfono:
            break;
        case .TodoClaro:
            break
        default:
            break
        }
        
        return viewExpandInfo
    }
    /// Mostrar el detalle de las opciones para la sección de *Resumen*
    /// return : Arreglo con las opciones a mostrar para que se puedan expandir
    func detailResumeViewExpand() -> [[ViewExpandData]] {
        //Saber los tipos de cuentas del usuario
        //        self.getTypeAccounts()
        var arrayExpand: [ViewExpandData] = [ViewExpandData]()
        var numberExpandViewArray: [[ViewExpandData]] = [[ViewExpandData]]()
        let auxiliar = self.accountArraySorted//self.accountArray.sortServiceAccount()
        //for account in self.accountArray {
        
        /*********************** JONATHAN AJUSTE ***********************/
        var idxViewExpand: Int = 0
        for account in auxiliar {
            var counterService = (account.detailServices?.accountDetail?.associatedServices?.count)!
            // Por cada cuenta accedemos a los servicios asociados que tenga
            for idxService in 0 ..< counterService {
                arrayExpand.removeAll()
                
                let detailPlan = account.detailServices?.detailPlan?[safe: idxService]
                var title = "title"
                var desc = account.detailServices?.accountDetail?.associatedServices![idxService].serviceID ?? " "
                //El primer elemento del arreglo será utilizado para el titulo del ViewExpand
                if account.isTodoClaro() {
                    title = "Todo Claro"
                    desc = ""
                    let expandView = ViewExpandData(titleText: title, descriptionText: desc, indexData: idxViewExpand)
                    arrayExpand.append(expandView)
                }else {
                    //Identificar que nombre se debe mostrar
                    guard let myServices = account.detailServices?.associatedService?.first?.serviceType else {
                        continue;
                    }
                    title = self.getTitleHeaderViewExpand(serviceType: myServices)
                    let expandView = ViewExpandData(titleText: title, descriptionText: desc, indexData: idxViewExpand)
                    arrayExpand.append(expandView)
                }
                //Continuamos con el ingreso de nuevos valores en arrayExpand
                //Identificar si es todo claro
                if (account.isTodoClaro()) { // (account.detailServices?.accountDetail?.associatedServices?.count)! >= 2 {
                    title = conf?.translations?.data?.billing?.accountId ?? "No. de cuenta:"
                    desc = account.detailServices?.accountDetail?.accountId ?? ""
                    let expandView = ViewExpandData(titleText: title, descriptionText: desc, indexData: idxViewExpand)
                    arrayExpand.append(expandView)
                }else {
                    /*Only for account TV*/
                    if title == TypeCardView.Televisión.rawValue {
                        title = conf?.translations?.data?.billing?.accountId ?? "No. de cuenta:"
                        desc = account.detailServices?.accountDetail?.accountId ?? ""
                        
                        //En caso de ser TV solo se accede a un elemento
                        counterService = 1
                    }
                    /*********************/
                    if title == TypeCardView.Móvil.rawValue {
                        title = conf?.translations?.data?.generales?.phone ?? "Teléfono"
                    }
                    /*Only for internet*/
                    if title == TypeCardView.Internet.rawValue {
                        desc = (account.account?.accountId)!
                    }
                    /*********************/
                    let expandView = ViewExpandData(titleText: title, descriptionText: desc, indexData: idxViewExpand)
                    arrayExpand.append(expandView)
                }
                //Obtenemos los bill items para obtener el monto total
                var desc2 = "No disponible"
                if let bi = detailPlan?.retrieveBillDetailsResponse?.billItem {
                    for bill in bi {
                        let titles = self.getTitleText(lob: account.account!.lineOfBusiness!)
                        let title2 = titles.0//"Monto a pagar:"
                        if bill.descriptionType == "3" {
                            desc2 = String(format: "$ %@", bill.amountFormat!)
                            let expand2 = ViewExpandData(titleText: title2, descriptionText: desc2, indexData: idxViewExpand)
                            arrayExpand.append(expand2)
                            let title3 = titles.1//"Antes del "
                            let myDate = convertStringToDateO(stringDate: detailPlan?.retrieveBillDetailsResponse?.dueDate ?? "")
                            let date = getFullStringDate(date: myDate)
                            let expand3 = ViewExpandData(titleText: title3, descriptionText: date, indexData: idxViewExpand)
                            arrayExpand.append(expand3)
                        }
                    }
                }
                
//                arrayExpand.append(ViewExpandData(titleText: "AccountID", descriptionText: account.account?.accountId ?? "", indexData: -1));
                
                idxViewExpand += 1
                
                //Insertamos la información de la cuenta
                numberExpandViewArray.append(arrayExpand)
                
                // En caso de que el line of bussines sea igual a uno solo se debe realizar una iteración.
                if account.account?.lineOfBusiness == "1" {
                    break
                }
            }
        }
        /*********************** JONATHAN AJUSTE ***********************/
        
        /*for account in auxiliar {
            var total = 1;
            
            if "1" == account.detailServices?.associatedService?.first?.serviceType {
                total = account.detailServices?.detailPlan?.count ?? 0;
            }
            
            for idx in 0 ..< total {
                if idx >= account.detailServices?.detailPlan?.count ?? 0 {
                    continue;
                }
                arrayExpand.removeAll()
                let detailPlan = account.detailServices?.detailPlan?[safe: idx]
                var title = "title"
                let t = account.detailServices?.accountDetail?.associatedServices?.count ?? 0;
                
                var desc = (1 == t ? account.detailServices?.accountDetail?.associatedServices?.first?.serviceID ?? "" : account.detailServices?.accountDetail?.associatedServices?[safe: idx]?.serviceID ?? "");
                //El primer elemento del arreglo será utilizado para el titulo del ViewExpand
                if account.isTodoClaro() {
                    title = "Todo Claro"
                    desc = ""
                    let expandView = ViewExpandData(titleText: title, descriptionText: desc, indexData: idx)
                    arrayExpand.append(expandView)
                }else {
                    //Identificar que nombre se debe mostrar
                    guard let myServices = account.detailServices?.associatedService?.first?.serviceType else {
                        continue;
                    }
                    title = self.getTitleHeaderViewExpand(serviceType: myServices)
                    let expandView = ViewExpandData(titleText: title, descriptionText: desc, indexData: idx)
                    arrayExpand.append(expandView)
                }
                //Identificar si es todo claro
                if (account.isTodoClaro()) { // (account.detailServices?.accountDetail?.associatedServices?.count)! >= 2 {
                    title = conf?.translations?.data?.billing?.accountId ?? "No. de cuenta:"
                    desc = account.detailServices?.accountDetail?.accountId ?? ""
                    let expandView = ViewExpandData(titleText: title, descriptionText: desc, indexData: idx)
                    arrayExpand.append(expandView)
                }else {
                    /*Only for account TV*/
                    if title == TypeCardView.Televisión.rawValue {
                        title = conf?.translations?.data?.billing?.accountId ?? "No. de cuenta:"
                        desc = account.detailServices?.accountDetail?.accountId ?? ""
                    }
                    /*********************/
                    if title == TypeCardView.Móvil.rawValue {
                        title = conf?.translations?.data?.generales?.phone ?? "Teléfono"
                    }
                    /*Only for internet*/
                    if title == TypeCardView.Internet.rawValue {
                        desc = (account.account?.accountId)!
                    }
                    /*********************/
                    let expandView = ViewExpandData(titleText: title, descriptionText: desc, indexData: idx)
                    arrayExpand.append(expandView)
                }
                //Obtenemos los bill items para obtener el monto total
                var desc2 = "No disponible"
                if let bi = detailPlan?.retrieveBillDetailsResponse?.billItem {
                    for bill in bi {
                        let titles = self.getTitleText(lob: account.account!.lineOfBusiness!)
                        let title2 = titles.0//"Monto a pagar:"
                        if bill.descriptionType == "3" {
                            desc2 = String(format: "$ %@", bill.amountFormat!)
                            let expand2 = ViewExpandData(titleText: title2, descriptionText: desc2, indexData: idx)
                            arrayExpand.append(expand2)
                            let title3 = titles.1//"Antes del "
                            let myDate = convertStringToDateO(stringDate: detailPlan?.retrieveBillDetailsResponse?.dueDate ?? "")
                            let date = getFullStringDate(date: myDate)
                            let expand3 = ViewExpandData(titleText: title3, descriptionText: date, indexData: idx)
                            arrayExpand.append(expand3)
                        }
                    }
                }
                
                arrayExpand.append(ViewExpandData(titleText: "AccountID", descriptionText: account.account?.accountId ?? "", indexData: -1));
                
//                numberExpandViewArray.append(arrayExpand)
            }
            numberExpandViewArray.append(arrayExpand)
        }*/
        
        return numberExpandViewArray//arrayExpand
    }
    
    /// Función para obtener el detalle de cada informacion de móvil
    func detailMovilViewExpand(accountID: String/*account: ServiceAccount, tagViewHeader: Int, posY:CGFloat*/) -> [[ViewExpandData]] {
        var arrayExpand: [ViewExpandData] = [ViewExpandData]()
        var numberExpandViewArray: [[ViewExpandData]] = [[ViewExpandData]]()
        let auxiliar = self.accountArray//.sortServiceAccount()
//        var posYcontainer = posY
        
//        let tagServiceUsage: Int = 1001
//        var tagService: Int = 0
        
        for account in auxiliar {
            if !("2" == account.account?.lineOfBusiness || "3" == account.account?.lineOfBusiness) {
                continue;
            }
            
            if account.account?.accountId == accountID {
                let totalServices = account.detailServices?.associatedService?.count ?? 0;
                for idxService in 0 ..< totalServices {
                    //Obtenemos el uso de servicios
                    if let arrayServiceUsage = account.detailServices?.detailPlan![safe: idxService]?.retrieveConsumptionDetailInformation?.serviceUsage {
                        //                var countService: Int = 0
                        var tagService: Int = 0
                        var counter: Int = 0
                        arrayExpand.removeAll()
                    
                        //Para mostrar la información de las graficas
                        for serviceUsage in arrayServiceUsage {
                            let titleHeaderExpand = serviceUsage.serviceType ?? ""
                        
                            if titleHeaderExpand == "VOZ" || titleHeaderExpand == "SMS" || titleHeaderExpand == "INTERNET" || titleHeaderExpand == "MMS" {
                                if let sf = serviceUsage.serviceFeatureUsage {
                                    for serviceFeatute in sf {

                                    //Validar que sea diferente de cero
    //                                if serviceFeatute.serviceFeatureUsageLimit?.quantity != "0" {
                                            let title = "Titulo a mostrar"
                                            let desc = serviceFeatute.serviceFeatureType ?? ""

                                            let item = ViewExpandData(titleText: title, descriptionText: desc, indexData: counter)
                                            arrayExpand.append(item)

                                            counter += 1
    //                                }
                                    }
                                }
                            }else {
                                //Agregar los View Expand para cada cuenta o plan
                                //Creamos el tag dependiendo el tag header
                                let title = "Titulo a mostrar"
                                var desc = serviceUsage.serviceType ?? "Nada de nada"
                                //Validamos si son redes sociales
                                if desc.uppercased().contains("RRSS") {
                                    desc = "RSS"
                                }
                                let item = ViewExpandData(titleText: title, descriptionText: desc, indexData: counter)
                                arrayExpand.append(item)
                            
                                counter += 1
                            }
                        
                        //Agregar los View Expand para cada cuenta o plan
                        //Creamos el tag dependiendo el tag header
                        /*let title = "Titulo a mostrar"
                        var desc = serviceUsage.serviceType ?? "Nada de nada"
                        //Validamos si son redes sociales
                        if desc.contains("RRSS") {
                            desc = "RSS"
                        }
                        let item = ViewExpandData(titleText: title, descriptionText: desc, indexData: counter)
                        arrayExpand.append(item)
                        
                        counter += 1*/
                        }
                        numberExpandViewArray.append(arrayExpand)
                        tagService += 2
                    }
                }
            }
        }
        return numberExpandViewArray
    }
    
    /// Obtener el titulo del encabezado para la vista expandible
    func getTitleHeaderViewExpand(serviceType: String) -> String {
        var title: String = ""
        switch serviceType {
        case "1":
            title = TypeCardView.Móvil.rawValue // "Móvil"
            break
        case "3":
            title = TypeCardView.Teléfono.rawValue // "Teléfono"
            break
        case "4":
            title = TypeCardView.Televisión.rawValue // "Televisión"
            break
        case "5":
            title = TypeCardView.Internet.rawValue // "Internet"
            break
        default:
            break
        }
        
        return title
    }
    
    //MARK: DETAIL FOR VIEW EXPAND
    /// Obtener la información a mostrar en la vista que se muestra y oculta al elegir el encabezado de una cuenta
    /// return : Arreglo con la información para cada tipo de cuenta
    func getInfoViewBodyExpand() -> [[ViewBodyExpandData]] {
        var arrayBody: [ViewBodyExpandData] = [ViewBodyExpandData]()
        var numberArrayBody:[[ViewBodyExpandData]] = [[ViewBodyExpandData]]()
        
        switch self.typeCard {
        case .Resumen:
            for account in self.accountArraySorted {
                guard let p = account.detail?.accountDetails?.plan else {
                    return [[ViewBodyExpandData]]();
                }
                
                for item in p {
                    arrayBody.removeAll()
                    if account.isTodoClaro() {
                        arrayBody = self.getDetailTodoClaroBodyExpand(account: account)
                    }
                    else {
                        guard let pl = item.planLines else {
                            return numberArrayBody;
                        }
                        
                        if (pl.count > 0) {
                            arrayBody = self.getDetailBodyExpand(pl: pl)
                        }
                    }
                    
                    numberArrayBody.append(arrayBody)
                }
            }
            break
        case .Móvil:
            //Identificar el indice del arreglo de cuentas
            for account in self.accountArray {
                arrayBody.removeAll()
                
                if !("2" == account.account?.lineOfBusiness || "3" == account.account?.lineOfBusiness) {
                    continue;
                }
                if let plans = account.detail?.accountDetails?.plan {
                    for plan in plans {
                        guard let pl = plan.planLines else {
                            return numberArrayBody;
                        }
                        
                        if (pl.count > 0) {
                            arrayBody = self.getDetailBodyExpand(pl: pl)
                            numberArrayBody.append(arrayBody)
                        }
                    }
                }
            }
            break
        case .Internet:
            for account in self.accountArray {
                arrayBody.removeAll()
                
                if account.account?.lineOfBusiness == "1" {
                    guard let pl = account.detail?.accountDetails?.plan?.first?.planLines else {
                        return numberArrayBody;
                    }
                    
                    if pl.count > 0 {
                        arrayBody = self.getDetailBodyExpand(pl: pl)
                        numberArrayBody.append(arrayBody)
                    }
                }
            }
            break
        case .Teléfono:
            break
        case .Televisión:
            for account in self.accountArray {
                arrayBody.removeAll()
                
                if account.account?.lineOfBusiness == "1" && !account.isTodoClaro() {
                    guard let pl = account.detail?.accountDetails?.plan?.first?.planLines else {
                        return numberArrayBody;
                    }
                    
                    if pl.count > 0 {
                        arrayBody = self.getDetailBodyExpand(pl: pl)
                        numberArrayBody.append(arrayBody)
                    }
                }
            }
            
            break
        case .TodoClaro:
            for account in self.accountArray {
                //                arrayBody.removeAll()
                
                //                if !("2" != account.account?.lineOfBusiness || "3" != account.account?.lineOfBusiness) {
                //if account.account?.lineOfBusiness != "1" && (account.detailServices?.associatedService?.count)! < 2 {
                if !account.isTodoClaro() {
                    continue;
                }
                
                guard let pl = account.detail?.accountDetails?.plan?.first?.planLines else {
                    return numberArrayBody;
                }
                
                if pl.count > 0 {
                    arrayBody = self.getDetailBodyExpand(pl: pl)
                    numberArrayBody.append(arrayBody)
                }
                
                /******************FUTUTO*****************/
                /*if account.isTodoClaro() {
                 arrayBody.removeAll()
                 arrayBody = self.getDetailTodoClaroBodyExpand(account: account)
                 numberArrayBody.append(arrayBody)
                 }*/
                /******************FUTUTO*****************/
                
            }
            
            break
        default:
            break
        }
        
        return numberArrayBody//arrayBody
    }
    
    
    func getInfoViewBodyExpandMovil(indexViewHeader: Int, indexServiceUsage: Int, accountID: String) -> [[ViewBodyExpandData]] {
        var arrayBody: [ViewBodyExpandData] = [ViewBodyExpandData]()
        var numberArrayBody:[[ViewBodyExpandData]] = [[ViewBodyExpandData]]()
        var typeSocial: String? = nil
//        let account = self.accountArray[indexViewHeader]
        
        for account in self.accountArray {
            arrayBody.removeAll()
            
            if !("2" == account.account?.lineOfBusiness || "3" == account.account?.lineOfBusiness) {
                continue;
            }
            
            if account.account?.accountId == accountID {
                if indexServiceUsage == self.getTotalViewExpandMovil(accountID: accountID)/*account.detailServices?.detailPlan!.first?.retrieveConsumptionDetailInformation?.serviceUsage!.count*/ {
                    //Para ver detalles de tu plan
                    if let plans = account.detail?.accountDetails?.plan {
                        for plan in plans {
                            guard let pl = plan.planLines else {
                                return numberArrayBody;
                            }
                            
                            if (pl.count > 0) {
                                arrayBody = self.getDetailBodyExpand(pl: pl)
                            }
                        }
                        
                        break
                    }
                }else {
                    //Como esta hardcode la respuesta
                    
                    /*let usageService = account.detailServices?.detailPlan!.first?.retrieveConsumptionDetailInformation?.serviceUsage![indexServiceUsage]
                    //Obtener los datos disponibles
                    //Saber si es Red social, en caso de serlo el primer elemento del arreglo tendra el service ID
                    if Int((usageService?.serviceID)!)! >= 7 {//Son redes sociales
                        typeSocial = (usageService?.serviceType)!
                    }*/
                    
                    //Obtenemos la información ya sea VOZ TD, VOZ CLARO, SMS TD, SMS CLARO
//                    for serviceFeature in (usageService?.serviceFeatureUsage)! {
                        //Debemos obtener la posición de donde debemos sacar la información
                    arrayBody = self.getInfoMovilBodyExpand(indexViewHeader: indexViewHeader, indexServiceUsage: indexServiceUsage, accountID: accountID, typeSocial: typeSocial)
//                    }
                    
                    
                    break
                    
                    //Obtener el limite del plan
                    /*let usageLimit = usageService?.serviceFeatureUsage?.first?.serviceFeatureUsageLimit?.quantity
                    let unitUsage = usageService?.serviceFeatureUsage?.first?.serviceFeatureUsageLimit?.unit
                    let item0 = ViewBodyExpandData(title: usageLimit!, description: unitUsage!, isTitle: false, socialNetwork: typeSocial)
                    arrayBody.append(item0)
                    let consumoUser = "Disponibles"
                    let consumoUserUnit = usageService?.serviceFeatureUsage?.first?.featureUsage?.quantity
                    let item1 = ViewBodyExpandData(title: consumoUser, description: consumoUserUnit!, isTitle: false, socialNetwork: nil)
                    arrayBody.append(item1)
                    //Obtenemos la fecha de vigencia
                    let dateTitle = "Vence el:"
                    let stringToDate = convertStringToDate(stringDate: (usageService?.serviceUsagePeriod?.endDate)!)
                    let dateValue = getStringDate(date: stringToDate)
                    let item2 = ViewBodyExpandData(title: dateTitle, description: dateValue, isTitle: false, socialNetwork: nil)
                    arrayBody.append(item2)
                    //Obtenemos el tipo de servicio
                    let unit = "unidad"
                    let unitValue = usageService?.serviceType
                    let item3 = ViewBodyExpandData(title: unit, description: unitValue!, isTitle: false, socialNetwork: nil)
                    arrayBody.append(item3)*/
                }
                
//                break
            }
            
        }
        
        numberArrayBody.append(arrayBody)
        return numberArrayBody
    }
    
    func getInfoMovilBodyExpand(indexViewHeader: Int, indexServiceUsage: Int, accountID: String, typeSocial: String?) -> [ViewBodyExpandData] {
        var counter = 0
        var arrayBody: [ViewBodyExpandData] = [ViewBodyExpandData]()
//        var numberArrayBody:[[ViewBodyExpandData]] = [[ViewBodyExpandData]]()
//        self.totalCountViewExpandMovil = 0
        var breakFor: Bool = false
        
        for account in self.accountArray {
            
            if !("2" == account.account?.lineOfBusiness || "3" == account.account?.lineOfBusiness) {
                continue;
            }
            
            if account.account?.accountId == accountID {
                arrayBody.removeAll()
                
                for serviceUsage in (account.detailServices?.detailPlan?.first?.retrieveConsumptionDetailInformation?.serviceUsage)! {
                    for serviceFeature in (serviceUsage.serviceFeatureUsage)! {
                        if counter == indexServiceUsage {
                            print("ENCONTRAMOS LA INFORMACIÓN A MOSTRAR")
                            //Obtener el limite del plan
                            let usageLimit = serviceFeature.serviceFeatureUsageLimit?.quantity
                            let unitUsage = serviceFeature.serviceFeatureUsageLimit?.unit
                            let item0 = ViewBodyExpandData(title: ("\(usageLimit)"), description: unitUsage!, isTitle: false, socialNetwork: typeSocial)
                            arrayBody.append(item0)
                            let consumoUser = serviceFeature.featureUsage?.quantity
                            let consumoUserUnit = serviceFeature.featureUsage?.unit ?? "Disponibles" //"Disponibles"
                            let item1 = ViewBodyExpandData(title: ("\(consumoUser)"), description: consumoUserUnit, isTitle: false, socialNetwork: typeSocial)
                            arrayBody.append(item1)
                            //Obtenemos la fecha de vigencia
                            let dateTitle = "Vence el:"
                            let stringToDate = convertStringToDate(stringDate: (serviceUsage.serviceUsagePeriod?.endDate)!)
                            let dateValue = getStringDate(date: stringToDate)
                            let item2 = ViewBodyExpandData(title: dateTitle, description: dateValue, isTitle: false, socialNetwork: nil)
                            arrayBody.append(item2)
                            //Obtenemos el tipo de servicio
                            let unit = "unidad"
                            let unitValue = serviceFeature.serviceFeatureUsageLimit?.unit
                            let item3 = ViewBodyExpandData(title: unit, description: unitValue!, isTitle: false, socialNetwork: nil)
                            arrayBody.append(item3)
                            
//                            numberArrayBody.append(arrayBody)
                            breakFor = true
                            break
                        }
                        counter += 1
                    }
                    if breakFor {
                        break
                    }
                }
            }
        }
        
        return arrayBody
    }
    
    func getTotalViewExpandMovil(accountID: String) -> Int {
        var counter = 0
        
        for account in self.accountArray {
            if !("2" == account.account?.lineOfBusiness || "3" == account.account?.lineOfBusiness) {
                continue;
            }
            
            if account.account?.accountId == accountID {
                if let su = account.detailServices?.detailPlan?.first?.retrieveConsumptionDetailInformation?.serviceUsage {
                    for serviceUsage in su {
                        let titleHeaderExpand = serviceUsage.serviceType ?? ""

                        if titleHeaderExpand == "VOZ" || titleHeaderExpand == "SMS" || titleHeaderExpand == "INTERNET" || titleHeaderExpand == "MMS" {
                            for serviceFeature in (serviceUsage.serviceFeatureUsage)! {
                                //Solo se tomaran en cuenta aquellos valores distintos de cero
    //                            if serviceFeature.serviceFeatureUsageLimit?.quantity != "0" {
                                    counter += 1
    //                            }
                            }
                        }else {
                            counter += 1
                        }
                    }
                } else {
                    counter = 0;
                }
            }
        }
        
        return counter
    }
    
    /// Funcion para validar si es Detalle de plan movil
    func showDetailMovilPlan(accountID: String, indexViewExpand: Int) -> Bool {
        var showGraphicMovil: Bool = true
        
        for account in self.accountArray {
            if !("2" == account.account?.lineOfBusiness || "3" == account.account?.lineOfBusiness) {
                continue;
            }
            
            if account.account?.accountId == accountID {
                if indexViewExpand == self.getTotalViewExpandMovil(accountID: accountID)/*account.detailServices?.detailPlan!.first?.retrieveConsumptionDetailInformation?.serviceUsage!.count*/ {
                    showGraphicMovil = false
                }
                break
            }
        }
        
        return showGraphicMovil
    }
    
    /// Obtener la información para las diferentes tipos de cuentas
    /// return : Arreglo con la información para cada tipo de cuenta
    func getDetailBodyExpand(pl: [PlanLine]) -> [ViewBodyExpandData] {
        var arrayBody: [ViewBodyExpandData] = [ViewBodyExpandData]()
        
        for planLines in pl {
            let title = planLines.featureCategory
            let quantity = planLines.usageLimit?.quantity ?? "sin información"
            let unit = planLines.usageLimit?.unit?.uppercased() ?? ""
            var desc = ""
            if quantity != "sin información" {
                let quantityRound = NSString(format: "%@", quantity)
                //let tmp = roundf(quantityRound.floatValue)
                let tmp2 = truncf(quantityRound.floatValue)
                desc = NSString(format:"%.0f %@", tmp2, unit) as String
            }else {
                desc = quantity
            }
            
            if quantity == "-1" {
                desc = "ILIMITADO"
            }
            if quantity == "-3" {
                desc = "LIBRES"
            }
            let bodyExpand = ViewBodyExpandData(title: title!, description: desc, isTitle: false, socialNetwork: nil)
            
            arrayBody.append(bodyExpand)
        }
        
        return arrayBody
    }
    /// Obtener la información para las cuentas de tipo Todo Claro
    /// return : Arreglo con la información para cada tipo de cuenta
    func getDetailTodoClaroBodyExpand(account: ServiceAccount) -> [ViewBodyExpandData] {
        var arrayBody: [ViewBodyExpandData] = [ViewBodyExpandData]()
        
        for service in (account.detailServices?.accountDetail?.associatedServices)! {
            let title = self.getTitleByServiceType(serviceType: service.serviceType!)
            //service.serviceID
            let desc = " "
            
            let bodyExpand = ViewBodyExpandData(title: title, description: desc, isTitle: false, socialNetwork: nil)
            arrayBody.append(bodyExpand)
        }
        
        var arrayServID: [ViewBodyExpandData] = [ViewBodyExpandData]()
        
        for index in 0 ..< arrayBody.count - 1 {
            let service = arrayBody[index].title
            
            let nextIndex = index + 1
            
            for indexTmp in nextIndex ..< arrayBody.count {
                if service == arrayBody[indexTmp].title {
                    arrayServID.append(arrayBody[indexTmp])
                }
            }
        }
        
        if self.typeCard == .Resumen {
            //Remove the name duplicates
            var tmpServID: [ViewBodyExpandData] = [ViewBodyExpandData]()
            for serv in arrayServID {
                if !tmpServID.contains(where: {serv.title == $0.title}) {
                    tmpServID.append(serv)
                }
            }
            arrayServID = tmpServID
            return arrayServID
        }else if self.typeCard == .TodoClaro {
            arrayBody.removeAll()
            
            for indexServ in 0 ..< arrayServID.count {
                arrayServID[indexServ].isTitle = true
                arrayBody.append(arrayServID[indexServ])
                
                for service in (account.detailServices?.accountDetail?.associatedServices)! {
                    let title = self.getTitleByServiceType(serviceType: service.serviceType!)
                    
                    if title/*service.serviceID*/ == arrayServID[indexServ].title {
                        let title = service.serviceDescription
                        let desc = " "
                        
                        let bodyExpand = ViewBodyExpandData(title: title!, description: desc, isTitle: false, socialNetwork: nil)
                        arrayBody.append(bodyExpand)
                    }
                }
            }
            
            //            arrayServID = arrayBody
            return arrayBody
        }
        
        return arrayServID
    }
    /// Mostrar los titulos en la vista expandible, solo para la opción de *TodoClaro*
    func getTitleByServiceType(serviceType: String) -> String {
        var title: String = ""
        
        switch serviceType {
        case "3":
            title = "Linea fija"
            break
        case "4":
            title = "Televisión"
            break
        case "5":
            title = "Internet"
            break
        default:
            break
        }
        
        return title
    }
    
    /// Si no existe información para una cuenta se muestra un mensaje de error
    /// return : arreglo con la leyenda a mostra para notificar acerca del error
    func createErrorMessage() -> [ViewBodyExpandData] {
        var arrayBody: [ViewBodyExpandData] = [ViewBodyExpandData]()
        
        //Creamos el mensaje de error
        let title = "Sin información"
        let desc = " "
        let bodyExpand = ViewBodyExpandData(title: title, description: desc, isTitle: false, socialNetwork: nil)
        arrayBody.append(bodyExpand)
        
        return arrayBody
    }
    /// Para mostrar u ocultar la información según la vista elegida.
    /// Parameter tagView: identificador de la vista que se debe expandir
    /// Parameter expand: Bandera para saber si se debe mostrar u ocultar la información de dicha cuenta
    /// Parameter indxService: index del tipo de servicio seleccionado
    func createBodyExpandView(tagView: Int, expand: Bool, indxService : Int = 0, accountID: String) {
        let auxTmpMovil = self.getIndexHeaderCard(tagView: tagView)
        
        var heightViewExpand: CGFloat = 0.0
        //We get the position from the expand view
        for view in scrollview.subviews {
            //Cambiamos el icono de - a + de la celda que este expandible en ese momento
            /*if view.tag != tagView - 1 {
                if let viewHeaderExpand = view as? ViewExpand {
                    if viewHeaderExpand.isExpanded {
                        viewHeaderExpand.isExpanded = true
                        viewHeaderExpand.changeIconButton()
                    }
                }
            }*/
            //Buscamos el view body para pintar la informacion expandible
            if view.tag == tagView {
                let posMaxY = view.frame.maxY
                let posMinY = view.frame.minY
                
                let posx:CGFloat = view.frame.origin.x
                let posy:CGFloat = view.frame.origin.y
                
                let body = view as! ViewBodyExpand
                
                if expand {
                    UIView.animateKeyframes(withDuration: 1.0, delay: 0.2, options: .calculationModeLinear, animations: {
                        body.frame = CGRect(x: posx, y: posy, width: self.scrollview.bounds.width, height: 20.0)
                        var arrayBodyExpand = self.getInfoViewBodyExpand()
                        var index = self.getIndexArrayViewBodyExpand(tagView: tagView)
                        
                        if self.typeCard == .Móvil {
                            arrayBodyExpand = self.getInfoViewBodyExpandMovil(indexViewHeader: auxTmpMovil, indexServiceUsage: indxService, accountID: accountID)
                            index = 0
                        }
                        
                        if arrayBodyExpand.count == 0 {
                            index = 0
                            let error = self.createErrorMessage()
                            arrayBodyExpand.append(error)
                        }else if !arrayBodyExpand.indices.contains(index) {
                            let error = self.createErrorMessage()
                            arrayBodyExpand.append(error)
                            
                            index = arrayBodyExpand.count - 1
                        }
                        
                        body.setValueBody(arrayBody: arrayBodyExpand[index])
                        
                        //For hidde the button detail
                        var hiddeBtnDetail = false
                        switch self.typeCard {
                        case .Resumen:
                            hiddeBtnDetail = false
                            break
                        case .Internet, .Móvil, .Televisión, .TodoClaro, .Teléfono:
                            hiddeBtnDetail = true
                            break
                        default:
                            break
                        }
                        
                        var showGraphicMovil = false
                        if self.typeCard == .Móvil {
                            showGraphicMovil = self.showDetailMovilPlan(accountID: accountID, indexViewExpand: indxService)
                        }
                        body.showExpandView(expand: true, hiddeBtnDetail: hiddeBtnDetail, showGraphicMovil: showGraphicMovil)
                        body.isExpand = true
                        self.updateBorderLastView(view: body)
                        
                        heightViewExpand = body.getHeightViewBodyExpand() - (posMaxY - posMinY)
                        self.heightScroll = self.heightScroll + heightViewExpand + 20
                    }, completion: { (bull ) in
                        
                    } )
                }else {
                    UIView.animateKeyframes(withDuration: 1.0, delay: 0.2, options: .calculationModeLinear, animations: {
                        heightViewExpand = body.getHeightViewBodyExpand() - 20.0 //- (posMaxY - posMinY)
                        self.heightScroll = self.heightScroll - heightViewExpand//heightViewExpand
                        body.showExpandView(expand: false, hiddeBtnDetail: true)
                        body.isExpand = false
                        self.updateBorderLastView(view: body)
                    }, completion: { bull in
                        
                    })
                }
                
                UIView.animateKeyframes(withDuration: 1.0, delay: 0.2, options: .calculationModeCubic, animations: {
                    self.scrollview.contentSize = CGSize(width: self.scrollview.bounds.width, height: self.heightScroll + self.tabBarHeight)
                }, completion: nil)
                
                break
            }/*else {//Colapsar las demas vistas que esten abiertas
                if let body = view as? ViewBodyExpand {
                    if body.isExpand {
                        UIView.animateKeyframes(withDuration: 1.0, delay: 0.2, options: .calculationModeLinear, animations: {
                            heightViewExpand = body.getHeightViewBodyExpand() - 20.0 //- (posMaxY - posMinY)
//                            if self.typeCard == .Móvil {
//                                heightViewExpand = 140.0 - 20.0
//                            }
                            self.heightScroll = self.heightScroll - heightViewExpand//heightViewExpand
                            body.showExpandView(expand: false, hiddeBtnDetail: true)
                            body.isExpand = false
                            self.updateBorderLastView(view: body)
                        }, completion: { bull in
                            UIView.animateKeyframes(withDuration: 1.0, delay: 0.2, options: .calculationModeCubic, animations: {
                                self.scrollview.contentSize = CGSize(width: self.scrollview.bounds.width, height: self.heightScroll + self.tabBarHeight)
                            }, completion: nil)
                        })
                            
                        self.updatePosYforView(tagView: body.tag, heightView: heightViewExpand, expand: false)
                    }
                }
            }*/
        }
//        UIView.animateKeyframes(withDuration: 1.0, delay: 0.2, options: .calculationModeCubic, animations: {
//            self.scrollview.contentSize = CGSize(width: self.scrollview.bounds.width, height: self.heightScroll + self.tabBarHeight)
//        }, completion: nil)
        self.collapseAllViews(currentViewExpand: tagView)
        self.updatePosYforView(tagView: tagView, heightView: heightViewExpand, expand: expand)
    }
    /// Para obtener el index de la vista que se debe expandir u ocultar
    /// Parameter tagView: identificador de la vista (encabezado) que se selecciono para mostrar su detalle
    /// return: Int index de la vista a expandir u ocultar
    private func getIndexArrayViewBodyExpand(tagView: Int) -> Int {
        var tagTMP = tagView
        if tagTMP > 1000 {
            tagTMP = tagView % 1000
        }
        let valueInit: Int = 2
        let tagViewExpand = tagTMP/*tagView*/ - 1
        let tagViewBodyExpand = tagTMP//tagView
        
        return (tagViewExpand * valueInit - tagViewBodyExpand) / 2
    }
    
    private func getIndexHeaderCard(tagView: Int) -> Int {
        let tagTmp = tagView / 1000
        
        let tmp = tagTmp / 2
        return tmp
    }
    
    //TEST
    func collapseAllViews(currentViewExpand: Int) {
        var heightViewExpand: CGFloat = 0.0
        //We get the position from the expand view
        for view in scrollview.subviews {
            //Cambiamos el icono de - a + de la celda que este expandible en ese momento
            if view.tag != currentViewExpand - 1 {
                if let viewHeaderExpand = view as? ViewExpand {
                    if viewHeaderExpand.isExpanded {
                        viewHeaderExpand.isExpanded = true
                        viewHeaderExpand.changeIconButton()
                    }
                }
            }
            if let body = view as? ViewBodyExpand {
                if body.isExpand && body.tag != currentViewExpand {
                    UIView.animateKeyframes(withDuration: 1.0, delay: 0.2, options: .calculationModeLinear, animations: {
                        heightViewExpand = body.getHeightViewBodyExpand() - 20.0 //- (posMaxY - posMinY)
                        self.heightScroll = self.heightScroll - heightViewExpand//heightViewExpand
                        body.showExpandView(expand: false, hiddeBtnDetail: true)
                        body.isExpand = false
                        self.updateBorderLastView(view: body)
                    }, completion: { bull in
                        UIView.animateKeyframes(withDuration: 1.0, delay: 0.2, options: .calculationModeCubic, animations: {
                            self.scrollview.contentSize = CGSize(width: self.scrollview.bounds.width, height: self.heightScroll + self.tabBarHeight)
                        }, completion: nil)
                    })
                    
                    self.updatePosYforView(tagView: body.tag, heightView: heightViewExpand, expand: false)
                }
            }
        }
    }
    
    /// Actualizar la posición de las vistas para que no se vean encimadas una con otras
    /// Parameter tagView: identificador de la vista (encabezado)
    /// Parameter heightView: altura de la vista (encabezado)
    /// Parameter expand: Bandera para saber si deben actualizar su posición las otras vistas o tener la posición original
    func updatePosYforView(tagView: Int, heightView: CGFloat, expand: Bool) {
        var tagViewTmp = tagView
        if tagViewTmp > 1000 {
            self.updatePositionMovil(tagView: tagView, heightView: heightView, expand: expand)
            tagViewTmp = tagView % 1000
            tagViewTmp = (tagView - tagViewTmp) / 1000
        }
        for view in scrollview.subviews {
            //En caso de encontrar un tag mayor a 1000
            var tagTmp = view.tag
            if tagTmp > 1000 {
                tagTmp = view.tag % 1000
                tagTmp = (view.tag - tagTmp) / 1000
            }
            /********************************/
            
            if tagTmp/*view.tag*/ < tagViewTmp/*tagView*/ {
                continue
            }else if tagTmp/*view.tag*/ > tagViewTmp/*tagView*/ {
                let posx:CGFloat = view.frame.origin.x
                let posMinY:CGFloat = view.frame.origin.y
                let newHeight:CGFloat = heightView
                var newPosY:CGFloat = 0.0
                if expand {
                    newPosY = posMinY + newHeight
                }else {
                    newPosY = posMinY - newHeight
                }
                
                UIView.animateKeyframes(withDuration: 1.0, delay: 0.2, options: .calculationModeLinear, animations: {
                    let frame = CGRect(x: posx, y: newPosY, width: view.bounds.width, height: view.bounds.height)
                    view.frame = frame
                }, completion: nil)
                
                
            }
        }
    }
    
    func updatePositionMovil(tagView: Int, heightView: CGFloat, expand: Bool) {
        let tagTmp = tagView % 1000
        let tagViewTmp = (tagView - tagTmp) / 1000
        // Solo actializamos la posicion de las vistas expandibles de cada header
        for view in scrollview.subviews {
            let viewTagTmp = view.tag
            //Obtenemos la vistas expandibles de la cuenta seleccionada
            if viewTagTmp >= 1000 {
                //Tag del header expandible
                let tagExpand = viewTagTmp % 1000
                let tagViewTmpExpand = (viewTagTmp - tagExpand) / 1000
//                viewTagTmp = view.tag % 1000
                if tagViewTmpExpand == tagViewTmp && tagExpand > tagTmp {
                    let posx:CGFloat = view.frame.origin.x
                    let posMinY:CGFloat = view.frame.origin.y
                    let newHeight:CGFloat = heightView
                    var newPosY:CGFloat = 0.0
                    if expand {
                        newPosY = posMinY + newHeight
                    }else {
                        newPosY = posMinY - newHeight
                    }
                    
                    UIView.animateKeyframes(withDuration: 1.0, delay: 0.2, options: .calculationModeLinear, animations: {
                        let frame = CGRect(x: posx, y: newPosY, width: view.bounds.width, height: view.bounds.height)
                        view.frame = frame
                    }, completion: nil)
                }
            }
        }
        
    }
    
    
    
    
    /// Función que crear una alerta, con un texto predefinido
    /// - parameter titulo: Texto del título
    /// - Return: Void, Void
    func creaDialog(titulo : String?) -> (() -> ()) {
        return {
            let info = BottomInfoVC(titulo: titulo);
            
            self.popupRut = MTPopupController(rootViewController: info);
            self.popupRut?.hidesCloseButton = true;
            self.popupRut?.navigationBarHidden = true;
            self.popupRut?.style = .bottomSheet;
            let closeRutPopup = UITapGestureRecognizer(target: self, action: #selector(self.closeRutPopup));
            self.popupRut?.backgroundView?.addGestureRecognizer(closeRutPopup);
            self.popupRut?.present(in: self);
        };
    }
    
    /// Cerrar el popup informativo de RUT
    func closeRutPopup() {
        if let popup = popupRut {
            popup.dismiss();
        }
        
        popupRut = nil;
    }
}

//MARK: ViewExpandDelegate
extension CardsManagementViewController: ViewExpandDelegate {
    /// Detectar la acción para expandir u ocultar la vista con la información
    /// Parameter tagView: identificador de la vista (encabezado)
    /// Parameter expandView: Bandera para saber si se debe mostrar u ocultar la información de dicha cuenta
    /// Parameter indxService: index del tipo de servicio seleccionado
    func btnExpandAction(tagView: Int, expandView: Bool, indxService: Int, accountID: String) {
        print("PRESS THE EXPAND VIEW TAG \(tagView)")
        if expandView {
            self.createBodyExpandView(tagView: tagView + 1, expand: true, indxService: indxService, accountID: accountID)
        }else {
            self.createBodyExpandView(tagView: tagView + 1, expand: false, indxService: indxService, accountID: accountID)
        }
        
    }
}

//MARK: HeaderCardViewDelegate
extension CardsManagementViewController: HeaderCardViewDelegate {
    /// Detectar la acción del botón y mostrar un *Web View*
    /// Parameter webId: url del sitio a mostrar
    func btnRedAction(webId: String) {
        if false == SessionSingleton.sharedInstance.isNetworkConnected() {
            NotificationCenter.default.post(name: Observers.ObserverList.ShowOfflineMessage.name, object: nil);
            return;
        }
        
        let webView = GenericWebViewVC()
        webView.serviceSelected = webId
        self.so_containerViewController?.topViewController = UINavigationController(rootViewController: webView)
    }
    /// Para mostrar el nombre a cada opción del menu superior
    internal func createPlanCardStructure() {
        let total = SessionSingleton.sharedInstance.getPlanCards()?.count ?? 0
        if total != 0 {
            return;
        }
        
        var copia = Array<[PlanCard]>(repeating: [PlanCard](), count: allTabsArray.count);
//        var resumen = [PlanCard]();
        guard let currentAccountData = SessionSingleton.sharedInstance.getFullAccountData() else {
            return;
        }
        
        for item in currentAccountData {
            if TypeLineOfBussines.Prepago.rawValue == item.account?.lineOfBusiness {
                continue;
            }
            
            var nombreTab = getTitleHeaderViewExpand(serviceType: item.detailServices?.associatedService?.first?.serviceType ?? "");
            
            if item.isTodoClaro() {
                if let last = allTabsArray.last {
                    nombreTab = last
                }
            }
            
            if "" == nombreTab {
                continue
            }
            
            guard let pos = allTabsArray.index(of: nombreTab) else  {
                continue;
            }
            guard let myPlanList = item.detail?.accountDetails?.plan else {
                continue;
            }
            for myPlan in myPlanList {
                var current = copia[pos];
                let pc = PlanCard();
                pc.accountDetail = item.detail?.accountDetails;
                pc.lineOfBusiness = item.account?.lineOfBusiness;
                pc.accountId = item.account?.accountId;
                pc.plan = myPlan;
                pc.tabName = nombreTab
                
                
                current.append(pc);
//                resumen.append(pc);
                copia[pos] = current
            }
        }
        
//        copia.insert(resumen, at: 0);
        
        self.tmpPlanCardData = [[PlanCard]]();
        for item in copia {
            if (item.count < 1) {
                continue
            } else {
                tmpPlanCardData?.append(item)
            }
        }
        
        SessionSingleton.sharedInstance.setPlanCards(planCards: tmpPlanCardData);
    }
    /// Para mostrar la sección de *Boletas*
    /// Parameter indexCard: identificador de la Card seleccionada
    /// Parameter typeCard: identificar el tipo de Card seleccionada (Movil, TV)
    internal func btnShowBoleta(indexCard: Int, typeCard: TypeCardView) {
        print("MOSTRAR DETALLE DE BOLETAS")
        
        let tabNames = SessionSingleton.sharedInstance.getCurrentTab();
        
        var ic = indexCard;
        
        if ic > accountArray.count {
            ic = accountArray.count;
        }
        
        let current = self.accountArray[ic - 1];
        let planCard = PlanCard();
        planCard.retrieveBillDetailsResponse = current.detailServices?.detailPlan?.first?.retrieveBillDetailsResponse;
        planCard.plan = current.detail?.accountDetails?.plan?.first;
        planCard.tabName = tabNames;
        planCard.lineOfBusiness = current.account?.lineOfBusiness;
        planCard.accountId = current.account?.accountId;
        planCard.serviceId = current.detailServices?.associatedService?.first?.serviceID;
        planCard.serviceType = current.detailServices?.associatedService?.first?.serviceType;
        planCard.featureUsage = current.detailServices?.detailPlan?.first?.retrieveConsumptionDetailInformation?.serviceUsage?.first?.serviceFeatureUsage?.first?.featureUsage;
        planCard.accountDetail = current.detail?.accountDetails;
        planCard.serviceFeatureUsage = current.detailServices?.detailPlan?.first?.retrieveConsumptionDetailInformation?.serviceUsage?.first?.serviceFeatureUsage?.first;
        
        let vc = MenuTickets()
        /*vc.accountsDetail = current.detail?.accountDetails;
        vc.billDetails = current.detailServices?.detailPlan?.first?.retrieveBillDetailsResponse
        vc.accountId = current.account!.accountId!;
        vc.lineBusiness = current.account!.lineOfBusiness!;*/

        var tmpTabs = [TabInformation]();
        if let tmp = SessionSingleton.sharedInstance.getPlanCards() {
            for i in tmp {
                for j in i {
                    guard let t = tabItemArray?.first(where: { $0.nombre?.uppercased() == j.tabName?.uppercased()}) else {
                        continue;
                    }

                    if (!tmpTabs.contains(where: {$0.nombre?.uppercased() == t.nombre?.uppercased()})) {
                        tmpTabs.append(t);
                    }
                }
            }
        }

//        tmpTabs.insert(self.tabItemArray!.first(where: {$0.nombre!.uppercased() == TypeCardView.Resumen.rawValue.uppercased() })!,
//                       at: 0)

        tmpTabs.sort(by: {$0.posicion < $1.posicion});

        var selectedIndex = 0
        for i in 0..<tmpTabs.count {
            let item = tmpTabs[i];
            if item.nombre?.uppercased() == tabNames.uppercased(){
                selectedIndex = i
            }
        }
        
        //vc.tableTypeDatasource = tmpTabs;
        if let tmp = SessionSingleton.sharedInstance.getPlanCards() {
            vc.planCards = tmp
        }
        //vc.selectedPlanIndex = selectedIndex
        //vc.typeSelect = self.tabItemArray![selectedIndex]
        self.navigationController?.pushViewController(vc, animated: true)
        //        self.so_containerViewController?.topViewController = UINavigationController(rootViewController: vc);
    }
}

extension Array {
    /// Función encargada de ordenar un arreglo de ServiceAccount por el tipo de servicio
    func sortServiceAccount() -> [ServiceAccount] {
        var sorted = [ServiceAccount]()
        var movil  = [ServiceAccount]()
        var fija  = [ServiceAccount]()
        var tv     = [ServiceAccount]()
        var internet = [ServiceAccount]()
        var todoClaro = [ServiceAccount]()
        for service in self as! [ServiceAccount] {
            //let serviceType = service.getIndexForAssociatedService()
            if service.isTodoClaro() {
                todoClaro.append(service)
            } else {
                if let sType = service.detailServices?.associatedService?.first?.serviceType {
                    switch sType {
                    case "1":
                        movil.append(service)
                        break
                    case "3":
                        fija.append(service)
                        break
                    case "5":
                        internet.append(service)
                        break
                    case "4":
                        tv.append(service)
                        break
                    default:
                        break
                    }
                }
            }
        }
        sorted.append(contentsOf: movil)
        sorted.append(contentsOf: fija)
        sorted.append(contentsOf: internet)
        sorted.append(contentsOf: tv)
        sorted.append(contentsOf: todoClaro)
        return sorted
    }
}

extension CardsManagementViewController {
    /// Función encargada de setear el CGRect a la variable rect
    func setScroll(rect : CGRect) {
        self.rect = rect
    }
    /// Función encargada de realizar scroll a un elemento específico
    func scrollTo() {
        if let _ = self.rect {
            
            let y = self.rect!.origin.y > self.scrollview.contentOffset.y ? self.rect!.origin.y : self.scrollview.contentOffset.y - self.rect!.origin.y
            let originRect = CGRect(x: self.scrollview.frame.origin.x, y: y, width: rect!.width, height: rect!.height)
            self.scrollview.scrollRectToVisible(originRect, animated: true)
            print("Scroll TO: \(y) - Scrollview frame: \(self.scrollview.frame)")
            self.rect = nil
        }
    }
}
/// Extensión sin uso
extension CardsManagementViewController: CALayerDelegate {
    /// Sin usopu
    override func viewLayoutMarginsDidChange() {
        print("PUES QUIEN SABE QUE PASA")
    }
    /// Sin uso
    func layoutSublayers(of layer: CALayer) {
        print("PUES QUIEN SABE QUE PASA CON LAYER")
    }
}

//MARK: ViewBodyExpandDelegate
extension CardsManagementViewController: ViewBodyExpandDelegate {
    func showAlertSheet(typeServices: String) {
        print("MOSTRAR ALERT")
        var textToShow = "Marco Regulatorio"
        if let tooltips = self.conf?.translations?.data?.tooltips {
            for text in tooltips {
                if text.typeServices == typeServices {
                    textToShow = text.text ?? ""
                }
            }
        }
        
        let info = BottomInfoVC(titulo: textToShow, onlyText: true);
        
        self.popupRut = MTPopupController(rootViewController: info);
        self.popupRut?.hidesCloseButton = true;
        self.popupRut?.navigationBarHidden = true;
        self.popupRut?.style = .bottomSheet;
        let closeRutPopup = UITapGestureRecognizer(target: self, action: #selector(self.closeRutPopup));
        self.popupRut?.backgroundView?.addGestureRecognizer(closeRutPopup);
        self.popupRut?.present(in: self);
//        let actionSheet = UIActionSheet(title: "Takes the appearance of the bottom bar if specified; otherwise, same as UIActionSheetStyleDefault.", delegate: self as? UIActionSheetDelegate, cancelButtonTitle: "Cancel", destructiveButtonTitle: "Destroy", otherButtonTitles: "OK")
//        actionSheet.actionSheetStyle = .default
//        actionSheet.show(in: self.view)
    }
}

