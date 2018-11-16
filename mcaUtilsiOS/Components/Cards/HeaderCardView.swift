//
//  HeaderCardView.swift
//  MiClaro
//
//  Created by Jonathan Abimael Cruz Orozco on 27/11/17.
//  Copyright © 2017 am. All rights reserved.
//

import UIKit
import Cartography

protocol HeaderCardViewDelegate {
    func btnRedAction(webId: String)
    func btnShowBoleta(indexCard: Int, typeCard: TypeCardView)
}

class HeaderCardView: UIView {
    
    //Visual elements
    var imgHeader: UIImageView!
    var lblTitleHeader: BlackTitleLabel!
    var viewUnderline: UIView!
    var lblSubtitleHeader: BlackBodyLabel!
    var lblTotalPay: BlackBodyLabel!
    var lblTotalPayDesc: BlackTitleLabel!
    var lblDateToPay: BlackBodyLabel!
    var btnPayBoleta: RedBackgroundButton!
    var warningView : WarningView!
    var totalContainer : UIView!
    
    //Variable para saber si en movil se debe mostrar el mensaje de plan inactivo
    var showMessageMovilPlan: Bool = false
    
    let conf = SessionSingleton.sharedInstance.getGeneralConfig()
    
    private var lastView : UIView? = nil
    //Este boton cambia dependiendo si es resumen o alguna otra sección
    private var showBoleta: Bool = false
    var btnCustomTitle: UIButton?
    
    //For identifier the last position label
    var posYlastLabel: CGFloat = 0.0
    
    //For update the height of view
    var heightContentView: CGFloat = 0.0
    
    //For get the info and show
    private var accountData: ServiceAccount?
    private var accountDataArray: [ServiceAccount] = [ServiceAccount]()
    private var typeAccount: TypeAccounts?
    
    //For info in Movil
    private var plan: DetailPlan?
    
    private var typeCard: TypeCardView = TypeCardView.Resumen
    //Indice para identificar el tipo de cuenta a la que se debe acceder
    private var indexService: Int = 0
    private var indexAccount: Int = 0
    
    var delegate: HeaderCardViewDelegate?
    
    var arrayServiceDescription: [(String, String)] = [(String, String)]()
    
