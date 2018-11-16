//
//  CardSuscriptionManagement.swift
//  MiClaro
//
//  Created by Jonathan Abimael Cruz Orozco on 13/09/18.
//  Copyright © 2018 am. All rights reserved.
//

import UIKit

class CardSuscriptionManagement: UIViewController {
    
    /*********************** Variables ***********************/
    var accountArray: [ServiceAccount] = [ServiceAccount]()
    var arraySubscriptions : [CardSuscriptionModel] = []
    var arrayHistorySubscriptions : [CardSuscriptionModel] = []
    
    var arrayMovilData: [CardsMovilModel] = [CardsMovilModel]()
    var indexAccountSelected: Int = 0
    var indexSubscripSelected: Int = 0
    var selectedSuscripData: [CardSuscriptionModel] = []
    var areInBlacklist: Bool = false
    var historySelecte: Bool = false
    
    private var subsAccounts : RetrieveSMSPremiumSubscriptionsResponse = RetrieveSMSPremiumSubscriptionsResponse()
    private var subsHistorycAccounts : RetrieveSMSPremiumHistoryResponse = RetrieveSMSPremiumHistoryResponse()

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
    private var viewHeaderPlan: CardHeaderServiceView!
    private var btnSuscription: UIButton!
    private var viewSelectSuscription: SelectOptionSuscription!
    private var contentViewDetailSuscription: ContentDetailSuscription!
    /*********************** Componentes de la interfaz ***********************/
    
    /*********************** Textos de la interfaz ***********************/
    private var textNumberLine: String = ""
    private var textLineResume: String = ""
    var textMobile: String = ""
    /*********************** Textos de la interfaz ***********************/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.red
        
        if let data = SessionSingleton.sharedInstance.getFullAccountData() {
            self.accountArray = data
        }
        self.createInterface()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func viewWillAppear(_ animated: Bool) {
    }
    
    init(frame: CGRect, phonePreselect: String = "") {
        super.init(nibName: nil, bundle: nil)
        self.view.frame = frame
        self.setPreSelectPhone(phone: phonePreselect)
        
        //      DispatchQueue.main.async(execute: {
        self.getLineSubscriptions()
        //      })
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
    
    private func setTextSelector(){
        let accountSubServices = AccountManagement(arrayServices: self.accountArray)
        accountSubServices.filterMovilAccount()
        
        let movilServices = accountSubServices.getMovilData()
        self.arrayMovilData = movilServices
        
        if self.arrayMovilData.count > 0 {
            let movilData = self.arrayMovilData[0]
            //Informacion del selector
            let serviceName = movilData.arrayServices.first?.nameService
            self.viewSelectService.setDataInformation(titleOption: self.textNumberLine, namePlanOption: serviceName!)
        }
    }
    
    func setPreSelectPhone(phone: String) {
        self.numberPhonePreSelect = phone
    }
    
    func getLineSubscriptions() {
        if self.arrayMovilData.count != 0{
            let account = self.arrayMovilData[self.indexAccountSelected]
            let service = account.arrayServices.first
            
            self.getSMSPremiumSubscriptions(accountId: account.accountID, lob: account.lob, serviceID: service?.nameService ?? "", completion: {
                
                self.filterSuscripciones()
                self.getLineHistorySubscriptions()
            })
        }
    }
    
    func getLineHistorySubscriptions() {
//        let account = self.arrayMovilData[self.indexAccountSelected]
//        let service = account.arrayServices.first
        
//        self.getHistorySubscriptions(accountId: account.accountID, lob: account.lob, serviceID: service?.nameService ?? "", completion: {
//
//            self.filterHistorycSuscripciones()
            self.updateDataServiceSelected()
            if self.selectedSuscripData.count != 0{
                self.chekStatusSuscription(completion: {
                    self.refreshBtnSuscriptionText()
                })
            }
//        })
    }
    
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
  
        let widthView = self.view.bounds.width
        
        /***********************Agregar el view selector de servicio**********************+*/
        let frameViewSelect = CGRect(x: 0, y: 10, width: widthView, height: 90)
        self.viewSelectService = CardSelectServiceView(frame: frameViewSelect)
        let lblTextSelector = textConfiguration?.translations?.data?.subscriptions?.subscriptionsPickLine ?? ""
        self.viewSelectService.setTextUI(txtLbl: lblTextSelector)
        self.viewSelectService.delegate = self
        self.setTextSelector()
        self.scrollContent.addSubview(self.viewSelectService)
        /***********************Agregar el view con el nombre del plan**********************/
        let frameHeaderService = CGRect(x: 0, y: self.viewSelectService.frame.maxY, width: widthView, height: 80)
        self.viewHeaderPlan = CardHeaderServiceView(frame: frameHeaderService)
        self.viewHeaderPlan.setTextSuscrip(typeCard: .Suscripción, title: "", descrip: "")
        self.scrollContent.addSubview(self.viewHeaderPlan)
        /***********************Agregar el boton de bloqueo de suscripciones**********************/
        self.createBtnSuscription(position: (0, self.viewHeaderPlan.frame.maxY))
        /***********************Agregar el view selector de suscripciones**********************+*/
        let frameViewSelectSuscrip = CGRect(x: 0, y: self.viewHeaderPlan.frame.maxY + self.btnSuscription.frame.height + 2, width: widthView, height: 90)
        self.viewSelectSuscription = SelectOptionSuscription(frame: frameViewSelectSuscrip)
        //                  self.viewSelectSuscription.setDataInformation(titleOption: textTitleSelector)
        self.updateSelectorSubscribTitle()
        self.viewSelectSuscription.delegate = self
        let sides = SideView(Left: true, Right: true, Top: true, Bottom: true)
        self.viewSelectSuscription.viewContent.addBorder(sides: sides, color: institutionalColors.claroBorderBalanceView, thickness: 1.5)
        /***********************Agregar el contenedor del detalle de suscripciones**********************+*/
        let frameContentDetailSus = CGRect(x: 0, y: self.viewSelectSuscription.frame.maxY, width: widthView, height: 800)
        self.contentViewDetailSuscription = ContentDetailSuscription(frame: frameContentDetailSus, arrayDataSuscription: self.selectedSuscripData, isHistorycTable: self.historySelecte)
        self.contentViewDetailSuscription.delegate = self
        
        self.btnSuscription.isHidden = true
        self.viewSelectSuscription.isHidden = true
        self.contentViewDetailSuscription.isHidden = true
        
        self.scrollContent.addSubview(self.viewSelectSuscription)
        self.scrollContent.addSubview(self.contentViewDetailSuscription)
        
    }
    
