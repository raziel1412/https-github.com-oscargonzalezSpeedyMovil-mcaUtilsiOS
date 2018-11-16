//
//  CardsSummaryManagement.swift
//  MiClaro
//
//  Created by Jonathan Abimael Cruz Orozco on 09/07/18.
//  Copyright © 2018 am. All rights reserved.
//

import UIKit

class CardsSummaryManagement: UIViewController {

    /*********************** Constantes ***********************/
    let constantTopHeightTabBar: CGFloat = 100.0
    let constantBottomHeightTabBar: CGFloat = 100.0
    /*********************** Constantes ***********************/
    
    /*********************** Variables ***********************/
    var arraySummary: [CardsSummaryModel] = []
    var _tab : [String : Any] = [String : Any]()
    private var pullToRefresh: UIRefreshControl!
    /*********************** Variables ***********************/
    
    /*********************** Componentes de la interfaz ***********************/
    private var scrollContent: UIScrollView!
    private var viewHeader: CardHeaderSummaryView!
    private var viewContentSummary: cardContentSummaryDetailView!
    /*********************** Componentes de la interfaz ***********************/
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.createInterface()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        print("SE SALIO DE LA VISTA DE CARDS RESUMEN")
        for viewTmp in self.view.subviews {
            viewTmp.removeFromSuperview()
        }
    }
    
    init(frame: CGRect, summary: [CardsSummaryModel]) {
        super.init(nibName: nil, bundle: nil)
        self.view.frame = frame
        self.arraySummary = summary
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //Obtener la altura del view contenedor de la información de resumen
    private func getHeightContentSummaryView() -> CGFloat {
        var heightView: CGFloat = constantTopHeightTabBar// + constantBottomHeightTabBar
        for _ in 0..<self.arraySummary.count {
            heightView += 130.0
        }
        
        return heightView
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
        
        let frameHeader = CGRect(x: 0, y: 10, width: self.view.bounds.width, height: 190)
        self.viewHeader = CardHeaderSummaryView(frame: frameHeader)
        self.scrollContent.addSubview(self.viewHeader)
        
        let frameViewContentSummary = CGRect(x: 0, y: self.viewHeader.frame.maxY, width: self.view.bounds.width, height: self.getHeightContentSummaryView())
        self.viewContentSummary = cardContentSummaryDetailView(frame: frameViewContentSummary)
        self.scrollContent.addSubview(self.viewContentSummary)
        self.viewContentSummary.delegate = self
        self.viewContentSummary.setSummaryData(arraySummary: self.arraySummary)
//        self.viewContentSummary.viewBorder.addBottomGrecas()
        
        self.updateHeightScroll()
    }
    
    /// Actualizar la altura del scroll
    private func updateHeightScroll() {
        let heightView = self.view.frame.height
        let posYcontentSummary = self.viewContentSummary.frame.minY
        let heightContentSummary = self.viewContentSummary.getHeightView()
        let heightTmpScroll = posYcontentSummary + heightContentSummary
        
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
            print("REFRESH SERVICES CARDS RESUMEN")
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
}

//MARK:
extension CardsSummaryManagement: CardContentSummaryDelegate {
    func payBoleta() {
        let webView = GenericWebViewVC()
        webView.serviceSelected = "billingPayment"
        self.so_containerViewController?.topViewController = UINavigationController(rootViewController: webView)
    }
    
    func showDetailAccount(typeAccount: TypeAccountService, serviceName: String) {
        self._tab = ["TypeAccount": typeAccount, "serviceName":serviceName]
        NotificationCenter.default.post(name: Notification.Name("detailInformation"), object: nil, userInfo:  self._tab)
        
        switch typeAccount {
        case .Resumen:
             AnalyticsInteractionSingleton.sharedInstance.ADBTrackCustomLink(viewName: "Mis servicios|Resumen:Pagar boletae")
            break
        case .MovilPospago, .MovilPrepago:
             AnalyticsInteractionSingleton.sharedInstance.ADBTrackCustomLink(viewName: "Mis servicios|Resumen:Movil:Ver detalle")
            break
        case .Television:
             AnalyticsInteractionSingleton.sharedInstance.ADBTrackCustomLink(viewName: "Mis servicios|Resumen:Television:Ver detalle")
            break
        case .TodoClaro:
            AnalyticsInteractionSingleton.sharedInstance.ADBTrackCustomLink(viewName: "Mis servicios|Resumen:TodoClaro:Ver detalle")
            break
        case .Internet:
             AnalyticsInteractionSingleton.sharedInstance.ADBTrackCustomLink(viewName: "Mis servicios|Resumen:Internet:Ver detalle")
            break
        default:
            break
        }
    }
}
