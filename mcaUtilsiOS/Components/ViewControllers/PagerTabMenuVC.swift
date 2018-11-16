//
//  PagerTabMenu.swift
//  MiClaro
//
//  Created by Mauricio Javier Perez Flores on 7/28/17.
//  Copyright © 2017 am. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import FontAwesome_swift;

/// Esta clase es un contedor de viewcontrollers que es utilizado por la pantalla principal y asi mostrar cada tab de acuerdo con la lectura realizada en los servicios web
class PagerTabMenuVC: ButtonBarPagerTabStripViewController {

    var tabDataSource : [ServiceAccount]?

    private var currentSession : RetrieveProfileInformationResult?
    private var config : GeneralConfig?
    var associatedAccountList: [AssociatedAccountList]!
    var accountDetailList: [AccountDetail]!
    private var tabsVC = [GenericHomeVC]()
    private var lineOfBusinessArray = [String]()
    private var isDuplicated = false
    private var emptyView = GenericHomeVC(itemInfo: "");
    private var resume = GenericHomeVC(itemInfo: "Resumen");
    private var mobile = GenericHomeVC(itemInfo: "Móvil");
    private var internet = GenericHomeVC(itemInfo: "Internet");
    private var telefono = GenericHomeVC(itemInfo: "Teléfono");
    private var television = GenericHomeVC(itemInfo: "Televisión");
    private var todoClaro = GenericHomeVC(itemInfo: "Todo Claro");
    private var suscripcion = GenericHomeVC(itemInfo: "Suscripciones");

    private var frameTabBar = CGRect()
    