    /// Actualizar la informacion seleccionada
    func updateDataServiceSelected() {
        var titleSuscrip = ""
        var textDescrip = ""
        
        selectedSuscripData.removeAll()
    
        //Obtener la informacion de la cuenta seleccionada
        if self.arrayMovilData.count > 0 {
            let movilData = self.arrayMovilData[self.indexAccountSelected]
            //Informacion del selector
            let serviceName = movilData.arrayServices.first?.nameService
            self.viewSelectService.setDataInformation(titleOption: self.textNumberLine, namePlanOption: serviceName!)
            
            //Aqui se selecciona el data source para los datos de las suscripciones
            if historySelecte{
                if self.arrayHistorySubscriptions.count != 0 {
                     selectedSuscripData = self.arrayHistorySubscriptions
                }
            }else{
                if self.arraySubscriptions.count != 0 {
   
                        selectedSuscripData = self.arraySubscriptions
                        historySelecte = false
                        self.indexSubscripSelected = 0
                }
            }
            self.viewSelectSuscription.disableActionButtonArrow() // eliminar esta linea al volver a mostras el historico de suscripciones
//            if selectedSuscripData.count == 0 {
//                    selectedSuscripData = self.arrayHistorySubscriptions
//                    historySelecte = true
//                    self.indexSubscripSelected = 1
//            }
            if(selectedSuscripData.count == 0) {
                titleSuscrip = textConfiguration?.translations?.data?.subscriptions?.subscriptionsNoSusciptionsTitle ?? ""
                textDescrip = textConfiguration?.translations?.data?.subscriptions?.subscriptionsNotExist ?? ""
                
                self.btnSuscription.isHidden = true
                self.viewSelectSuscription.isHidden = true
                self.contentViewDetailSuscription.isHidden = true
            }
            else{
                titleSuscrip = textConfiguration?.translations?.data?.subscriptions?.subscriptionsTitle ?? ""
                textDescrip = textConfiguration?.translations?.data?.subscriptions?.subscriptionsSubtitle ?? ""
//                let textTitleSelector = textConfiguration?.translations?.data?.subscriptions?.subscriptionsOn ?? ""
                
                /***********************Update el selector de tipos suscripciones**********************+*/
                self.updateSelectorSubscribTitle()
                /***********************Pasar el dataSource de suscripciones**********************+*/
                self.contentViewDetailSuscription.setDataSuscriptions(suscription: self.selectedSuscripData, isHistorycTable: self.historySelecte)
                /***********************Ocultar la tabla de subscripciones**********************+*/
                self.btnSuscription.isHidden = false
                self.viewSelectSuscription.isHidden = false
                self.contentViewDetailSuscription.isHidden = false
                
                 self.updateHeightScroll()
            }
            //  AnalyticsInteractionSingleton.sharedInstance.ADBTrackViewServicios(viewName: "Mis servicios|Movil", type: "4", nombreServicio: "Movil", detalleServicio: planName!, fechaVencimiento: (detailBalance?.datePlanVigency)!, estatus: "", saldo: strSaldo)
        }
        self.viewHeaderPlan.setTextSuscrip(typeCard: .Suscripción, title: titleSuscrip, descrip: textDescrip)
        
        //Ajustar la altura del scroll
        self.updateHeightScroll()
    }
    
