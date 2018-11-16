//
//  CardDetailDataGraphic.swift
//  MiClaro
//
//  Created by Jonathan Abimael Cruz Orozco on 25/06/18.
//  Copyright © 2018 am. All rights reserved.
//

import UIKit

protocol CardDetailDataGraphicDelegate: class {
    func showDescriptionPlan(messageDescriptionPlan: String)
}

class CardDetailDataGraphic: UIView {

    /*********************** Constantes ***********************/
    private let MBUnit: Float = 1024
    let textConfiguration = SessionSingleton.sharedInstance.getGeneralConfig()
    /*********************** Constantes ***********************/
    
    /*********************** Variables ***********************/
    private var textPaidBeforePre: String = ""
    private var textUsed: String = ""
    private var textAvailable: String = ""
    private var textFree: String = ""
    private var isMinsInternational: Bool = false
    /*********************** Variables ***********************/
    
    /*********************** Componentes de la interfaz ***********************/
    @IBOutlet weak var imgService: UIImageView!
    @IBOutlet weak var lblNameService: UILabel!
    @IBOutlet weak var lblDataUse: UILabel!
    @IBOutlet weak var lblDateFinish: UILabel!
    @IBOutlet weak var viewContentGraphic: UIView!
    @IBOutlet weak var viewContentImageRS: UIView!
    
    private var btnTool: UIButton!
    /*********************** Componentes de la interfaz ***********************/
    