    //Create the interface view
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.yellow
        self.addTopView()
        self.addMiddleView()
    }
    
    /// init
    /// Parameters frame: dimensiones de la nueva card
    /// Parameters accountDataArray: arreglo con las cuentas a mostrar
    /// Parameters typeCard: tipo de cuenta a mostrar
    /// Parameters indexAccount: index de la cuenta a mostrar
    /// Parameters typeAccount: Tipo de cuenta a mostrar
    init(frame: CGRect, accountDataArray: [ServiceAccount], typeCard: TypeCardView, indexAccount: Int, typeAccount: TypeAccounts) {
        super.init(frame: frame)
        
        self.accountDataArray = accountDataArray
        self.typeCard = typeCard
        self.indexAccount = indexAccount
        self.typeAccount = typeAccount
        selectInterfaceToShow()
    }
    /// init
    /// Parameters frame: dimensiones de la nueva card
    /// Parameters accountData: cuenta a mostrar
    /// Parameters typeCard: tipo de cuenta a mostrar
    /// Parameters indexAssociateService: index del servicio asociado a esa cuenta
    /// Parameters typeAccount: Tipo de cuenta a mostrar
    init(frame: CGRect, accountData: ServiceAccount, typeCard: TypeCardView, indexAssociateService: Int, indexAccount: Int) {
        super.init(frame: frame)
        
        self.accountData = accountData
        self.typeCard = typeCard
        self.indexService = indexAssociateService
        self.indexAccount = indexAccount
        selectInterfaceToShow()
    }
    /// init
    /// Parameters frame: dimensiones de la nueva card
    /// Parameter plan: Plan a motrar
    /// Parameters typeCard: tipo de cuenta a mostrar
    init(frame: CGRect, plan: DetailPlan, typeCard: TypeCardView) {
        super.init(frame: frame)
        self.plan = plan
        self.typeCard = typeCard
        selectInterfaceToShow()
    }
    /// Posicionar la etiqueta de total a pagar
    func setupTotalLabelAlignment(toCenter : Bool = false) {
        if !toCenter {
            lblTotalPay.textAlignment = .left
            lblTotalPayDesc.textAlignment = .right
        } else {
            lblTotalPay.textAlignment = .right
            lblTotalPayDesc.textAlignment = .left
        }
    }
    
    
    /// mostrar la información segun el tipo de card seleccionado
    func selectInterfaceToShow() {
        self.backgroundColor = institutionalColors.claroWhiteColor
        
        //Identifi the type of card view to show
        switch self.typeCard {
        case .Resumen:
            self.addTopView()
            self.showBoleta = false
            self.getNamePlanResume()
            break
        case .Móvil:
            self.addTopView()
            self.showBoleta = true
            self.getInformationMovil()
            break
        case .Internet:
            self.addTopView()
            self.showBoleta = true
            self.getInformationInternet()
            break
        case .Teléfono:
            break;
        case .Televisión:
            self.addTopView()
            self.showBoleta = true
            self.getInformationTelevision()
            break
        case .TodoClaro:
            self.addTopView()
            self.showBoleta = true
            self.getInformationTodoClaro()
            break
        default:
            break
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Insertar los componentes visuales en la card, únicamente los componentes de titulo y subtitulo
    func addTopView() {
        let dimensionImg: CGFloat = 30.0
        let padding: CGFloat = 10.0
        
        imgHeader = UIImageView()//(image: UIImage(named: "ico_miscuentas_24px"))
        imgHeader.frame = CGRect(x: padding, y: 30.0, width: dimensionImg, height: dimensionImg)
        
        lblTitleHeader = BlackTitleLabel()
        lblTitleHeader.frame = CGRect(x: imgHeader.bounds.width + padding, y: 30.0, width: self.bounds.width - (padding + dimensionImg) * 2, height: 30.0)
        lblTitleHeader.font = UIFont(name: RobotoFontName.RobotoMedium.rawValue, size: CGFloat(16.0))
        //        lblTitleHeader.numberOfLines = 2
//        lblTitleHeader.sizeToFit()
//        lblTitleHeader.adjustsFontSizeToFitWidth = true
//        lblTitleHeader.minimumScaleFactor = 0.2
        
        viewUnderline = UIView()
        viewUnderline.backgroundColor = institutionalColors.claroRedColor
        
        lblSubtitleHeader = BlackBodyLabel()
        lblSubtitleHeader.frame = CGRect(x: padding, y: lblTitleHeader.frame.maxY + 5.0, width: self.bounds.width - (padding * 4.0), height: 20.0)
        lblSubtitleHeader.textColor = institutionalColors.claroTextColor
        lblSubtitleHeader.font = UIFont(name: RobotoFontName.RobotoRegular.rawValue, size: CGFloat(14))
        lblSubtitleHeader.numberOfLines = 0
        lblSubtitleHeader.adjustsFontSizeToFitWidth = true
        lblSubtitleHeader.textAlignment = .center

        self.addSubview(imgHeader)
        self.addSubview(lblTitleHeader)
        self.addSubview(lblSubtitleHeader)
        lastView = lblSubtitleHeader
        posYlastLabel = lblSubtitleHeader.frame.maxY
        
        let updateHeight = lblSubtitleHeader.frame.maxY
        updateHeightView(newHeight: updateHeight)
        
    }
    /// Insertar los componentes variables en la card, como el nombre de los servicios y su precio
    func addMiddleView() {
        let padding: CGFloat = 10.0
        let widhtLbl: CGFloat = self.bounds.width * (3 / 4)
        var posYlbl: CGFloat = lblSubtitleHeader.frame.maxY

        if 0 == arrayServiceDescription.count {
            let warningRect = CGRect(x:  padding, y: posYlbl + 40.0, width: self.frame.width - 20, height: 35)
            warningView = WarningView(frame: warningRect)
            warningView.setup()
            self.addSubview(warningView)
            lastView = warningView
            posYlbl = posYlbl + warningView.bounds.height + padding
            posYlastLabel = posYlbl
        }
        
        for index in 0 ..< arrayServiceDescription.count {
            let lblTmp = BlackBodyLabel()
            let lblTmpDesc = BlackBodyLabel()
            print("\(arrayServiceDescription[index].0) - \(arrayServiceDescription[index].1)")
            lblTmp.frame = CGRect(x: padding, y: posYlbl + 5.0, width: widhtLbl, height: 12.0)
            lblTmp.text = arrayServiceDescription[index].0
            lblTmp.textColor = institutionalColors.claroBlackColor
            lblTmp.font = UIFont(name: RobotoFontName.RobotoLight.rawValue, size: CGFloat(12))
            lblTmp.textAlignment = .left
            lblTmp.sizeToFit();
            lblTmp.adjustHeighToFit()
            
            lblTmpDesc.frame = CGRect(x: padding + lblTmp.bounds.width + padding / 2 , y: posYlbl + 5.0, width: self.bounds.width - lblTmp.frame.width, height: 12.0)
            lblTmpDesc.text = arrayServiceDescription[index].1
            lblTmpDesc.textColor = institutionalColors.claroTextColor
            lblTmpDesc.font = UIFont(name: RobotoFontName.RobotoLight.rawValue, size: CGFloat(12))
            lblTmpDesc.sizeToFit()
            lblTmpDesc.textAlignment = .right
            lblTmpDesc.adjustHeighToFit()
            
            self.addSubview(lblTmp)
            self.addSubview(lblTmpDesc)
            if index == 0 {
                constrain(lblSubtitleHeader, lblTmp, self) { (subtitle, tmp, view) in
                    tmp.height == 29
                    tmp.top == subtitle.bottom + padding
                    tmp.leading == 10 + view.leading
                }
                constrain(lblSubtitleHeader, lblTmp, lblTmpDesc, self) { (subtitle, tmp, desc, view) in
                    desc.height == 29
                    desc.top == subtitle.bottom + padding
                    desc.leading == tmp.trailing + padding
                    desc.trailing == view.trailing - padding
                }
            } else {
                constrain(lastView!, lblTmp, self) { (last, tmp, view) in
                    tmp.height == 29
                    tmp.top == last.bottom + padding
                    tmp.leading == 10 + view.leading
                }
                constrain(lblTmp, lblTmpDesc, self) { (tmp, desc, view) in
                    desc.height == 29
                    desc.top == tmp.top
                    desc.leading == tmp.trailing + padding
                    desc.trailing == view.trailing - padding
                }
            }
            lastView = lblTmp
            posYlbl = posYlbl + lblTmp.bounds.height + padding
            posYlastLabel = posYlbl
        }

        let separator = UIView(frame: CGRect(x: padding, y: posYlastLabel + 16, width: self.bounds.width - (padding * 2), height: 1))
        separator.tag = 10000
        separator.backgroundColor = institutionalColors.claroSelectionGrayColor
        self.addSubview(separator)
        constrain( separator, lastView!, self) { (sep, lbl, view) in
            sep.top == lbl.bottom + padding
            sep.width == view.width - 20
            sep.centerX == view.centerX
            sep.height == 1
        }
        
        posYlastLabel = posYlastLabel + separator.frame.height + (padding)// * 2)
        let height = posYlastLabel
        updateHeightView(newHeight: height)
        
    }
    /// Insertar los últimos componentes en la card, como lo son los botones, el total a pagar etc.
    func addBottomView(_ aligned : Bool) {
        let padding: CGFloat = 10.0
        let widthLabel: CGFloat = (self.bounds.width / 2) - (padding * 2)
        let heightLabel: CGFloat = 20.0

        totalContainer = UIView(frame: CGRect(x: 0, y: (self.lastView?.frame.maxY)! + 10.0 , width: self.bounds.width, height: heightLabel))
        
        lblTotalPay = BlackBodyLabel()
        if aligned, lastView != nil {
            lblTotalPay.frame = CGRect(x: padding, y: 0, width: widthLabel - 20, height: heightLabel)
            //lblTotalPay.frame = CGRect(x: padding, y: (self.lastView?.frame.maxY)! + 10.0, width: widthLabel, height: heightLabel)
        } else {
            lblTotalPay.frame = CGRect(x: padding, y: 0, width: widthLabel - 20, height: heightLabel)
            //lblTotalPay.frame = CGRect(x: padding, y: self.posYlastLabel + 10.0, width: widthLabel, height: heightLabel)
        }
        lblTotalPay.textColor = institutionalColors.claroBlackColor
        lblTotalPay.textAlignment = .right
        lblTotalPay.font = UIFont(name: RobotoFontName.RobotoRegular.rawValue, size: CGFloat(16.0))
        
        lblTotalPayDesc = BlackTitleLabel()
        lblTotalPayDesc.frame = CGRect(x: widthLabel + (padding * 2), y: self.posYlastLabel + 10.0, width: widthLabel - 20, height: heightLabel)
        lblTotalPayDesc.font = UIFont(name: RobotoFontName.RobotoRegular.rawValue, size: CGFloat(16.0))
        lblTotalPayDesc.textAlignment = .left

        totalContainer.addSubview(lblTotalPay)
        totalContainer.addSubview(lblTotalPayDesc)

        lblDateToPay = BlackBodyLabel()
        lblDateToPay.frame = CGRect(x: padding, y: lblTotalPayDesc.frame.maxY + 10.0, width: self.bounds.width - padding * 3, height: heightLabel)
        lblDateToPay.textColor = institutionalColors.claroTextColor
        lblDateToPay.textAlignment = .left
        
        btnPayBoleta = RedBackgroundButton(textButton: NSLocalizedString("totalPay", comment: ""))
        btnPayBoleta.frame = CGRect(x: padding * 2, y: lblDateToPay.frame.maxY + 10.0, width: self.bounds.width - padding * 6, height: 10.0)
        btnPayBoleta.addTarget(self, action: #selector(HeaderCardView.btnRedTouchInside), for: .touchUpInside)
        btnPayBoleta.titleLabel?.font = UIFont(name: RobotoFontName.RobotoMedium.rawValue, size: CGFloat(16.0))
        
        //Este boton debe poder cambiar el texto a mostrar
        btnCustomTitle = UIButton(frame: CGRect(x: self.showBoleta ? padding : padding * 2, y: btnPayBoleta.frame.maxY + 40.0, width: btnPayBoleta.bounds.width, height: 16.0))
        btnCustomTitle?.titleLabel?.font = UIFont(name: RobotoFontName.RobotoRegular.rawValue, size: CGFloat(16.0))
        var shouldAddUnderline = false
        if self.showBoleta {
            btnCustomTitle?.setTitle("Ver Boleta >", for: .normal)
            btnCustomTitle?.setTitleColor(institutionalColors.claroBlueColor, for: .normal)
            btnCustomTitle?.addTarget(self, action: #selector(btnShowBoleta), for: .touchUpInside)
        }else {
            btnCustomTitle?.setTitle("Detalle de tus servicios", for: .normal)
            btnCustomTitle?.setTitleColor(UIColor.black, for: .normal)
            shouldAddUnderline = true
        }
        
        //self.addSubview(lblTotalPay)
        //self.addSubview(lblTotalPayDesc)
        self.addSubview(totalContainer)
        self.addSubview(lblDateToPay)
        self.addSubview(btnPayBoleta)
        self.addSubview(btnCustomTitle!)
        
        var height = btnCustomTitle?.frame.maxY ?? 0
        
        if shouldAddUnderline {
            let underLineWidth :CGFloat = 100 //btnCustomTitle!.frame.width / 2
            let underLineFrame = CGRect(x: underLineWidth - self.center.x, y: /*btnCustomTitle!.frame.height + btnCustomTitle!.frame.origin.y*/height /*+ 16*/, width: underLineWidth, height: 1)
            let _viewUnderline = UIView(frame: underLineFrame )
            _viewUnderline.center.x = btnCustomTitle!.center.x
            _viewUnderline.backgroundColor = institutionalColors.claroRedColor
            _viewUnderline.tag = 10001
            self.addSubview(_viewUnderline)
            
            height = _viewUnderline.frame.maxY
            print("Posición final del view underline resumen \(_viewUnderline.frame.maxY)")
        }
        updateHeightView(newHeight: height /*+ 20*/)
    }
    /// Actualizar la altura de la card
    /// Parameter newHeight: nueva altura para la card
    func updateHeightView(newHeight: CGFloat) {
        heightContentView = newHeight
        print("HEIGHT VIEW HEADER CARD \(heightContentView)")
        self.frame = CGRect(x: 10.0, y: 40.0, width: self.frame.width/* - 5.0*/, height: heightContentView)
    }
    /// Obtener la altura actual de la card
    func getHeightHeaderView() -> CGFloat {
        return self.heightContentView
    }
    
    func getTypeAccount() {
        
    }
    /// Ajustar los constraints de los elementos dentro de la card
    func addTotalConstraints(toResume : Bool = false ){
        if toResume {
            var separator : UIView? = nil
            var underline : UIView? = nil
            for view in subviews {
                if view.tag == 10000 {
                    separator = view
                }
                if view.tag == 10001 {
                    underline = view
                }
            }
            if let _separator = separator {
                constrain(_separator, totalContainer, self) { (sep, cont, view) in
                    cont.top == sep.bottom
                    cont.height == 40
                    cont.leading == view.leading + 10
                    cont.trailing == view.trailing - 10
                }
                constrain( lblTotalPay, lblTotalPayDesc, totalContainer) { ( total, des, view ) in
                    total.leading == view.leading
                    total.top == view.top
                    total.bottom == view.bottom
                    total.trailing == view.centerX - 10
                    des.leading == view.centerX  + 10
                    des.trailing == view.trailing
                    des.top == view.top
                    des.bottom == view.bottom
                }
                constrain(totalContainer, btnPayBoleta, self) { (total, btn, view) in
                    btn.top == total.bottom + 0
                    btn.centerX == total.centerX
                    btn.leading == view.leading + 20
                    btn.trailing == view.trailing - 20
                    btn.height == 40
                }
                
                if let _ = btnCustomTitle, let _ = underline  {
                    constrain(btnCustomTitle!, btnPayBoleta, underline!, self) { (title, btn, undl, view) in
                        title.top == btn.bottom + 15// + 32
                        title.leading == btn.leading
                        title.trailing == btn.trailing
                        undl.top == title.bottom + 10//+ 16
                        undl.centerX == title.centerX
                        undl.width == title.width / 3
                        undl.height == 1
//                        undl.bottom == view.bottom - 16
                    }
                } else if let _ = btnCustomTitle {
                    constrain(btnCustomTitle!, btnPayBoleta) { (title, btn) in
                        title.top == btn.bottom + 15
                        title.leading == btn.leading
                        title.trailing == btn.trailing
                    }
                }
//                updateHeightView(newHeight: (btnCustomTitle?.frame.maxY)!/*btnPayBoleta.frame.maxY*/ /*+ 10*/)
            } else {
                constrain(lblTotalPay, lblTotalPayDesc, totalContainer) { (total, des, view) in
                    total.leading == view.leading + 10
                    total.top == view.top
                    total.bottom == view.bottom
                    total.trailing == view.centerX - 10
                    des.leading == view.centerX  + 10
                    des.trailing == view.trailing - 10
                    des.top == view.top
                    des.bottom == view.bottom
                }
            }
            
            lblTotalPay.textAlignment = .right
            lblTotalPayDesc.textAlignment = .left
        } else {
            constrain(lblTotalPay, lblTotalPayDesc, totalContainer) { (total, des, view) in
                total.leading == view.leading + 10
                total.top == view.top
                total.bottom == view.bottom
                total.trailing == des.leading
                des.trailing == view.trailing - 10
                des.top == view.top
                des.bottom == view.bottom
            }
        }
    }
    /// Agregar constraints al mensaje de error
    func addWarningConstraint() {
        constrain(btnPayBoleta, warningView) { (boleta, warning) in
            boleta.top == warning.bottom + 10
        }
    }
    
    //MARK: RESUME CARD INFO INTERFACE
    /// Actualizar la información en la card
    /// Parameter dateToPay: mostrar fecha de pago
    /// Parameter totalPay: mostrar total a pagar
    func interfaceResumeView(dateToPay: String, totalPay: Float) {
        imgHeader.image = UIImage(named: "ico_seccion_mc_resumen")
        imgHeader.isHidden = true;
        lblTitleHeader.text = conf?.translations?.data?.landing?.summaryTitle ?? "";
        //lblTitleHeader.sizeToFit()
        lblTitleHeader.adjustHeighToFit()
        
        var subtitleText = NSLocalizedString("payAllTheBills", comment: "")
        var titleBtnRed = NSLocalizedString("totalPay", comment: "")
        
        if self.typeAccount == TypeAccounts.Prepago {
            subtitleText = NSLocalizedString("payAllTheBillsPrepago", comment: "")
            lblTotalPay.isHidden = true
            lblTotalPayDesc.isHidden = true
            titleBtnRed = NSLocalizedString("reload", comment: "")
        }
        
        if false == SessionSingleton.sharedInstance.isConsumingService() {
            addTotalConstraints(toResume: true)
            lblSubtitleHeader.text = subtitleText//NSLocalizedString("payAllTheBills", comment: "")
            lblTotalPay.text = NSLocalizedString("totalToPay", comment: "")
            lblTotalPayDesc.text = formatToCountryCurrency(monto: totalPay)
            let myDate = convertStringToDateO(stringDate: dateToPay)
            let myDateString = getFullStringDate(date: myDate)
            lblDateToPay.text = "\(getTitleByLOB()) \(myDateString)"
            lblDateToPay.isHidden = true;
            setupTotalLabelAlignment(toCenter: true)
            btnPayBoleta.setTitle(titleBtnRed, for: .normal)
        }
        
        //Ajustamos las posiciones
        self.adjustConstraintTo(true)
    }
    /// Obtener textos para ser mostrados en la aplicación
    /// return string: texto a mostrar
    func getTitleByLOB() -> String {
        if self.accountData?.account?.lineOfBusiness == "2" {
            return SessionSingleton.sharedInstance.getGeneralConfig()?.translations?.data?.generales?.paidBeforePre ?? "Vence el:"
        }
        return SessionSingleton.sharedInstance.getGeneralConfig()?.translations?.data?.generales?.paidBefore ?? "Antes del:"
    }
    /// mostrar mensaje de error al no existir información a mostrar
    /// Parameter textPay: leyenda de cantidad a pagar
    /// Parameter totalPay: cantidad a pagar
    func shouldAddWarning(textPay: String, totalPay : String) {
        if totalPay.count > 0 {
            lblTotalPay.text = textPay
            lblTotalPay.textAlignment = .left
            lblTotalPayDesc.text = formatToCountryCurrency(strMonto: totalPay)
            lblTotalPayDesc.textAlignment = .right
            addTotalConstraints()
        } else {
            let warningRect = CGRect(x:  10, y: 0, width: self.totalContainer.frame.width - 20, height: 35)
            warningView = WarningView(frame: warningRect)
            let subviews = self.totalContainer.subviews
            for view in subviews {
                view.removeFromSuperview()
            }
            warningView.setup()
            self.totalContainer.addSubview(warningView)
            self.addWarningConstraint()
        }
    }
    
    //MARK: RESUME CARD INFO
    /// Actualizar la información para la card de Movil
    /// Parameter namePlan: Nombre del plan a mostrar
    /// Parameter subtitle: subtitulo a mostrar
    /// Parameter totalPay: total a pagar
    /// Parameter date: mostrar fecha
    /// Parameter lob: Line of bussiness
    func interfaceMovilView(namePlan: String, subtitle: String, totalPay: String, date: String, lob: String, messageReload: String = "") {
        var textPay: String = NSLocalizedString("totalToPay", comment: "")
        var textBtn: String = NSLocalizedString("payBill", comment: "")
        
        if let totalPay = SessionSingleton.sharedInstance.getGeneralConfig()?.translations?.data?.generales?.totalToPay {
            textPay = totalPay
        }
        if let payBill = SessionSingleton.sharedInstance.getGeneralConfig()?.translations?.data?.generales?.payBill {
            textBtn = payBill
        }
        
        if lob == "2" {//Prepago
            textPay = SessionSingleton.sharedInstance.getGeneralConfig()?.translations?.data?.mobile?.balance ?? NSLocalizedString("credit-available", comment: "")
            textBtn = SessionSingleton.sharedInstance.getGeneralConfig()?.translations?.data?.mobile?.topUpBtn ?? NSLocalizedString("reload", comment: "")
            btnCustomTitle?.isHidden = true
        }
        
        imgHeader.image = UIImage(named: "ico_seccion_mc_movil")
        lblTitleHeader.text = namePlan
        lblTitleHeader.adjustHeighToFit()
        if let phone = SessionSingleton.sharedInstance.getGeneralConfig()?.translations?.data?.generales?.phone {
            lblSubtitleHeader.text = "\(phone): \(subtitle)"
        } else {
            lblSubtitleHeader.text = "Teléfono: \(subtitle)"
        }
        
        
        shouldAddWarning(textPay: textPay, totalPay: totalPay)
        
        //Validar que mensaje debemos mostrar
        
        
        if date != "" {
            let myDate = convertStringToDateO(stringDate: date)
            let tmpDate = getFullStringDate(date: myDate)
            if messageReload != "" {
                do {
                    lblDateToPay.attributedText = try NSAttributedString(htmlString: messageReload)
                }catch {
                    
                }
//                lblDateToPay.text = messageReload
                lblDateToPay.textAlignment = .center
                lblDateToPay.backgroundColor = UIColor(red: 1.0, green: 245/255, blue: 236/255, alpha: 1.0) //UIColor.yellow
                self.showMessageMovilPlan = true
            }else {
                lblDateToPay.text = "\(getTitleByLOB()) \(tmpDate)"
            }
            
        }else {
            lblDateToPay.text = ""
        }
        
        
        btnPayBoleta.setTitle(textBtn, for: .normal)
        buttonColorBy(total: totalPay, button: btnPayBoleta)
        self.adjustConstraintTo(true, bottom: true)
    }
    /// Aplicar color al botón
    func buttonColorBy(total: String, button : UIButton) {
        if let value = Int(total), value == 0 {
            
            button.backgroundColor = institutionalColors.claroRedColor
        } else {
            button.backgroundColor = institutionalColors.claroRedColor
        }
    }
    /// Actualizar la información para la card de Todo claro
    /// Parameter namePlan: Nombre del plan a mostrar
    /// Parameter subtitle: subtitulo a mostrar
    /// Parameter totalPay: total a pagar
    /// Parameter date: mostrar fecha
    func interfaceTodoClaroView(namePlan: String, subtitle: String, totalPay: String, date: String) {
        imgHeader.image = UIImage(named: "ico_seccion_mc_todoclaro")
        lblTitleHeader.text = namePlan
        lblTitleHeader.adjustHeighToFit()
        let accountNumText = conf?.translations?.data?.billing?.accountId ?? "No. de cuenta:"
        lblSubtitleHeader.text = "\(accountNumText) \(subtitle)"
        //lblTotalPay.text = NSLocalizedString("totalToPay", comment: "")
        //lblTotalPayDesc.text = "$ \(totalPay)"
        shouldAddWarning(textPay: NSLocalizedString("totalToPay", comment: ""), totalPay: totalPay)
        let myDate = convertStringToDateO(stringDate: date)
        let tmpDate = getFullStringDate(date: myDate)
        let beforeText = conf?.translations?.data?.generales?.paidBefore ?? "Antes del"
        lblDateToPay.text = "\(beforeText) \(tmpDate)"
        setupTotalLabelAlignment()
        
        if let payBill = SessionSingleton.sharedInstance.getGeneralConfig()?.translations?.data?.generales?.payBill {
            btnPayBoleta.setTitle("\(payBill)", for: .normal)
        } else {
            btnPayBoleta.setTitle("Pagar Boleta", for: .normal)
        }
        
        buttonColorBy(total: totalPay, button: btnPayBoleta)
        self.adjustConstraintTo(true, bottom: true)
    }
    /// Actualizar la información para la card de Televisión
    /// Parameter namePlan: Nombre del plan a mostrar
    /// Parameter subtitle: subtitulo a mostrar
    /// Parameter totalPay: total a pagar
    /// Parameter date: mostrar fecha
    func interfaceTelevisionView(namePlan: String, subtitle: String, totalPay: String, date: String) {
        imgHeader.image = UIImage(named: "ico_seccion_mc_tv")
        lblTitleHeader.text = namePlan
        lblTitleHeader.adjustHeighToFit()
        let accountNumText = conf?.translations?.data?.billing?.accountId ?? "No. de cuenta:"
        lblSubtitleHeader.text = "\(accountNumText) \(subtitle)"
        //lblTotalPay.text = NSLocalizedString("totalToPay", comment: "")
        //lblTotalPayDesc.text = "$ \(totalPay)"
        shouldAddWarning(textPay: NSLocalizedString("totalToPay", comment: ""), totalPay: totalPay)
        let myDate = convertStringToDateO(stringDate: date)
        let tmpDate = getFullStringDate(date: myDate)
        let beforeText = conf?.translations?.data?.generales?.paidBefore ?? "Antes del"
        lblDateToPay.text = "\(beforeText) \(tmpDate)"
        setupTotalLabelAlignment()
        if let payBill = SessionSingleton.sharedInstance.getGeneralConfig()?.translations?.data?.generales?.payBill {
            btnPayBoleta.setTitle("\(payBill)", for: .normal)
        } else {
            btnPayBoleta.setTitle("Pagar Boleta", for: .normal)
        }
        //btnPayBoleta.setTitle("Pagar Boleta", for: .normal)
        buttonColorBy(total: totalPay, button: btnPayBoleta)
        self.adjustConstraintTo(true, bottom: true)
    }
    /// Actualizar la información para la card de Internet
    /// Parameter namePlan: Nombre del plan a mostrar
    /// Parameter subtitle: subtitulo a mostrar
    /// Parameter totalPay: total a pagar
    /// Parameter date: mostrar fecha
    func interfaceInternetView(namePlan: String, subtitle: String, totalPay: String, date: String) {
        imgHeader.image = UIImage(named: "ico_seccion_mc_internet")
        lblTitleHeader.text = namePlan
        lblTitleHeader.adjustHeighToFit()
        let accountNumText = conf?.translations?.data?.generales?.accountNumber ?? "No. de cuenta:"
        lblSubtitleHeader.text = "\(accountNumText) \(subtitle)"
        //lblTotalPay.text = NSLocalizedString("totalToPay", comment: "")
        //lblTotalPayDesc.text = "$ \(totalPay)"
        shouldAddWarning(textPay: NSLocalizedString("totalToPay", comment: ""), totalPay: totalPay)
        setupTotalLabelAlignment()
        let myDate = convertStringToDateO(stringDate: date)
        let tmpDate = getFullStringDate(date: myDate)
        let beforeText = conf?.translations?.data?.generales?.paidBefore ?? "Antes del"
        lblDateToPay.text = "\(beforeText) \(tmpDate)"
        
        if let payBill = SessionSingleton.sharedInstance.getGeneralConfig()?.translations?.data?.generales?.payBill {
            btnPayBoleta.setTitle("\(payBill)", for: .normal)
        } else {
            btnPayBoleta.setTitle("Pagar Boleta", for: .normal)
        }
        //btnPayBoleta.setTitle("Pagar Boleta", for: .normal)
        buttonColorBy(total: totalPay, button: btnPayBoleta)
        //self.adjustConstraintHeaderTitle()
        self.adjustConstraintTo(true, bottom: true)
    }
    /// Ajustar los constraint de los elementos visuales de las cards.
    func adjustConstraintTo(_ header : Bool, bottom : Bool = false) {
        
        if header {
            lblTitleHeader.sizeToFit()
            constrain(self, imgHeader, lblTitleHeader) { (view, img, title) in
                if self.typeCard != TypeCardView.Resumen {
                    img.centerX == view.centerX
                    img.top == view.top
                    title.centerX == view.centerX
                    title.top == img.bottom


                    title.height == view.height * 0.17
                } else {
                    img.centerY == title.centerY
                    img.trailing == title.leading - 5.0
                    title.centerX == view.centerX
                    title.top == view.top + 16.0


                    let adjustNeeded = lblTitleHeader.needAdjustLabel()
                    if adjustNeeded.needs {
                        title.height == adjustNeeded.newHeight
                        updateHeightView(newHeight: self.frame.maxY/* + 10*/)
                    } else {
                        title.height >= 30
                    }
                }
                title.width == view.width * (4.5 / 7)
            }
            
            lblTitleHeader.addSubview(viewUnderline)
            constrain(lblTitleHeader, viewUnderline, self) { (title, underline, view) in
                underline.top == title.bottom + 16
                underline.centerX == view.centerX
                underline.height == 1
                underline.width == title.width / 2
            }
            
            constrain(viewUnderline, lblSubtitleHeader, self) { (underline, subtitle, view) in
                subtitle.height == 20
                subtitle.top == underline.bottom + 20
                subtitle.centerX == underline.centerX
                subtitle.leading == view.leading + 10
                subtitle.trailing == view.trailing - 10
            }
        }
        if bottom {
            constrain(lblSubtitleHeader, totalContainer, lblDateToPay, self) { (sub, total , date, view) in
                total.top == sub.bottom + 10
                total.leading == view.leading
                total.trailing == view.trailing
                total.height == 20
                date.top == total.bottom + 10
                //
                if self.showMessageMovilPlan {
                    date.height == 40.0
                }
                
                //
                date.leading == view.leading + 10
                date.trailing == view.trailing - 10
            }
            constrain(btnPayBoleta, lblDateToPay , self ) { (btnBoleta, date, view) in
                btnBoleta.top == date.bottom + 20
                btnBoleta.leading == view.leading + 10
                btnBoleta.trailing == view.trailing - 10
                btnBoleta.height == 40
                //btnBoleta.bottom == view.bottom - 10
            }
            
            if let _ = btnCustomTitle {
                constrain(btnCustomTitle!, btnPayBoleta , self ) { (btnTitle, btnBoleta, view) in
                    btnTitle.top == btnBoleta.bottom + 16
                    btnTitle.leading == view.leading + 10
                    btnTitle.trailing == view.trailing - 10
                    btnTitle.centerX == view.centerX
                }
            }
            if let maxY = btnCustomTitle?.frame.maxY {
                print("MAXY : \(heightContentView) )")
                updateHeightView(newHeight: maxY + 180)
                print("MAXY : \(heightContentView) )")
            }
        }
    }
    
    //MARK: Get the information for cards
    /// Obtener información para la card de resumen
    func getNamePlanResume() {
        var totalPay: Float = 0.0
        
        //Get the names of plans and date for pay
        for plan in self.accountDataArray {
            let total = plan.detailServices?.detailPlan?.count ?? 0;
            for idx in 0 ..< total{
                if idx >= plan.detailServices?.accountDetail?.plan?.count ?? 0 {
                    continue;
                }
                //Obtenemos el LOB de cada cuenta
                let lob = plan.account?.lineOfBusiness
            
                //No se debe sumar las cuentas prepago si existen cuentas de post pago
                if self.typeAccount == TypeAccounts.PostpagoAndPrepago && lob == "2" {
                    continue
                }

                let detailAccountPlan = plan.detailServices?.accountDetail?.plan?[safe: idx]
                let planName = detailAccountPlan?.planName ?? ""

                if let billArray = plan.detailServices?.detailPlan?[safe: idx]?.retrieveBillDetailsResponse?.billItem {
                    if (0 == billArray.count) {
                        let planAmount = " $ 0"
                        let info = (planName, planAmount)
                        self.arrayServiceDescription.append(info)
                    } else {
                        for bill in billArray {
                            if bill.descriptionType == "3" {
                                let planAmount = formatToCountryCurrency(strMonto: bill.amountFormat ?? "0")
                                let info = (planName, planAmount)
                                self.arrayServiceDescription.append(info)
                                let f = NSString(string: (bill.amountFormat ?? "0").digitsOnly);
                                totalPay = totalPay + f.floatValue
                            }
                        }
                    }
                } else {
                    let planAmount = " $ 0"
                    let info = (planName, planAmount)
                    self.arrayServiceDescription.append(info)
                }
            }
            
        }

        if false == SessionSingleton.sharedInstance.isConsumingService() {
            //Show names of plans in interface
            self.addMiddleView()
        }
        
        //Get the total pay
        //        var totalPay: Float = 0.0
        //        for pay in self.accountDataArray {
        //            //Obtenemos el LOB de cada cuenta
        //            let lob = pay.account?.lineOfBusiness
        //            //No se debe sumar las cuentas prepago si existen cuentas de post pago
        //            if self.typeAccount == TypeAccounts.PostpagoAndPrepago && lob == "3" {
        //                continue
        //            }
        //
        //            if let billArray = pay.detailServices?.detailPlan?.first?.retrieveBillDetailsResponse?.billItem {
        //                for bill in billArray {
        //                    if bill.descriptionType == "3" {
        //                        totalPay = totalPay + (bill.amountFormat! as NSString).floatValue
        //                    }
        //                }
        //            }
        //        }
        
        //Get date for pay
        var dateToPay: String = ""
        for plan in self.accountDataArray {
            for detailPlan in (plan.detailServices?.detailPlan)! {
                dateToPay = detailPlan.retrieveBillDetailsResponse?.dueDate ?? ""
            }
        }

        lblTotalPay = BlackBodyLabel()
        lblTotalPayDesc = BlackTitleLabel()
        if false == SessionSingleton.sharedInstance.isConsumingService() {
            self.addBottomView(false)
        }
        
        self.interfaceResumeView(dateToPay: dateToPay, totalPay: totalPay)
    }
    
    /// Obtener información para la card de movil
    func getInformationMovil() {
        //Identify if the account is Prepgo or post pago
        let lob = self.accountData?.account?.lineOfBusiness
        
        //        let accountAux = self.accountDataArray[self.indexAccount]
        let associateService: AssociatedService = (self.accountData?.detailServices?.associatedService![self.indexService])!
        let subtitleCard: String = associateService.serviceID!
        
        let detailPlan: DetailPlan? = self.accountData?.detailServices?.detailPlan?[safe: indexService] //[self.indexService])!
        
        let namePlan: String = self.accountData?.detail?.accountDetails?.plan?[safe: indexService]?.planName ?? ""
        //(detailPlan.retrievePlanResponse?.plan?.planName)!
        var totalToPay: String = ""
        
        if let bi = detailPlan?.retrieveBillDetailsResponse?.billItem {
            for bill in bi {
                if bill.descriptionType == "3" {
                    totalToPay = bill.amountFormat ?? ""
                }
            }
        }
        
        var messageVigencia = ""
        
        if ((detailPlan?.retrieveBillDetailsResponse?.prepaidStatusInfo) != nil) {
            let tmpDate = detailPlan?.retrieveBillDetailsResponse?.prepaidStatusInfo
            let zb1 = tmpDate?.zB1EndDate
            let zb2 = tmpDate?.zB2EndDate
            
            let now = Date()
            let nowTmp = getStringDateTime2(date: now)
            let days = substractDaysDates(date1: zb1!, date2: nowTmp)
            
            if days <= 5 {
                messageVigencia = (conf?.translations?.data?.mensajeVigencia![0].text)!
                messageVigencia = messageVigencia.replacingOccurrences(of: "%s", with: "\(days)")
//                messageVigencia = "Quedan 05 días para que expire tu saldo\n Recuerda recargar para mantener tu servicio activo."
            }else if days > 5 {
//                messageVigencia = (conf?.translations?.data?.mensajeVigencia![0].text)!
//                messageVigencia = messageVigencia.replacingOccurrences(of: "%s", with: "\(days)")
//                messageVigencia = "Quedan 05 días para que expire tu saldo\n Recuerda recargar para mantener tu servicio activo."
            }else {
                let daysAux = substractDaysDates(date1: zb1!/*nowTmp*/, date2: zb2!/*zb1!*/)
                if daysAux > 0 {
                    messageVigencia = (conf?.translations?.data?.mensajeVigencia![1].text)!
                    /*let daysTmp = substractDaysDates(date1: nowTmp, date2: zb2!)
                    if daysTmp > 0 {
                        messageVigencia = "Tu saldo esta expirado."
                    }*/
                }else {
                    messageVigencia = (conf?.translations?.data?.mensajeVigencia![2].text)!
                    /*let daysNow = substractDaysDates(date1: nowTmp, date2: zb2!)
                    if daysNow > 0 {
                        messageVigencia = "Tu saldo esta inactivo"
                    }*/
                }
            }
            
        }
        
        let date = detailPlan?.retrieveBillDetailsResponse?.dueDate ?? ""
        
        self.addBottomView(true)
        self.interfaceMovilView(namePlan: namePlan,subtitle: subtitleCard, totalPay: totalToPay, date: date, lob: lob!, messageReload: messageVigencia)
    }
    /// Obtener información para la card de Todo claro
    func getInformationTodoClaro() {
        //        let accountDetail: AssociatedService = (self.accountData?.detailServices?.associatedService![self.indexService])!
        let subtitleCard: String = (self.accountData?.detailServices?.accountDetail?.accountId)! //associateService.serviceID!
        
        let detailPlan: DetailPlan? = self.accountData?.detailServices?.detailPlan?[safe: self.indexService]
        
        let namePlan: String = self.accountData?.detail?.accountDetails?.plan?.first?.planName ?? "";
        var totalToPay: String = ""
        if let bi = detailPlan?.retrieveBillDetailsResponse?.billItem {
            for bill in bi {
                if bill.descriptionType == "3" {
                    totalToPay = bill.amountFormat!
                }
            }
        }
        
        let date = detailPlan?.retrieveBillDetailsResponse?.dueDate ?? ""
        
        self.addBottomView(true)
        self.interfaceTodoClaroView(namePlan: namePlan,subtitle: subtitleCard, totalPay: totalToPay, date: date)
    }
    /// Obtener información para la card de Televisión
    func getInformationTelevision() {
        //        let associateService: AssociatedService = (self.accountData?.detailServices?.associatedService![self.indexService])!
        let subtitleCard: String = self.accountData?.detailServices?.accountDetail?.accountId ?? "" // associateService.serviceID!
        
        let detailPlan: DetailPlan? = self.accountData?.detailServices?.detailPlan?.first //[self.indexService])!
        
        let namePlan: String = self.accountData?.detail?.accountDetails?.plan?.first?.planName ?? ""
        //(detailPlan.retrievePlanResponse?.plan?.planName)!
        var totalToPay: String = ""
        
        if let bi = detailPlan?.retrieveBillDetailsResponse?.billItem {
            for bill in bi {
                if bill.descriptionType == "3" {
                    totalToPay = bill.amountFormat!
                }
            }
        }
        
        let date = detailPlan?.retrieveBillDetailsResponse?.dueDate ?? ""
        
        self.addBottomView(true)
        self.interfaceTelevisionView(namePlan: namePlan,subtitle: subtitleCard, totalPay: totalToPay, date: date)
    }
    /// Obtener información para la card de Internet
    func getInformationInternet() {
//        let associateService: AssociatedService = (self.accountData?.detailServices?.associatedService![self.indexService])!
        let subtitleCard: String = (self.accountData?.account?.accountId)!//VALIDATE THIS INFO associateService.serviceID!
        
        let detailPlan: DetailPlan? = self.accountData?.detailServices?.detailPlan?.first //[self.indexService])!
        
        let namePlan: String = self.accountData?.detail?.accountDetails?.plan?.first?.planName ?? ""
        //(detailPlan.retrievePlanResponse?.plan?.planName)!
        var totalToPay: String = ""
        
        if let bi = detailPlan?.retrieveBillDetailsResponse?.billItem {
            for bill in bi {
                if bill.descriptionType == "3" {
                    totalToPay = bill.amountFormat!
                }
            }
        }
        
        let date = detailPlan?.retrieveBillDetailsResponse?.dueDate ?? ""
        
        self.addBottomView(true)
        self.interfaceInternetView(namePlan: namePlan,subtitle: subtitleCard, totalPay: totalToPay, date: date)
    }
    /// Obtener index del encabezado de la card
    func getIndexHeaderCard() -> Int {
        let tagTmp = self.tag + 1
        let tag = self.tag
        let valueInit = 2
        
        return (tagTmp * valueInit - tag) / 2
    }
    
    //MARK: Button action
    /// Detectar la acción del usuario para mostrar un web view
    func btnRedTouchInside() {
        if false == SessionSingleton.sharedInstance.isNetworkConnected() {
            NotificationCenter.default.post(name: Observers.ObserverList.ShowOfflineMessage.name, object: nil);
            return;
        }
        switch self.typeCard {
        case .Resumen:
            var webId = "billingPayment"
            if self.typeAccount == TypeAccounts.Prepago {
                webId = "reload"
            }
            self.delegate?.btnRedAction(webId: webId)
            break
        case .Móvil:
            var webId = "billingPayment"
            
            if (self.accountData?.account?.lineOfBusiness)! == "2" {//Is prepago and the action is Reload
                webId = "reload"
            }
            self.delegate?.btnRedAction(webId: webId)
            break
        case .Internet:
            var webId = "billingPayment"
            
            if (self.accountData?.account?.lineOfBusiness)! == "2" {//Is prepago and the action is Reload
                webId = "reload"
            }
            self.delegate?.btnRedAction(webId: webId)
            break
        case .Televisión:
            var webId = "billingPayment"
            
            if (self.accountData?.account?.lineOfBusiness)! == "2" {//Is prepago and the action is Reload
                webId = "reload"
            }
            self.delegate?.btnRedAction(webId: webId)
            break
        case .Teléfono:
            var webId = "billingPayment"
            
            if (self.accountData?.account?.lineOfBusiness)! == "2" {//Is prepago and the action is Reload
                webId = "reload"
            }
            self.delegate?.btnRedAction(webId: webId)
            break;
        case .TodoClaro:
            var webId = "billingPayment"
            
            if (self.accountData?.account?.lineOfBusiness)! == "2" {//Is prepago and the action is Reload
                webId = "reload"
            }
            self.delegate?.btnRedAction(webId: webId)
            break
        default:
            break
        }
    }
    /// Mostrar la opción de boleta
    func btnShowBoleta() {
        let indexCard = self.getIndexHeaderCard()
        self.delegate?.btnShowBoleta(indexCard: indexCard, typeCard: self.typeCard)
    }
    /// Obtener el id de una cuenta
    /// return String: Id de la cuenta
    func getAccount() -> String? {
        return accountData?.account?.accountId
    }
}