    override func viewDidLoad() {
        settings.style.buttonBarItemBackgroundColor = institutionalColors.claroSelectionGrayColor;
        settings.style.buttonBarItemTitleColor = institutionalColors.claroLightGrayColor;
        settings.style.selectedBarHeight = 2;
        settings.style.buttonBarItemsShouldFillAvailableWidth = true;
        settings.style.buttonBarLeftContentInset = 10;
        settings.style.buttonBarRightContentInset = 10;
        settings.style.buttonBarItemLeftRightMargin = 20;
        settings.style.buttonBarBackgroundColor = institutionalColors.claroSelectionGrayColor;
        settings.style.buttonBarItemFont = UIFont(name: RobotoFontName.RobotoRegular.rawValue, size: 16.0)!;
        super.viewDidLoad()

        self.view.isUserInteractionEnabled = false;
        self.delegate = self;
        self.navigationController?.navigationBar.isTranslucent = false
        buttonBarView.layer.shadowRadius = 5.5
        buttonBarView.layer.shadowColor = institutionalColors.claroTextColor.cgColor
        buttonBarView.layer.shadowOffset = CGSize(width: 0, height: 1.5)
        buttonBarView.layer.shadowOpacity = 0.5
        buttonBarView.layer.masksToBounds = false
        buttonBarView.selectedBar.backgroundColor = institutionalColors.claroRedColor
        buttonBarView.moveTo(index: 0, animated: true, swipeDirection: .none, pagerScroll: .yes)

        pagerBehaviour = .progressive(skipIntermediateViewControllers: false, elasticIndicatorLimit: false);
        changeCurrentIndexProgressive = { (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            oldCell?.label.textColor = institutionalColors.claroLightGrayColor;
            oldCell?.label.text = oldCell?.label.text?.uppercased()
            newCell?.label.textColor = institutionalColors.claroTextColor;
            newCell?.label.text = newCell?.label.text?.uppercased()
        }

        currentSession = SessionSingleton.sharedInstance.getCurrentSession();
        config = SessionSingleton.sharedInstance.getGeneralConfig();

        //Obtenemos las cuentas desde cache
        self.tabDataSource = SessionSingleton.sharedInstance.getFullAccountData()
        
        initWith(navigationType: .serviceAccount)
        if (nil != SessionSingleton.sharedInstance.getCurrentSession()) {
            frameTabBar = self.addFakeTabBar(selectedIndex: "", lockIndex: -1)
        }
    }

    deinit {
    }

    /// Este método permite conocer a que nuevo tab se está cambiando la vista actual
    override func updateIndicator(for ptsvc: PagerTabStripViewController, fromIndex: Int, toIndex: Int, withProgressPercentage progressPercentage: CGFloat, indexWasChanged: Bool) {
        super.updateIndicator(for: ptsvc, fromIndex: fromIndex, toIndex: toIndex, withProgressPercentage: progressPercentage, indexWasChanged: indexWasChanged)
        if 1.0 == progressPercentage && toIndex > -1 && toIndex < self.viewControllers.count {
            let vistaActual = self.viewControllers[toIndex] as! GenericHomeVC
            let nombre = vistaActual.itemInfo.title.uppercased()

            switch nombre {
            case TypeCardView.Internet.rawValue.uppercased():
                SessionSingleton.sharedInstance.setCurrentTab(tabName: TypeCardView.Internet.rawValue);
                break;
            case TypeCardView.Móvil.rawValue.uppercased():
                SessionSingleton.sharedInstance.setCurrentTab(tabName: TypeCardView.Móvil.rawValue);
                break;
            case TypeCardView.Resumen.rawValue.uppercased():
                SessionSingleton.sharedInstance.setCurrentTab(tabName: TypeCardView.Resumen.rawValue);
                AnalyticsInteractionSingleton.sharedInstance.ADBTrackView(viewName: "Mis servicios|Resumen", detenido: false)
                break;
            case TypeCardView.Televisión.rawValue.uppercased():
                SessionSingleton.sharedInstance.setCurrentTab(tabName: TypeCardView.Televisión.rawValue);
                break;
            case TypeCardView.TodoClaro.rawValue.uppercased():
                SessionSingleton.sharedInstance.setCurrentTab(tabName: TypeCardView.TodoClaro.rawValue);
                break;
            case TypeCardView.Suscripción.rawValue.uppercased():
                SessionSingleton.sharedInstance.setCurrentTab(tabName: TypeCardView.Suscripción.rawValue)
                break
            default:
                print("Tab desconocido");
                break;
            }

            print("Cambiando al tab \(SessionSingleton.sharedInstance.getCurrentTab())")
        }
    }
    

    /// Este método se desencadena cuando hacemos back desde boletas, para elegir el tab que estaba seleccionado de acuerdo con el valor del selector de boletas.
    func shouldMoveTo (_ notification: Notification) {
        if let tabName = notification.userInfo?["TabName"] as? String, let accountId = notification.userInfo?["AccountId"] as? String {
            print(accountId)
            SessionSingleton.sharedInstance.setCurrentTab(tabName: tabName)
            let _viewController = moveToTab()
            _viewController?.scrollTo(accountId: accountId, tabName : tabName)
        }
    }
    
    func showTabPage(_ notification: Notification) {
        var _viewController : GenericHomeVC? = nil
        let serviceName = notification.userInfo?["serviceName"] as? String
        if let typeAccount = notification.userInfo?["TypeAccount"] as? TypeAccountService {
            switch typeAccount {
            case .Resumen:
                _viewController = resume
                break
            case .MovilPospago, .MovilPrepago:
                _viewController = mobile
                _viewController?.phoneUserMovil = serviceName ?? ""
                break
            case .Television:
                _viewController = television
                break
            case .TodoClaro:
                _viewController = todoClaro
                break
            case .Internet:
                _viewController = internet
                break
            case .LineaFija:
                _viewController = telefono
                break
            case .Suscripcion:
                _viewController = suscripcion
                break
            default:
                break
            }
        }
        
        if let _ = _viewController {
            moveTo(viewController: _viewController!, animated: false);
        }
    }

    /// Esta función determina que viewcontroller corresponde de acuerdo al nombre del tab
    func moveToTab() -> GenericHomeVC? {
        var _viewController : GenericHomeVC? = nil
        let currentTab = SessionSingleton.sharedInstance.getCurrentTab().uppercased();
        switch currentTab {
        case TypeCardView.Internet.rawValue.uppercased():
            _viewController = internet
            break;
        case TypeCardView.Móvil.rawValue.uppercased():
            _viewController = mobile
            break;
        case TypeCardView.Resumen.rawValue.uppercased():
            _viewController = resume
            break;
        case TypeCardView.Televisión.rawValue.uppercased():
            _viewController = television
            break;
        case "Todo Claro".uppercased():
            _viewController = todoClaro
            break;
        case TypeCardView.Suscripción.rawValue.uppercased():
            _viewController = suscripcion
            break;
        default:
            SessionSingleton.sharedInstance.setCurrentTab(tabName: TypeCardView.Resumen.rawValue)
            _viewController = resume
            break;
        }
        if let _ = _viewController {
            moveTo(viewController: _viewController!, animated: false);
        }
        return _viewController
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: Notification.Name("detailInformation"), object: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)

        NotificationCenter.default.post(name: Notification.Name("refreshTipoPago"), object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(showTabPage/*shouldMoveTo*/), name: Notification.Name("detailInformation"), object: nil)

        DispatchQueue.main.async {
            let _ = self.moveToTab();
        }
    }