    var viewParent: UIView!
    var delegate: CardDetailDataGraphicDelegate?
    private var messageDescriptionPlan: String = ""
    static let IS_IPHONE_5 = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 568.0

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.instanceFromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.instanceFromNib()
    }
    
    private func instanceFromNib() {
        if let customView = Bundle.main.loadNibNamed("CardDetailDataGraphic", owner: self, options: nil)?.first as? UIView {
            viewParent = customView
            viewParent.frame = self.bounds
            viewParent.autoresizingMask = [.flexibleHeight, .flexibleWidth]
            addSubview(viewParent)
            
            self.setTextUI()
        }
    }
    
    private func setTextUI() {
        self.textPaidBeforePre = textConfiguration?.translations?.data?.generales?.paidBeforePre ?? ""
        self.textUsed = textConfiguration?.translations?.data?.generales?.used ?? ""
        self.textAvailable = textConfiguration?.translations?.data?.generales?.available ?? ""
        self.textFree = textConfiguration?.translations?.data?.generales?.free ?? ""
    }
    
    func getHeightView() -> CGFloat {
        return self.bounds.height
    }
    
    func setDataGraphic(data: DataGraphicCard) {
        self.lblDateFinish.text = NSString(format: "%@ %@",self.textPaidBeforePre, data.dateFinish) as String
        if data.existRRSS {
            self.lblNameService.text = "RRSS"
            self.addImageSocialNetwork(arraySocialNet: data.arraySocialNetwork)
        }else {
            self.lblNameService.text = data.serviceFeatureType//self.getNameTypeService(typeService: data.usageLimitUnit.uppercased())
            if data.has3country {
                self.isMinsInternational = true
                let flags = textConfiguration?.consumptionInternationalFlags?.threeCountries ?? nil
                self.addImageFlagsCountries(flags: flags)
            }else if data.has8country {
                self.isMinsInternational = true
                let flags = textConfiguration?.consumptionInternationalFlags?.eightCountries ?? nil
                self.addImageFlagsCountries(flags: flags)
            }
        }
        
        self.lblDataUse.text = self.getDataConsuming(data: data)
        self.lblDataUse.adjustsFontSizeToFitWidth = true
        let nameImg = self.getNameImageService(typeService: data.usageLimitUnit.uppercased())
        self.imgService.image = UIImage(named: nameImg)
    }
    
    func createCircleGraphic(data: DataGraphicCard) {
        //Calculamo el porcentaje de consumo
        var limitPlan = (data.usageLimit as NSString).floatValue
        var planUse = (data.consumingUser as NSString).floatValue
        var consuming = ""
        
        switch data.typeCard {
        case -1,-3:
        
            break
        case 0:
      
            break
        default:
            limitPlan = Float(data.typeCard)
            planUse = limitPlan - Float(data.usageLimit)!
        }
        
        // Asumimos que la información que proporcionan son GB y MB
        if data.usageLimitUnit != data.consumingUserUnit {
            limitPlan = limitPlan * 1024
        }
        var percent = 0.0
        if limitPlan > 0 {
            percent = Double(planUse * Float(100.0) / limitPlan)
            consuming = NSString(format: "%.1f %%", percent) as String
            if percent == 0.0 {
                consuming = NSString(format: "%.0f %%", percent) as String
            }
        }else {
            consuming = "0 %"
            percent = 0.0
        }
        
        let viewGraphic = UIView(frame: CGRect(x: 0, y: 0, width: self.viewContentGraphic.bounds.width, height: self.viewContentGraphic.bounds.height))
        let size = CGSize(width: 1.0, height: 10.0)
        //Colores de la grafica
        let kFillColor = UIColor(red: 38.0/255.0, green: 186.0/255.0, blue: 203.0/255.0, alpha: 1.0)
        /*let kBlueBackFirstColor = UIColor(red: 154.0/255.0, green: 222.0/255.0, blue: 231.0/255.0, alpha: 1.0)
        let kLightBlueGreenBackSecondsColor = UIColor(red: 167.0/255.0, green: 228.0/255.0, blue: 229.0/255.0, alpha: 1.0)
        let kLightGreenBackThirdColor = UIColor(red: 176.0/255.0, green: 234.0/255.0, blue: 209.0/255.0, alpha: 1.0)
        let kLightDarkGreenBackFourthColor = UIColor(red: 200.0/255.0, green: 241.0/255.0, blue: 186.0/255.0, alpha: 1.0)
        let kDarkGreenBackFifthColor = UIColor(red: 209.0/255.0, green: 244.0/255.0, blue: 188.0/255.0, alpha: 1.0)*/
        
        let kGrayColor = UIColor(red: 226/255, green: 226/255, blue: 226/255, alpha: 1.0)
        let kColors : [CGColor] = [kGrayColor.cgColor, kGrayColor.cgColor, kGrayColor.cgColor, kGrayColor.cgColor, kGrayColor.cgColor]
        viewGraphic.addProgressCircleAnimation(lineSize: size, value: CGFloat(percent) / 100.0, fillColor: kFillColor, backgroundLineColor: UIColor.lightGray, colorsGradient: kColors, containtsLabel: true, labelText : consuming, labelColor : kFillColor, subtitleText: self.textUsed, subtitleColor : institutionalColors.claroBlueColor)
        self.viewContentGraphic.addSubview(viewGraphic)
    }
    
    /// Obtener el icono de la imagen a mostrar para el tipo de servicio
    /// Parameter typeService: Tipo de servicio a buscar
    /// Return: nombre de la imagen a mostrar
    private func getNameImageService(typeService: String) -> String {
        var nameImage: String = ""
        switch typeService {
        case "MB", "GB":
            nameImage = "ic_detalle_internet"
            break
        case "SMS":
            nameImage = "ic_detalle_msn"
            break
        case "MINS":
            nameImage = "ic_detalle_minutos"
            if self.isMinsInternational {
                nameImage = "ic_detalle_mins_internacional"
            }
            break
        default:
            break
        }
        
        return nameImage
    }
    
    /// Obtener las imagenes a mostrar de redes sociales
    private func addImageSocialNetwork(arraySocialNet: [TypeSocialNetwork]) {
        var posX: CGFloat = 10.0
        let posY: CGFloat = 5.0
        let widthImg: CGFloat = 15//self.viewContentImageRS.bounds.width / 12.0
        let heightImg: CGFloat = widthImg
            
        for social in arraySocialNet {
            let img = UIImageView(frame: CGRect(x: posX, y: posY, width: widthImg, height: heightImg))
            let nameImg = self.getNameImageSocial(typeSocial: social)
            img.contentMode = .scaleAspectFit
            img.image = UIImage(named: nameImg)
                
            posX = posX + widthImg + 3
                
            self.viewContentImageRS.addSubview(img)
        }
    }
    
    /// Obtener el nombre del tipo de servicio
    /// Parameter typeService: Tipo de servicio a buscar
    /// Return: nombre del tipo de servicio a mostrar
    /*private func getNameTypeService(typeService: String) -> String {
        var nameServices: String = ""
        switch typeService {
        case "MB", "GB":
            nameServices = "Datos"
            break
        case "SMS":
            nameServices = "SMS"
            break
        case "MINS":
            nameServices = "MINS"
            break
        default:
            break
        }
        
        return nameServices
    }*/
    
    /// Obtener las banderas de los diferentes paises
    private func getDataFromUrl(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            completion(data, response, error)
            }.resume()
    }
    
    private func downloadImage(urlImage: String, imageContent: UIImageView) {
        let remoteImageURL = URL(string: urlImage)!
        print("Download Started")
        getDataFromUrl(url: remoteImageURL) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? remoteImageURL.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() {
                imageContent.image = UIImage(data: data)
                //print("Size Image \(String(describing: self.imgPromotion.image?.size))")
                
            }
        }
    }
    
    private func addImageFlagsCountries(flags: [FlagsCountry]?) {
        var posX: CGFloat = 10.0
        let posY: CGFloat = 5.0
        let widthImg: CGFloat = 20//self.viewContentImageRS.bounds.width / 12.0
        let heightImg: CGFloat = widthImg
        if flags != nil {
            for flag in flags! {
                let img = UIImageView(frame: CGRect(x: posX, y: posY, width: widthImg, height: heightImg))
                img.contentMode = .scaleAspectFit
                self.downloadImage(urlImage: flag.flag ?? "", imageContent: img)
                
                posX = posX + widthImg + 3
                
                self.viewContentImageRS.addSubview(img)
            }
        }
        
    }
    
    /// Obtener el tipo de plan contratado
    private func getDataConsuming(data: DataGraphicCard) -> String {
        let limitUsage: Float = NSString(format: "%d ", data.typeCard).floatValue
        var dataConsuming: String = ""
        
        if limitUsage == -1 {//PLAN ILIMITADO
            self.getMessageDescriptionPlan(data: data, typePlan: "ilimitado")
            //Identificar la unidad del tipo de servicio
            let consuming = self.dataConsumingUserIlimitado(data: data)
            dataConsuming = consuming + " " + self.textUsed
            if !data.has3country && !data.has8country {
                self.createViewPlanIlimitado()
            }
        }else if limitUsage == -3 {//PLAN LIBRE
            self.getMessageDescriptionPlan(data: data, typePlan: "libres")
            let consuming = self.dataConsumingUserIlimitado(data: data)
            dataConsuming = consuming + " " + self.textUsed
            if !data.has3country && !data.has8country {
                self.createViewPlanLibre()
            }
        }else {
            let consuming = self.dataConsumingUserGraphic(data: data)
            dataConsuming = consuming + " " + self.textAvailable
            if !data.has3country && !data.has8country {
                if(data.serviceBusinessType == "POS"){
                    self.createCircleGraphic(data: data)
                }
            }
        }
        
        return dataConsuming
    }
    
    private func dataConsumingUserGraphic(data: DataGraphicCard) -> String {
        let limitUsage = NSString(format: "%@", data.usageLimit).floatValue
        let userConsuming = NSString(format: "%@", data.consumingUser).floatValue
        var rest : Float = 0.0
        switch data.typeCard {
        case -1,-3:
            rest = userConsuming
            break
        case 0:
            rest = userConsuming
            break
        default:
            rest = limitUsage
        }
        let unitService = data.usageLimitUnit.uppercased()
        var consumingUser: String = ""
        
        switch unitService {
        case "MB":
            consumingUser = self.convertMBtoGB(data: rest, unit: data.usageLimitUnit)
            break
        case "GB":
            let unitUserService = data.consumingUserUnit.uppercased()
            if unitService != unitUserService {//En este caso el plan esta en GB y el consumo del usuario esta en MB
                let result = self.restGBtoMB(valueGB: limitUsage, valueMB: userConsuming)
                consumingUser = self.convertMBtoGB(data: result, unit: data.usageLimitUnit)
            }else {
                consumingUser = self.formatGB(data: rest, unit: unitService)//self.convertMBtoGB(data: rest * self.MBUnit/*limitUsage * self.MBUnit*/, unit: data.usageLimitUnit)
            }
            break
        case "MINS":
            consumingUser = NSString(format: "%.0f MINS", rest) as String
            break
        case "SMS":
            consumingUser = NSString(format: "%.0f SMS", rest) as String
            break
        default:
            break
        }
        
        return consumingUser
    }
    
    private func getMessageDescriptionPlan(data: DataGraphicCard, typePlan: String) {
        let unitService = data.usageLimitUnit.uppercased()
        var typePlanUser: String = ""
        var descriptionMessagePlan: String = ""
        
        switch unitService {
        case "MB", "GB":
            if data.existRRSS {
                typePlanUser = "rrssIlimitados"
            }else if typePlan == "ilimitado" {
                typePlanUser = "datosIlimitados"
            }else if typePlan == "libres" {
                typePlanUser = "datosLibres"
            }
            break
        case "MINS":
            if typePlan == "ilimitado" {
                typePlanUser = "minutosIlimitados"
            }else if typePlan == "libres" {
                typePlanUser = "minutosLibres"
            }
            break
        case "SMS":
            if typePlan == "ilimitado" {
                typePlanUser = "smsIlimitados"
            }else if typePlan == "libres" {
                typePlanUser = "smsLibres"
            }
            break
        case "RRSS":
            if typePlan == "ilimitado" {
                typePlanUser = "rrssIlimitados"
            }else if typePlan == "libres" {
                typePlanUser = "rrssLibres"
            }
            break
        default:
            break
        }
        let conf = SessionSingleton.sharedInstance.getGeneralConfig()
        for text in (conf?.translations?.data?.tooltips)! {
            if text.typeServices == typePlanUser {
                descriptionMessagePlan = text.text!
            }
        }
        
        self.messageDescriptionPlan = descriptionMessagePlan
    }
    
    private func dataConsumingUserIlimitado(data: DataGraphicCard) -> String {
        let userConsuming: Float = NSString(format: "%@", data.consumingUser).floatValue
        let unitService = data.consumingUserUnit.uppercased()//data.usageLimitUnit.uppercased()
        var consumingUser: String = ""
        
        switch unitService {
        case "MB":
            consumingUser = self.convertMBtoGB(data: userConsuming, unit: unitService/*data.usageLimitUnit*/)
            break
        case "GB":
            consumingUser = self.convertMBtoGB(data: userConsuming * self.MBUnit, unit: unitService/*data.usageLimitUnit*/)
            /*let unitUserService = data.consumingUserUnit.uppercased()
            if unitService != unitUserService {//En este caso el plan esta en GB y el consumo del usuario esta en MB
                let result = self.restGBtoMB(valueGB: userConsuming, valueMB: userConsuming)
                consumingUser = self.convertMBtoGB(data: result, unit: data.usageLimitUnit)
            }else {
                consumingUser = self.convertMBtoGB(data: userConsuming * self.MBUnit, unit: data.usageLimitUnit)
            }*/
            break
        case "MINS":
            consumingUser = NSString(format: "%.0f MINS", userConsuming) as String
            break
        case "SMS":
            consumingUser = NSString(format: "%.0f SMS", userConsuming) as String
            break
        default:
            break
        }
        
        return consumingUser
    }
    
    private func formatGB(data: Float, unit: String) -> String {
        return NSString(format:"%.2f %@",data,unit) as String
    }
    
    private func convertMBtoGB(data: Float, unit: String) -> String {
        var data = data
        var unitType = unit
        if data > self.MBUnit {
            data = data / self.MBUnit
            unitType = "GB"
        }else {
            unitType = "MB"
        }
        
        if unitType == "MB" {
            return NSString(format:"%.0f %@",data,unitType) as String
        }else {
            if Int(data * self.MBUnit) % Int(self.MBUnit) == 0 {
                return NSString(format:"%.0f %@",data,unitType) as String
            }
            return NSString(format:"%.2f %@",data,unitType) as String
        }
    }
    
    private func restGBtoMB(valueGB: Float, valueMB: Float) -> Float {
        let convertMB = valueGB * 1024
        if valueMB != 0 {
            return convertMB - valueMB//valueGB
        }
        
        return convertMB
    }
    
    func getNameImageSocial(typeSocial: TypeSocialNetwork) -> String {
        var nameImage: String = ""
        switch typeSocial {
        case .Facebook:
            nameImage = "facebook"
            break
        case .Twitter:
            nameImage = "twitter"
            break
        case .Whatsapp:
            nameImage = "whatsapp"
            break
        case .Instagram:
            nameImage = "instagram"
            break
        case .ClaroMusica:
            nameImage = "claromusica"
            break
        case .Snapchat:
            nameImage = "snapchat"
            break
        case .Waze:
            nameImage = "waze"
            break
        case .ColaboraCloud:
            nameImage = "clarocloud"
            break
        case .Gmail:
            nameImage = "gmail"
            break
        case .Hotmail:
            nameImage = "outlook"
            break
        case .Yahoo:
            nameImage = "yahoo"
            break
        case .facebookMessenger:
            nameImage = "facebook"
            break
        }
        
        return nameImage
    }
    
    /// View para mostrar imagen de infinito
    private func createViewPlanIlimitado() {
        let imgInfinity = UIImageView(frame: CGRect(x: 10, y: 10, width: self.viewContentGraphic.frame.width - 20, height: self.viewContentGraphic.frame.height * 0.3))
        imgInfinity.contentMode = .scaleAspectFit
        imgInfinity.image = UIImage(named: "ic_infinito")
        imgInfinity.center.y = self.viewContentGraphic.center.y - 20.0
        self.viewContentGraphic.addSubview(imgInfinity)
        
        let tapToolTip = UITapGestureRecognizer(target: self, action: #selector(toolTipAction))
        let lblInfinity = UILabel(frame: CGRect(x: 0, y: imgInfinity.frame.maxY + 5.0, width: self.viewContentGraphic.frame.width, height: 20.0))
        lblInfinity.font = UIFont(name: RobotoFontName.RobotoRegular.rawValue, size: CGFloat(14.0))
        lblInfinity.textColor = institutionalColors.claroMenuDarkGray
        lblInfinity.text = "ILIMITADO"
        lblInfinity.textAlignment = .center
        lblInfinity.isUserInteractionEnabled = true
        lblInfinity.addGestureRecognizer(tapToolTip)
        self.viewContentGraphic.addSubview(lblInfinity)
        
        /*imgInfinity.isUserInteractionEnabled = true
        imgInfinity.addGestureRecognizer(tapToolTip)

        let btnInfinity = UIButton(frame: CGRect(x: 0, y: imgInfinity.frame.maxY + 5.0, width: self.viewContentGraphic.frame.width, height: 20.0))
        btnInfinity.setTitle("ILIMITADO", for: .normal)
        btnInfinity.setTitleColor(institutionalColors.claroMenuDarkGray, for: .normal)
        btnInfinity.addTarget(self, action: #selector(self.toolTipAction), for: .touchUpInside)
        self.viewContentGraphic.addSubview(btnInfinity)*/
        
        //Agregar tooltip
        let space: CGFloat = CardDetailDataGraphic.IS_IPHONE_5 ? 32.0 : 20.0
        let btnTool = UIButton(frame: CGRect(x: self.viewContentGraphic.frame.width - space, y: lblInfinity.frame.origin.y, width: 20.0, height: 20.0))
        btnTool.center.y = lblInfinity.center.y
        btnTool.addTarget(self, action: #selector(self.toolTipAction), for: .touchUpInside)
        btnTool.titleLabel?.font = UIFont.fontAwesome(ofSize: 18)
        btnTool.setTitle(String.fontAwesomeIcon(name: .questionCircle), for: UIControlState.normal)
        btnTool.setTitleColor(institutionalColors.claroBlueColor, for: .normal)
        self.viewContentGraphic.addSubview(btnTool)
    }
    
    func createViewPlanLibre() {
        let lblLibre = UILabel(frame: CGRect(x: 30, y: 10, width: self.viewContentGraphic.frame.width, height: 25.0))
        lblLibre.font = UIFont(name: RobotoFontName.RobotoRegular.rawValue, size: CGFloat(20.0))
        lblLibre.textColor = institutionalColors.claroBlueColor
        lblLibre.text = self.textFree
        lblLibre.textAlignment = .left
        lblLibre.center.y = self.viewContentGraphic.center.y - 15.0
        self.viewContentGraphic.addSubview(lblLibre)
        
        let tapToolTip = UITapGestureRecognizer(target: self, action: #selector(toolTipAction))
        lblLibre.isUserInteractionEnabled = true
        lblLibre.addGestureRecognizer(tapToolTip)
        
        //Agregar tooltip
        self.btnTool = UIButton(frame: CGRect(x: lblLibre.frame.maxX - 70, y: lblLibre.frame.origin.y, width: 20.0, height: 20.0))
        self.btnTool.center.y = lblLibre.center.y
        self.btnTool.addTarget(self, action: #selector(toolTipAction), for: .touchUpInside)
        self.btnTool.titleLabel?.font = UIFont.fontAwesome(ofSize: 18)
        self.btnTool.setTitle(String.fontAwesomeIcon(name: .questionCircle), for: UIControlState.normal)
        self.btnTool.setTitleColor(institutionalColors.claroBlueColor, for: .normal)
        self.viewContentGraphic.addSubview(btnTool)
    }

    //MARK: Action Tool tip
    func toolTipAction() {
        self.delegate?.showDescriptionPlan(messageDescriptionPlan: self.messageDescriptionPlan)
    }
}