    private func createBtnSuscription(position: (CGFloat, CGFloat)) {
        let contenButton = UIView(frame: CGRect(x: position.0, y: position.1, width: self.view.bounds.width, height: CGFloat(50.0)))
        contenButton.backgroundColor = institutionalColors.claroWhiteColor
        let frameBtn = CGRect(x: 10, y: 2, width: contenButton.frame.width - 20, height: 40.0)
        self.btnSuscription = UIButton(frame: frameBtn)
        self.btnSuscription.titleLabel?.font =  UIFont(name: RobotoFontName.RobotoBold.rawValue, size: CGFloat(14))
        let sides = SideView(Left: true, Right: true, Top: true, Bottom: true)
        self.btnSuscription.addBorder(sides: sides, color: institutionalColors.claroRedColor, thickness: 1.5)
       
        self.refreshBtnSuscriptionText()
       
        self.btnSuscription.addTarget(self, action: #selector(btnSuscriptionAction), for: .touchUpInside)
        contenButton.addSubview(self.btnSuscription)
        self.scrollContent.addSubview(contenButton)
    }
    func refreshBtnSuscriptionText(){
        if areInBlacklist{
            let txtBntSuscription = self.textConfiguration?.translations?.data?.subscriptions?.subscriptionsUnblocked ?? ""
            let uperTxtBntSuscription = txtBntSuscription.uppercased()
            self.btnSuscription.setTitle(uperTxtBntSuscription, for: .normal)
            self.btnSuscription.setTitleColor(institutionalColors.claroWhiteColor, for: .normal)
            self.btnSuscription.backgroundColor = institutionalColors.claroRedColor
        }else{
            let txtBntSuscription = self.textConfiguration?.translations?.data?.subscriptions?.subscriptionsBlockMessaging ?? ""
            let uperTxtBntSuscription = txtBntSuscription.uppercased()
            self.btnSuscription.setTitle(uperTxtBntSuscription, for: .normal)
            self.btnSuscription.setTitleColor(institutionalColors.claroRedColor, for: .normal)
            self.btnSuscription.backgroundColor = institutionalColors.claroWhiteColor
        }
    }
    func btnSuscriptionAction() {
        
        if areInBlacklist == false { // Si no esta en la lista negra
            //Mostrar alerta de desactivar
            let info = AlertYesNo();
            info.title =  SessionSingleton.sharedInstance.getGeneralConfig()?.translations?.data?.subscriptions?.subscriptionsBlock ?? ""
            info.text = SessionSingleton.sharedInstance.getGeneralConfig()?.translations?.data?.subscriptions?.subscriptionsSureBlock ?? ""
            info.acceptTitle =  SessionSingleton.sharedInstance.getGeneralConfig()?.translations?.data?.generales?.confirmBtn ?? ""
            info.icon = .IconoAlertaBlock;
            info.acceptButtonColor = institutionalColors.claroRedColor
            info.onAcceptEvent = {
                self.blockSubscription()
            }
            info.cancelTitle =  SessionSingleton.sharedInstance.getGeneralConfig()?.translations?.data?.generales?.cancelBtn ?? ""
            info.onCancelEvent = {
                
            }
            NotificationCenter.default.post(name: Observers.ObserverList.YesNoAlert.name,
                                            object: info)
        }else{
            //mostrar alerta de activar
            let info = AlertYesNo();
            info.title =  SessionSingleton.sharedInstance.getGeneralConfig()?.translations?.data?.subscriptions?.subscriptionsUnlockTitle ?? ""
            info.text = SessionSingleton.sharedInstance.getGeneralConfig()?.translations?.data?.subscriptions?.subscriptionsUnlockDescription ?? ""
            info.acceptTitle =  SessionSingleton.sharedInstance.getGeneralConfig()?.translations?.data?.generales?.confirmBtn ?? ""
            info.acceptButtonColor = institutionalColors.claroRedColor
            info.icon = .IconoAlertaUnBlock
            info.onAcceptEvent = {
                self.unBlockSubscription()
            }
            info.cancelTitle =  SessionSingleton.sharedInstance.getGeneralConfig()?.translations?.data?.generales?.cancelBtn ?? ""
            info.onCancelEvent = {
                
            }
            NotificationCenter.default.post(name: Observers.ObserverList.YesNoAlert.name,
                                            object: info)
        }
       
    }
    
    func updateSelectorSubscribTitle() {
        let indexSubscripSelector = self.indexSubscripSelected
        switch indexSubscripSelector {
        case 0:
            let textTitleSelector = textConfiguration?.translations?.data?.subscriptions?.subscriptionsOn ?? ""
            self.viewSelectSuscription.setDataInformation(titleOption: textTitleSelector)
            break
        case 1:
            let textTitleSelector = textConfiguration?.translations?.data?.subscriptions?.subscriptionsHistory ?? ""
            self.viewSelectSuscription.setDataInformation(titleOption: textTitleSelector)
            break
        default:
            let textTitleSelector = textConfiguration?.translations?.data?.subscriptions?.subscriptionsOn ?? ""
            self.viewSelectSuscription.setDataInformation(titleOption: textTitleSelector)
        }
    }
    
    ///Funcion para encontrar el index del numero movil previamente seleccionado desde la seccion de resumen
    func setIndexPhonePreselect() {
        var indexPhonePreselect: Int = 0
        
        if self.numberPhonePreSelect != "" {
            for line in self.arrayMovilData {
                if self.numberPhonePreSelect == line.accountID{
                    break
                }
                indexPhonePreselect += 1
            }
        }
        self.indexAccountSelected = indexPhonePreselect
    }
    
    /// Actualizar la altura del scroll
    func updateHeightScroll() {
        var heightView: Float = 0
        if(selectedSuscripData.count == 0){
            heightView = 0
        }else{
            if  self.contentViewDetailSuscription != nil{
                heightView = Float(self.contentViewDetailSuscription.frame.maxY + self.viewSelectSuscription.frame.size.height + self.constantBottomHeightTabBar)
            }
        }
        self.scrollContent.contentSize = CGSize(width: self.view.frame.width, height: CGFloat(heightView))
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
    
    //MARK: Suscripciones
    func filterSuscripciones() {
        self.arraySubscriptions.removeAll()
        
        var arraySuscripData : [CardSuscriptionModel]  = []
        let formatter = DateFormatter()
    
        if let suscriptionArray = self.subsAccounts.subscription{
            for suscription in suscriptionArray{
                let suscriptionModel = CardSuscriptionModel()
                suscriptionModel.setAccountID(accountID: subsAccounts.accountId)
                let namePlan: String = suscription.service ?? ""
                suscriptionModel.serviceName = namePlan
                suscriptionModel.MSISDN = suscription.mSISDN ?? ""
                suscriptionModel.origin = suscription.origin ?? ""
                suscriptionModel.password = suscription.password ?? ""
                suscriptionModel.Provider = suscription.provider ?? ""
                suscriptionModel.shortNumber = suscription.shortNumber ?? ""
                
                let myDate = convertStringToDate(stringDate: suscription.subscriptionDate ?? "")
                formatter.dateFormat = "dd-MM-yyyy HH:mm"
                let myStringDate = formatter.string(from: myDate)
                print(myStringDate)                
                suscriptionModel.subscriptionDate = myStringDate

                suscriptionModel.lob = subsAccounts.lineOfBusiness
                suscriptionModel.status = 1
                
                arraySuscripData.append(suscriptionModel)
            }
            self.arraySubscriptions = arraySuscripData
        }
    }
    func filterHistorycSuscripciones() {
        self.arrayHistorySubscriptions.removeAll()
        
        var arrayHistorySuscripData : [CardSuscriptionModel]  = []
        let formatter = DateFormatter()
        
        if let suscriptionHistoryArray = subsHistorycAccounts.subscriptionHistory{
            for suscriptionHistory in suscriptionHistoryArray{
                
                let suscriptionModel = CardSuscriptionModel()
                suscriptionModel.setAccountID(accountID: subsHistorycAccounts.accountId)
                let namePlan: String = suscriptionHistory.service ?? ""
                suscriptionModel.serviceName = namePlan
                suscriptionModel.MSISDN = suscriptionHistory.mSISDN ?? ""
                suscriptionModel.Provider = suscriptionHistory.provider ?? ""
                suscriptionModel.shortNumber = suscriptionHistory.shortNumber ?? ""
                
                let myDate = convertStringToDate(stringDate: suscriptionHistory.subscriptionDate ?? "")
                formatter.dateFormat = "dd-MM-yyyy HH:mm"
                let myStringDate = formatter.string(from: myDate)
                print(myStringDate)
                suscriptionModel.subscriptionDate = myStringDate
                
                suscriptionModel.lob = subsHistorycAccounts.lineOfBusiness
                suscriptionModel.status = suscriptionHistory.status ?? 0
                
                arrayHistorySuscripData.append(suscriptionModel)
            }
            self.arrayHistorySubscriptions = arrayHistorySuscripData
        }
    }
    
    //MARK: LLAMADAS A SERVICIOS
    //Suscripciones
    //MARK: Web service RetrieveSMSPremiumSubscriptions
    func getSMSPremiumSubscriptions(accountId: String, lob: String, serviceID: String, completion: @escaping (() -> Void)) {
        let user = SessionSingleton.sharedInstance.getCurrentSession()
        let rutUser = user?.retrieveProfileInformationResponse?.personalDetailsInformation?.rUT
        
        if accountId == "" {
            return;
        }
        
        //Crear request
        let request = RetrieveSMSPremiumSubscriptionsRequest()
        request.retrieveSMSPremiumSubscriptions?.accountId = accountId
        request.retrieveSMSPremiumSubscriptions?.lineOfBusiness = lob
        request.retrieveSMSPremiumSubscriptions?.mSISDN = serviceID
        request.retrieveSMSPremiumSubscriptions?.userProfileID = rutUser
        
        //Crear request
        //        let request = RetrieveSMSPremiumSubscriptionsRequest()
        //        request.retrieveSMSPremiumSubscriptions?.accountId = "103573378" //id de la linea
        //        request.retrieveSMSPremiumSubscriptions?.lineOfBusiness = lob //line of business
        //        request.retrieveSMSPremiumSubscriptions?.mSISDN = "56959149848" //linea o telefono
        //        request.retrieveSMSPremiumSubscriptions?.userProfileID = "9400543-4" //rut
        
        WebServicesWithObjects.executeRetrieveSMSPremiumSubscriptions(params: request,
                                                                      onSuccess: { (result, resultType) in
                                                                        print("BINGO ISAI")
                                                                        let SMSPremiumSubscriptions = result.retrieveSMSPremiumSubscriptionsResponse ?? RetrieveSMSPremiumSubscriptionsResponse()
                                                                        SMSPremiumSubscriptions.accountId = accountId
                                                                        SMSPremiumSubscriptions.lineOfBusiness = lob
                                                                        SMSPremiumSubscriptions.serviceID = serviceID
                                                                        self.subsAccounts = SMSPremiumSubscriptions
                                                                        completion()
        }, onFailure: { (result, myError) in
            print("Error en el servicio RetrieveSMSPremiumSubscriptions")
            completion()
        });
        print("Terminar servicio y actualizar")
    }
    
    //LLAMADA A SERVICIO RetrieveSMSPremiumHistory PARA OBTENER EL HISTORIAL DE SUSCRIPCIONES
    func getHistorySubscriptions(accountId: String, lob: String, serviceID: String, completion: @escaping (() -> Void)) {
        let user = SessionSingleton.sharedInstance.getCurrentSession()
        let rutUser = user?.retrieveProfileInformationResponse?.personalDetailsInformation?.rUT
        
        if accountId == "" {
            return;
        }
        
        //RetrieveSMSPremiumHistory
        let req = RetrieveSMSPremiumHistoryRequest()
        req.retrieveSMSPremiumHistory = RetrieveSMSPremiumHistory()
        req.retrieveSMSPremiumHistory?.accountId = accountId
        req.retrieveSMSPremiumHistory?.lineOfBusiness = lob
        req.retrieveSMSPremiumHistory?.mSISDN = serviceID
        req.retrieveSMSPremiumHistory?.userProfileID = rutUser
        
        WebServicesWithObjects.executeRetrieveSMSPremiumHistory(params: req,
                                                                onSuccess: { (result) in
                                                                    let SMSPremiumHistorycSubscriptions = result.0.retrieveSMSPremiumHistoryResponse ?? RetrieveSMSPremiumHistoryResponse()
                                                                    SMSPremiumHistorycSubscriptions.accountId = accountId
                                                                    SMSPremiumHistorycSubscriptions.lineOfBusiness = lob
                                                                    SMSPremiumHistorycSubscriptions.serviceID = serviceID
                                                                    self.subsHistorycAccounts = SMSPremiumHistorycSubscriptions
                                                                    completion()
        },
                                                                onFailure: { (result, myError) in
                                                                    print("fallo")
                                                                    completion()
                                                                    
        });
        
    }
    
    //LLAMADA A SERVICIOS RetrieveSMSPremiumBlackListStatus PARA REVISAR EL ESTADO DE LA SUSCRIPCION
    func chekStatusSuscription(completion: @escaping (() -> Void)) {
        let user = SessionSingleton.sharedInstance.getCurrentSession()
        let rutUser = user?.retrieveProfileInformationResponse?.personalDetailsInformation?.rUT
        
        //RetrieveSMSPremiumBlackListStatus
        let req = RetrieveSMSPremiumBlackListStatusRequest()
        req.retrieveSMSPremiumBlackListStatus = RetrieveSMSPremiumBlackListStatus()
        req.retrieveSMSPremiumBlackListStatus?.accountId = selectedSuscripData.first?.accountID
        req.retrieveSMSPremiumBlackListStatus?.lineOfBusiness = selectedSuscripData.first?.lob
        req.retrieveSMSPremiumBlackListStatus?.mSISDN = selectedSuscripData.first?.MSISDN
        req.retrieveSMSPremiumBlackListStatus?.userProfileID = rutUser
        
        WebServicesWithObjects.executeRetrieveSMSPremiumBlackListStatus(params: req,
                                    onSuccess: { (result) in
                                        let acknowledgementCode = result.0.retrieveSMSPremiumBlackListStatusResponse?.acknowledgementCode
                                        if acknowledgementCode == "FFCM-SERMAN-RETBKLTSTAT-SC-1"{
                                            self.areInBlacklist = false
                                        }else{
                                            self.areInBlacklist = true
                                        }
                                          completion()
                                  
                                    },
                                    onFailure: { (result, myError) in
                                        self.areInBlacklist =  false
                                        completion()
        });
        
    }
    
    //LLAMADA A SERVICIOS PARA AGREGAR A LA LISTA NEGRA
    func blockSubscription() {
        let user = SessionSingleton.sharedInstance.getCurrentSession()
        let rutUser = user?.retrieveProfileInformationResponse?.personalDetailsInformation?.rUT
        
        //AddSMSPremiumToBlackList
        //        req.addSMSPremiumToBlackList = AddSMSPremiumToBlackList()
        //        req.addSMSPremiumToBlackList?.accountId = "103573378" //id de la linea
        //        req.addSMSPremiumToBlackList?.lineOfBusiness = lob    //line of business
        //        req.addSMSPremiumToBlackList?.mSISDN = "56987737703"  //linea o telefono
        //        req.addSMSPremiumToBlackList?.userProfileID = rutUser //rut
        
        let req = AddSMSPremiumToBlackListRequest()
        req.addSMSPremiumToBlackList = AddSMSPremiumToBlackList()
        req.addSMSPremiumToBlackList?.accountId = selectedSuscripData.first?.accountID
        req.addSMSPremiumToBlackList?.lineOfBusiness = selectedSuscripData.first?.lob
        req.addSMSPremiumToBlackList?.mSISDN = selectedSuscripData.first?.MSISDN
        req.addSMSPremiumToBlackList?.userProfileID = rutUser
        
        WebServicesWithObjects.executeAddSMSPremiumToBlackList(params: req,
                                    onSuccess: { (result) in
                                                            
                                        let alert = AlertAcceptOnly();
                                        alert.title = self.textConfiguration?.translations?.data?.subscriptions?.subscriptionsSuccessBlockTitle ?? ""
                                        alert.text = self.textConfiguration?.translations?.data?.subscriptions?.subscriptionsSuccessBlockDescription ?? ""
                                        alert.onAcceptEvent = {}
                                        alert.icon = AlertIconType.IconoAlertaFelicidades
                                        NotificationCenter.default.post(name: Observers.ObserverList.AcceptOnlyAlert.name, object: alert);
                                        
                                        self.areInBlacklist = true
                                        self.refreshBtnSuscriptionText()
        },
                                    onFailure: { (result, myError) in
                                        let accept = AlertAcceptOnly();
                                        accept.title = ""
                                        accept.text = (result?.addSMSPremiumToBlackListResponse?.acknowledgementDescription) ?? ""
                                        accept.icon = AlertIconType.IconoAlertaError
                                        accept.onAcceptEvent = {}
                                        NotificationCenter.default.post(name: Observers.ObserverList.AcceptOnlyAlert.name,
                                                                                            object: accept);
                                        self.areInBlacklist = false
                                        self.refreshBtnSuscriptionText()
                                                            
        });
    }
    
    //LLAMADA A SERVICIOS PARA Quitar de LA LISTA NEGRA RemoveSMSPremiumFromBlackList
    func unBlockSubscription() {
        let user = SessionSingleton.sharedInstance.getCurrentSession()
        let rutUser = user?.retrieveProfileInformationResponse?.personalDetailsInformation?.rUT
        
        let req = RemoveSMSPremiumFromBlackListRequest()
        req.removeSMSPremiumFromBlackList = RemoveSMSPremiumFromBlackList()
        req.removeSMSPremiumFromBlackList?.accountId = selectedSuscripData.first?.accountID
        req.removeSMSPremiumFromBlackList?.lineOfBusiness = selectedSuscripData.first?.lob
        req.removeSMSPremiumFromBlackList?.mSISDN = selectedSuscripData.first?.MSISDN
        req.removeSMSPremiumFromBlackList?.userProfileID = rutUser
        
        WebServicesWithObjects.executeRemoveSMSPremiumFromBlackList(params: req,
                                                               onSuccess: { (result) in
                                                                
                                                                let alert = AlertAcceptOnly();
                                                                alert.title = self.textConfiguration?.translations?.data?.subscriptions?.subscriptionsUnlockSuccessTitle ?? ""
                                                                alert.text = self.textConfiguration?.translations?.data?.subscriptions?.subscriptionsUnlockSuccessDescription ?? ""
                                                                alert.onAcceptEvent = {}
                                                                alert.icon = AlertIconType.IconoAlertaFelicidades
                                                                NotificationCenter.default.post(name: Observers.ObserverList.AcceptOnlyAlert.name, object: alert);
                                                                
                                                                self.areInBlacklist = false
                                                                self.refreshBtnSuscriptionText()
        },
                                                               onFailure: { (result, myError) in
                                                                let accept = AlertAcceptOnly();
                                                                accept.title = ""
                                                                accept.text = (result?.removeSMSPremiumFromBlackListResponse?.acknowledgementDescription) ?? ""
                                                                accept.icon = AlertIconType.IconoAlertaError
                                                                accept.onAcceptEvent = {}
                                                                NotificationCenter.default.post(name: Observers.ObserverList.AcceptOnlyAlert.name,
                                                                                                object: accept);
                                                                self.areInBlacklist = true
                                                                self.refreshBtnSuscriptionText()
        });
    }
    
    //LLAMADA A SERVICIOS PARA ELIMINAR LA SUSCRIPCION UnsubscribeSMSPremium
    func UnsubscribeSubscription(detailSubscrip: CardSuscriptionModel) {
        let user = SessionSingleton.sharedInstance.getCurrentSession()
        let rutUser = user?.retrieveProfileInformationResponse?.personalDetailsInformation?.rUT
        
        let req = UnsubscribeSMSPremiumRequest()
        req.unsubscribeSMSPremium = UnsubscribeSMSPremium()
//        req.unsubscribeSMSPremium?.accountId = selectedSuscripData.first?.accountID
//        req.unsubscribeSMSPremium?.lineOfBusiness = selectedSuscripData.first?.lob
//        req.unsubscribeSMSPremium?.userProfileID = rutUser
        
        req.unsubscribeSMSPremium?.service = UnsubscribeService()
        req.unsubscribeSMSPremium?.service?.mSISDN = selectedSuscripData.first?.MSISDN
        req.unsubscribeSMSPremium?.service?.origin = detailSubscrip.origin
        req.unsubscribeSMSPremium?.service?.password = detailSubscrip.password
        req.unsubscribeSMSPremium?.service?.provider = detailSubscrip.Provider
        req.unsubscribeSMSPremium?.service?.service = detailSubscrip.serviceName
        req.unsubscribeSMSPremium?.service?.shortNumber = detailSubscrip.shortNumber
        
        req.unsubscribeSMSPremium?.accountId = selectedSuscripData.first?.accountID
        req.unsubscribeSMSPremium?.lineOfBusiness = selectedSuscripData.first?.lob
        req.unsubscribeSMSPremium?.userProfileID = rutUser
        req.unsubscribeSMSPremium?.mSISDN = selectedSuscripData.first?.MSISDN
        
        WebServicesWithObjects.executeUnsubscribeSMSPremium(params: req,
                                                               onSuccess: { (result) in
                                                                
                                                                let alert = AlertAcceptOnly();
                                                                alert.title = self.textConfiguration?.translations?.data?.subscriptions?.subscriptionsSuccessDelete ?? ""
                                                                alert.text = (self.textConfiguration?.translations?.data?.subscriptions?.subscriptionsSuccessDeleteDescription ?? "") + " " + detailSubscrip.serviceName + "."
                                                                alert.onAcceptEvent = {}
                                                                alert.icon = AlertIconType.IconoAlertaFelicidades
                                                                alert.acceptTitle = self.textConfiguration?.translations?.data?.generales?.closeBtn ?? "Cerrar"
                                                                NotificationCenter.default.post(name: Observers.ObserverList.AcceptOnlyAlert.name, object: alert);
                                                                
                                                                self.getLineSubscriptions()
        },
                                                               onFailure: { (result, myError) in
                                                                let accept = AlertAcceptOnly();
                                                                accept.title = ""
                                                                accept.text = (result?.unsubscribeSMSPremiumResponse?.acknowledgementDescription) ?? ""
                                                                accept.icon = AlertIconType.IconoAlertaError
                                                                accept.onAcceptEvent = {}
                                                                NotificationCenter.default.post(name: Observers.ObserverList.AcceptOnlyAlert.name,
                                                                                                object: accept);
                                                                
        });
    }
    
}

//MARK: CardSelectServiceDelegate
extension CardSuscriptionManagement: CardSelectServiceDelegate {
    func showPopupServices() {
        let popupServices = PopupSelectServiceViewController(nibName: "PopupSelectServiceViewController", bundle: nil)
        popupServices.modalPresentationStyle = .overFullScreen
        popupServices.setDataInformationServices(arrayServices: self.arrayMovilData, title: self.textMobile, indexSelect: self.indexAccountSelected)
        popupServices.delegate = self
        self.present(popupServices, animated: true, completion: nil)
    }
}

//MARK: PopupSelectServiceDelegate
extension CardSuscriptionManagement: PopupSelectServiceDelegate {
    func popupSelectServiceAcceptAction(indexService: Int) {
        self.indexAccountSelected = indexService
        historySelecte = false
        self.getLineSubscriptions()
    }
}

//MARK: SelectOptionSuscriptionDelegate
extension CardSuscriptionManagement: SelectOptionSuscriptionDelegate {
    func showPopupSubscriptions() {
        let titlePopup = textConfiguration?.translations?.data?.subscriptions?.subscriptionsTitle ?? ""
        let popupServices = PopupSelectSubscriptionViewController(nibName: "PopupSelectSubscriptionViewController", bundle: nil)
        popupServices.modalPresentationStyle = .overFullScreen
        popupServices.setDataInformationSubscrip(title: titlePopup, indexSelect: self.indexSubscripSelected)
        popupServices.delegate = self
        self.present(popupServices, animated: true, completion: nil)
    }
}

//MARK: PopupSelectSubscriptionDelegate
extension CardSuscriptionManagement: PopupSelectSubscriptionDelegate {
    func popupSelectSubscripAcceptAction(indexSubscripSelector: Int) {
        self.indexSubscripSelected = indexSubscripSelector
        self.updateSelectorSubscribTitle()
        if indexSubscripSelector == 1{
            historySelecte = true
        }
        else{
            historySelecte = false
        }
        self.updateDataServiceSelected()
    }
}

//MARK: CardContentDetailDelegate
extension CardSuscriptionManagement: ContentDetailSuscriptionDelegate {
    func eraseSubscrip(detailSubscrip: CardSuscriptionModel) {
        let info = AlertYesNo();
        info.title =  SessionSingleton.sharedInstance.getGeneralConfig()?.translations?.data?.subscriptions?.subscriptionsDeleteTitle ?? ""
        let descripText = SessionSingleton.sharedInstance.getGeneralConfig()?.translations?.data?.subscriptions?.subscriptionsSureWantDelete ?? ""
        let questionText = "\(descripText) \(detailSubscrip.serviceName)?"
        info.text = questionText
        info.acceptTitle = SessionSingleton.sharedInstance.getGeneralConfig()?.translations?.data?.generales?.confirmBtn ?? ""
        info.icon = .IconoAlertaError;
        info.onAcceptEvent = {
            self.UnsubscribeSubscription(detailSubscrip: detailSubscrip)
        }
        info.cancelTitle =  SessionSingleton.sharedInstance.getGeneralConfig()?.translations?.data?.generales?.cancelBtn ?? ""
        info.onCancelEvent = {
            
        }
        NotificationCenter.default.post(name: Observers.ObserverList.YesNoAlert.name,
                                        object: info)
    }
}