    /// Esta funcion crea los viewcontrollers correspondientes a la vista actual
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        return generateTabsWithNewLineOfBusiness()
    }

    /// Obtiene el titulo del tab, de acuerdo con el valor de ServiceType
    func getTitleHeaderViewExpand(serviceType: String) -> String {
        var title: String = ""
        switch serviceType {
        case "1":
            title = "Movil"
            break
        case "3":
            title = "Teléfono"
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

    /// Esta función toma el modelo de datos AssociatedService y determina los datos de cada tab para ser desplegado por el view controller correspondiente
    func getAccounts(myServices: [AssociatedService], myAccount: ServiceAccount) -> [GenericHomeVC] {
        var myViews = [GenericHomeVC]()
        
        for item in myServices {
            guard let myServiceType = item.serviceType else {
                continue;
            }
            switch myServiceType {
            case "1"://telefono movil
                mobile.accountData = myAccount
                mobile.accountArray = self.tabDataSource!
                mobile.tabName = allTabsArray[1]
                mobile.itemInfo.title = mobile.tabName!;
                if false == myViews.contains(mobile) {
                    myViews.append(mobile)
                }
                break;
            case "3"://Telefono fijo
                telefono.accountData = myAccount
                telefono.tabName = allTabsArray[3]
                telefono.accountArray = self.tabDataSource!
                telefono.itemInfo.title = telefono.tabName!;
                if false == myViews.contains(telefono) {
                    myViews.append(telefono)
                }
                break;
            case "4"://Television
                television.accountData = myAccount
                television.accountArray = self.tabDataSource!
                television.tabName = allTabsArray[4]
                television.itemInfo.title = television.tabName!;
                if false == myViews.contains(television) {
                    myViews.append(television)
                }
                break;
            case "5"://Internet
                internet.accountData = myAccount
                internet.tabName = allTabsArray[2]
                internet.itemInfo.title = internet.tabName!;
                internet.accountArray = self.tabDataSource!
                if false == myViews.contains(internet) {
                    myViews.append(internet)
                }
                break;
            case "6"://Suscripciones
                suscripcion.accountData = myAccount
                suscripcion.tabName = allTabsArray[6]
                suscripcion.itemInfo.title = suscripcion.tabName!;
                suscripcion.accountArray = self.tabDataSource!
                if false == myViews.contains(suscripcion) {
                    myViews.append(suscripcion)
                }
                break;
            default:
                break;
            }
        }
        return myViews
    }// MARK: Tab Items Functions
    
    func getTodoClaroElementsWith(source: [ServiceAccount]) -> [ServiceAccount]{
        return source.filter { $0.isTodoClaro()  }
    }

    /// Determina que elementos son TodoClaro
    func getSourceElementsByTodoClaroElements(source: [ServiceAccount], elements : [ServiceAccount]) -> [ServiceAccount] {
        var sourceElements = source
        if elements.count > 0 {
            for element in elements {
                if let index = sourceElements.index(of: element) {
                    sourceElements.remove(at: index)
                }
            }
            return sourceElements
        }
        return source
    }

    /// Obtiene todos las las cuentas que sean LOB == { 1, 2, 3}
    func getResumeElementsWith(source: [ServiceAccount]) -> [ServiceAccount] {
        return source.filter { $0.account?.lineOfBusiness == "1" || $0.account?.lineOfBusiness == "2" || $0.account?.lineOfBusiness == "3" }
    }
    
    func getViewsBy(servicesAccount : [ServiceAccount], tabsArray : [String]) -> [GenericHomeVC]? {
        if servicesAccount.count > 0 {
            var resultViews = [GenericHomeVC]()
            for account in servicesAccount {
                if let associatedServices = account.detailServices?.associatedService {
                    for associatedService in associatedServices {
                        if let sType = associatedService.serviceType {
                            if let view = getViewBy(serviceType: sType, account: account, tabsArray : tabsArray) {
                                if false == resultViews.contains(view) {
                                    resultViews.append(view)
                                }
                            }
                        }
                    }
                }
            }
            return resultViews
        }
        return nil
    }
    
    func getTodoClaroViewBy(elements : [ServiceAccount], tabsArray : [String]) -> [GenericHomeVC]? {
        if elements.count > 0 {
            var resultViews = [GenericHomeVC]()
            for account in elements {
                todoClaro.accountData = account
                todoClaro.accountArray = self.tabDataSource!;
                todoClaro.tabName = tabsArray[5]
                todoClaro.itemInfo.title = todoClaro.tabName!;
                resultViews.append(todoClaro)
            }
            return resultViews
        }
        return nil
    }
    
    func getViewBy(serviceType : String, account: ServiceAccount, tabsArray : [String]) -> GenericHomeVC?{
        switch serviceType {
        case "1"://telefono movil
            mobile.accountData = account
            mobile.accountArray = self.tabDataSource!
            mobile.tabName = tabsArray[1]
            mobile.itemInfo.title = mobile.tabName!;
            return mobile
        case "3"://Telefono fijo
            telefono.accountData = account
            telefono.tabName = tabsArray[3]
            telefono.accountArray  = self.tabDataSource!
            telefono.itemInfo.title = telefono.tabName!;
            return telefono
        case "4"://Television
            television.accountData = account
            television.tabName = tabsArray[4]
            television.accountArray  = self.tabDataSource!
            television.itemInfo.title = television.tabName!;
            return television
        case "5"://Internet
            internet.accountData = account
            internet.tabName = tabsArray[2]
            internet.accountArray  = self.tabDataSource!
            internet.itemInfo.title = internet.tabName!;
            return internet
        case "6"://Suscripciones
            suscripcion.accountData = account
            suscripcion.tabName = tabsArray[6]
            suscripcion.accountArray  = self.tabDataSource!
            suscripcion.itemInfo.title = suscripcion.tabName!;
            return suscripcion
        default:
            break;
        }
        return nil
    }
    
    func getResumeViewsBy(elements : [ServiceAccount], tabsArray : [String]) -> [GenericHomeVC]? {
        if elements.count > 0 {
            var resultViews = [GenericHomeVC]()
            for account in elements {
                resume.accountData = account
                resume.accountArray = self.tabDataSource!
                resume.tabName = tabsArray[0];
                if false == resultViews.contains(resume) {
                    resultViews.append(resume)
                }
            }
            return resultViews
        }
        return nil
    }
    
    func getSuscripcionViewsBy(elements : [ServiceAccount], tabsArray : [String]) -> [GenericHomeVC]? {
        if elements.count > 0 {
            var resultViews = [GenericHomeVC]()
            for account in elements {
                suscripcion.accountData = account
                suscripcion.accountArray = self.tabDataSource!
                suscripcion.tabName = tabsArray[6];
                if false == resultViews.contains(suscripcion) {
                    resultViews.append(suscripcion)
                }
            }
            return resultViews
        }
        return nil
    }
    
    func generateTabsWithNewLineOfBusiness() -> [UIViewController] {
        var myViews = [GenericHomeVC]();
        guard let source = self.tabDataSource else {
            return [resume];
        }
        
        if nil == SessionSingleton.sharedInstance.getFullAccountData() {
            SessionSingleton.sharedInstance.setFullAccountData(account: self.tabDataSource)
        }
        
        let todoClaroElements = getTodoClaroElementsWith(source: source)
        let sourceElements = getSourceElementsByTodoClaroElements(source: source, elements: todoClaroElements)
        let resumeElements = getResumeElementsWith(source:  source)
        
        if let resumeViews = getResumeViewsBy(elements : resumeElements, tabsArray: allTabsArray) {
            myViews.append(contentsOf: resumeViews)
        }
        
        if let views = getViewsBy(servicesAccount: sourceElements, tabsArray: allTabsArray) {
            myViews.append(contentsOf: views)
        }
        if let tcView = getTodoClaroViewBy(elements : todoClaroElements, tabsArray: allTabsArray) {
            myViews.append(contentsOf: tcView)
        }
        
        let accountSubServices = AccountManagement(arrayServices: self.tabDataSource ?? [ServiceAccount]())
        accountSubServices.filterMovilAccount()
        
        let movilServices = accountSubServices.getMovilData()
        //Si el RUT no trae planes moviles no se muestra el tabBar de suscripciones
        if  movilServices.count != 0{
            if let suscripcionViews = getSuscripcionViewsBy(elements : resumeElements, tabsArray: allTabsArray) {
                myViews.append(contentsOf: suscripcionViews)
            }
        }
        
        myViews = myViews.sorted(by: { (item0, item1) in
            guard let name1 = item0.tabName else {
                return false;
            }
            
            guard let name2 = item1.tabName else {
                return false
            }
            
            guard let p0 = allTabsArray.index(of: name1) else {
                return false;
            }
            guard let p1 = allTabsArray.index(of: name2) else {
                return false;
            }
            let valor : Bool = p0 < p1;
            return valor
        });
        
        for item in myViews {
            item.tabItemArray = myViews.map({
                var tipo = TypeCardView.Resumen;
                let titulo = $0.itemInfo.title;
                switch titulo {
                case allTabsArray[0]:
                    tipo = TypeCardView.Resumen;
                    break;
                case allTabsArray[1]:
                    tipo = TypeCardView.Móvil;
                    break;
                case allTabsArray[2]:
                    tipo = TypeCardView.Internet;
                    break;
                case allTabsArray[3]:
                    tipo = TypeCardView.Teléfono;
                    break;
                case allTabsArray[4]:
                    tipo = TypeCardView.Televisión;
                    break;
                case allTabsArray[5]:
                    tipo = TypeCardView.TodoClaro;
                    break;
                case allTabsArray[6]:
                    tipo = TypeCardView.Suscripción
                    break
                default:
                    tipo = TypeCardView.Resumen;
                    break;
                }
                let obj = TabInformation(nombre: titulo, identificador: tipo);
                return obj
            });
        }
        return myViews;
    }
        
}
public enum ServiceType : Int {
    case Resumen
    case Movil = 1
    case Otros = 2
    case Telefono = 3
    case TV = 4
    case Internet = 5
    case TodoClaro
}

public class TabInformation {
    var nombre : String?
    var identificador : TypeCardView?
    var posicion : Int;

    init(nombre : String, identificador : TypeCardView) {
        self.nombre = nombre.uppercased();
        self.identificador = identificador;

        switch identificador {
        case TypeCardView.Resumen, .None:
            posicion = 0;
        case TypeCardView.Móvil:
            posicion = 1;
        case TypeCardView.Internet:
            posicion = 2;
        case TypeCardView.Teléfono:
            posicion = 3;
        case TypeCardView.Televisión:
            posicion = 4;
        case TypeCardView.TodoClaro:
            posicion = 5;
        case TypeCardView.Suscripción:
            posicion = 6
        /*default:
            break*/
        }
    }
}
