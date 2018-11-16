//
//  ViewBodyExpand.swift
//  MiClaro
//
//  Created by Jonathan Abimael Cruz Orozco on 27/11/17.
//  Copyright © 2017 am. All rights reserved.
//

import UIKit
import Cartography

/// estructura del cuerpo de la vista expandible
struct ViewBodyExpandData {
    var title: String = ""
    var description: String = ""
    var isTitle: Bool = false
    var socialNetwork: String?
}

protocol ViewBodyExpandDelegate {
    func showAlertSheet(typeServices: String)
}

class ViewBodyExpand: UIView {
    
    var arrayDetail: [ViewBodyExpandData]!
    var arrayWithIDsocial: [TypeSocialNetwork]?
    var btnShowDetail: UIButton!
    private var _tab : [String : Any] = [String : Any]()
    var isExpand: Bool = false
    var typeServices: String = ""
    var delegate: ViewBodyExpandDelegate?
    
    //BORDERS
    private var sides: Sides = Sides.left
    private var borders: [(Sides,CALayer)] = [(Sides,CALayer)]()
    
    /// init
    /// Parameter frame: dimensiones del view expandible
    /// Parameter arrayBody: arreglo con la información a mostrar
    init(frame: CGRect, arrayBody: [ViewBodyExpandData]) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.gray
        self.arrayDetail = arrayBody
        
        showInterfaceView(hiddeBtnDetail: false)
    }
    /// init
    /// Parameter frame: dimensiones del view expandible
    /// Parameter emptyView: inicializar un view en blanco
    init(frame: CGRect, emptyView: Bool, tab : [String : Any] = [String : Any]()) {
        super.init(frame: frame)
        self._tab = tab
        self.backgroundColor = UIColor.white
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /// actualizar la información en el view expand
    /// Parameter arrayBody: arreglo con la información a mostrar
    func setValueBody(arrayBody: [ViewBodyExpandData]) {
        self.arrayDetail = arrayBody
        //        self.showInterfaceView()
    }
    /// crear los elementos visuales en el view expandible
    /// Parameter hiddeBtnDetail: bandera para ocultar el botón de detalles
    func showInterfaceView(hiddeBtnDetail: Bool) {
        var posYLastLabel: CGFloat = 10.0
        let padding: CGFloat = 10.0
        let widthLabel: CGFloat = self.bounds.width / 2 - (padding * 2)
        let heightLabel: CGFloat = 20.0
        
        for index in 0 ..< self.arrayDetail.count {
            let circle = UIView(frame: CGRect(x: padding / 2.0, y: posYLastLabel + heightLabel / 2.0, width: 3.0, height: 3.0))
            circle.backgroundColor = institutionalColors.claroRedColor
            circle.setCircle()
            
            let lblTitle = BlackBodyLabel()
            lblTitle.frame = CGRect(x: padding, y: posYLastLabel, width: widthLabel, height: heightLabel)
            lblTitle.textColor = institutionalColors.claroBlackColor
            //For change the color for title text
            if self.arrayDetail[index].isTitle {
                self.addSubview(circle)
                lblTitle.font = UIFont(name: RobotoFontName.RobotoRegular.rawValue, size: CGFloat(14.0));
            }
            
            lblTitle.text = self.arrayDetail[index].title
            lblTitle.textAlignment = .left
            lblTitle.adjustHeighToFit()
            
            let lblDesc = BlackTitleLabel()
            lblDesc.frame = CGRect(x: (self.bounds.width / 2) + padding, y: posYLastLabel, width: (widthLabel - padding * 2.0), height: heightLabel)
            lblDesc.text = self.arrayDetail[index].description
            //lblDesc.sizeToFit()
            lblDesc.font = UIFont(name: RobotoFontName.RobotoRegular.rawValue, size: CGFloat(12.0));
            lblDesc.numberOfLines = 0
            lblDesc.textAlignment = .right
            lblDesc.textColor = institutionalColors.claroTextColor;
            lblDesc.center.y = lblTitle.center.y
            lblDesc.adjustHeighToFit()
            
            self.addSubview(lblTitle)
            self.addSubview(lblDesc)
            posYLastLabel = posYLastLabel + lblTitle.bounds.height
        }
        
        if !hiddeBtnDetail {
            btnShowDetail = UIButton(frame: CGRect(x: 10.0, y: posYLastLabel + 5.0, width: 0, height: 30.0))
            btnShowDetail.setTitle("Ver detalle >", for: .normal)
            btnShowDetail.titleLabel?.font = UIFont(name: RobotoFontName.RobotoRegular.rawValue, size: CGFloat(14.0));
            btnShowDetail.contentHorizontalAlignment = .left
            btnShowDetail.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            
            btnShowDetail.setTitleColor(institutionalColors.claroBlueColor, for: .normal)
            btnShowDetail.addTarget(self, action: #selector(goToDetail), for: .touchUpInside)
            btnShowDetail.alpha = 0
            self.addSubview(self.btnShowDetail)
            updateHeightView(newHeight: btnShowDetail.frame.maxY)
            btnShowDetail.alpha = 0
            UIView.setAnimationCurve(.easeIn)
            UIView.animate(withDuration: 0.1, delay: 0.8, usingSpringWithDamping: 1.0, initialSpringVelocity: 2.0, options: .curveEaseIn, animations: {
                self.btnShowDetail.frame.size.width =  self.bounds.width - 10.0
                self.btnShowDetail.alpha = 1
            }, completion: nil)
            
            
        }else {
            updateHeightView(newHeight: posYLastLabel)
        }
        
    }
    
    /// Funcion para mostrar la grafica y los valores de cada servicio (Internet, movil, voz, etc)
    func showGraphicMovilData() {
        let heightViewGraphic: CGFloat = 140.0
        self.updateHeightView(newHeight: heightViewGraphic)
//        var hasSocialNetwork: Bool = false
//        var socialNet: [TypeSocialNetwork]?
        
        //Obtenemos la información a mostrar
        /*El primer elemento contiene el limite del plan del usuario y en caso de existir las redes sociales
         *El segundo elemento contiene los datos consumidos por parte del usuario
         *El tercer elemento contiene la fecha de vigencia
         *El cuarto elemento nos dira si son MB, MINS, SMS etc
         */
        
        //Si el valor del primer elemento es -1 el plan es ilimitado, si es -3 es Libre, se debe mostrar la imagen de infinito
        let planLimit = self.arrayDetail[0]
        let planUser = planLimit.title
        let socialNet = planLimit.socialNetwork
        
        if socialNet != nil {
            self.setSocialNetwork(social: socialNet!)
        }
        let planUnit = planLimit.description

        let dataConsumo = self.arrayDetail[1]
        let consumoUnit = dataConsumo.description
        let consumoValue = dataConsumo.title
        let dateConsumo = self.arrayDetail[2]
        let dateTitle = dateConsumo.title
        let dateValue = dateConsumo.description
        let typeService = self.arrayDetail[3]
        var unidadMedida = typeService.description
        
        var titleDataDisponible = "Disponibles"
        
        if planUnit.uppercased() == "MB" || planUnit.uppercased() == "GB" {
            titleDataDisponible = "Datos disponibles"
            if planUser == "-1" || planUser == "-3" {
                titleDataDisponible = "Datos utilizados"
            }
        }else if planUnit.uppercased() == "MINS" {
            if planUser == "-1" || planUser == "-3" {
                titleDataDisponible = "Minutos utilizados"
            }
        }
        
        let padding: CGFloat = 10.0
        let widthGraphic: CGFloat = self.frame.width * 0.5
        let widthLabel: CGFloat = self.frame.width - widthGraphic - padding * 2
        let viewGraphic = UIView(frame: CGRect(x: padding, y: 10.0, width: widthGraphic, height: self.frame.height - 20.0))
        
        //Validamos si es un plan ilimitado
        if planUser == "-1" || planUser == "-1.0" {
            let frameImg = CGRect(x: padding, y: 10.0, width: viewGraphic.frame.width * 0.7, height: viewGraphic.frame.height * 0.6)
            let imgIlimit = UIImageView(frame: frameImg)
            imgIlimit.contentMode = .scaleAspectFit
            imgIlimit.center.x = viewGraphic.center.x
            imgIlimit.image = UIImage(named: "ic_infinito")
            viewGraphic.addSubview(imgIlimit)
            let lblDatosConsumidos = BlackBodyLabel()
            lblDatosConsumidos.adjustsFontSizeToFitWidth = true
            lblDatosConsumidos.textColor = institutionalColors.claroTextColor
            lblDatosConsumidos.textAlignment = .center
            lblDatosConsumidos.text = "Ilimitado"
            lblDatosConsumidos.font = UIFont(name: RobotoFontName.RobotoBold.rawValue, size: CGFloat(20.0))
            lblDatosConsumidos.frame = CGRect(x: padding * 2, y: imgIlimit.frame.maxY, width: viewGraphic.frame.width - padding * 4, height: 20.0)
            lblDatosConsumidos.center.x = imgIlimit.center.x
            viewGraphic.addSubview(lblDatosConsumidos)
            //Agregar tooltip
            let btnTool = UIButton(frame: CGRect(x: lblDatosConsumidos.frame.maxX - 15, y: lblDatosConsumidos.frame.origin.y, width: 30.0, height: 30.0))
            btnTool.center.y = lblDatosConsumidos.center.y
            btnTool.addTarget(self, action: #selector(toolTipAction), for: .touchUpInside)
            //            btnTool.setBackgroundImage(UIImage(named: "twitter"), for: .normal)
            btnTool.titleLabel?.font = UIFont.fontAwesome(ofSize: 25)
            btnTool.setTitle(String.fontAwesomeIcon(name: .exclamationCircle), for: UIControlState.normal)
            btnTool.setTitleColor(institutionalColors.claroBlueColor, for: .normal)
            //            btnTool.action = {creaDialog(titulo: "HOLA")}
            viewGraphic.addSubview(btnTool)
        }else {
            //Calculamo el porcentaje de consumo
            var limitPlan = (planUser as NSString).floatValue
            let planUse = (consumoValue as NSString).floatValue
            var consuming = ""
            
            // Asumimos que la información que proporcionan son GB y MB
            if planUnit != consumoUnit {
                limitPlan = limitPlan * 1000
            }
            
            var percent = 0.0
            if limitPlan > 0 {
                percent = Double(planUse * Float(100.0) / limitPlan)
//                consuming = NSString(format: "%d %%", Int(percent)) as String
                consuming = NSString(format: "%.2f %%", percent) as String
            }else {
                consuming = "0"
                percent = 0.0
            }
            
            let size = CGSize(width: 2.0, height: 10.0)
            //Colores de la grafica
            let kFillColor = UIColor(red: 38.0/255.0, green: 186.0/255.0, blue: 203.0/255.0, alpha: 1.0)
            let kBlueBackFirstColor = UIColor(red: 154.0/255.0, green: 222.0/255.0, blue: 231.0/255.0, alpha: 1.0)
            let kLightBlueGreenBackSecondsColor = UIColor(red: 167.0/255.0, green: 228.0/255.0, blue: 229.0/255.0, alpha: 1.0)
            let kLightGreenBackThirdColor = UIColor(red: 176.0/255.0, green: 234.0/255.0, blue: 209.0/255.0, alpha: 1.0)
            let kLightDarkGreenBackFourthColor = UIColor(red: 200.0/255.0, green: 241.0/255.0, blue: 186.0/255.0, alpha: 1.0)
            let kDarkGreenBackFifthColor = UIColor(red: 209.0/255.0, green: 244.0/255.0, blue: 188.0/255.0, alpha: 1.0)
            let kColors : [CGColor] = [kBlueBackFirstColor.cgColor, kLightBlueGreenBackSecondsColor.cgColor, kLightGreenBackThirdColor.cgColor, kLightDarkGreenBackFourthColor.cgColor, kDarkGreenBackFifthColor.cgColor]
            viewGraphic.addProgressCircleAnimation(lineSize: size, value: CGFloat(percent) / 100.0, fillColor: kFillColor, backgroundLineColor: UIColor.lightGray, colorsGradient: kColors, containtsLabel: true, labelText : consuming, labelColor : kFillColor, subtitleText: "Utilizados", subtitleColor : institutionalColors.claroLightGrayColor)
        }
        
        self.addSubview(viewGraphic)
        
        
        var posYLabelText: CGFloat = 30.0
        
        /***********************IMAGENES DE REDES SOCIALES************************/
        if (self.arrayWithIDsocial != nil) {
            posYLabelText = 40.0
            var posX: CGFloat = viewGraphic.frame.maxX + 5
            var posY: CGFloat = 5.0
            let widthImg: CGFloat = widthLabel / 7.0
            let heightImg: CGFloat = 17.0
            var counter: Int = 0
            
            for social in self.arrayWithIDsocial! {
                if counter % 7 == 6 {
                    posX = viewGraphic.frame.maxX + 5
                    posY = 23.0
                }
                let img = UIImageView(frame: CGRect(x: posX, y: posY, width: widthImg + 1.0, height: heightImg))
                let nameImg = self.getNameImageSocial(typeSocial: social)
                img.contentMode = .scaleAspectFit
                img.image = UIImage(named: nameImg)
                
                posX = posX + widthImg
                
                counter += 1
                
                self.addSubview(img)
            }
        }
        /*************************************************************************/
        
//        let planTmp = (planUser as NSString).floatValue
        
        //Restar el total del servicio de lo consumido por el usuario
        let planLimitValue = (planUser as NSString).floatValue
        let consumingValueUser = (consumoValue as NSString).floatValue
        var dataPlanUserText = ""
        
        if planLimitValue != -1 && planLimitValue != -3 {
            // Se debe validar el formato de los datos consumidos ya sean GB o MB
            var newValueDatadisponible: Float = 0.0
            if planUnit == consumoUnit {
                newValueDatadisponible = planLimitValue - consumingValueUser
            }else {
                //Covertimos a MB, en caso de que sean GB
                newValueDatadisponible = (planLimitValue * 1000) - consumingValueUser
                unidadMedida = consumoUnit
            }
            
            dataPlanUserText = self.getFormatDataConsuming(data: newValueDatadisponible/*planTmp*/, planUnit: unidadMedida)
        }else {
            dataPlanUserText = self.getFormatDataConsuming(data: consumingValueUser/*planTmp*/, planUnit: unidadMedida)
            /*if planLimitValue == -1 {
                dataPlanUserText = "Ilimitado"
            }else if planLimitValue == -3 {
                dataPlanUserText = "Libres"
            } */
        }
        
        
        
        let lblDisponible = BlackBodyLabel()
        lblDisponible.frame = CGRect(x: viewGraphic.frame.maxX + 5, y: posYLabelText, width: widthLabel, height: 20.0)
        lblDisponible.textAlignment = .center
        lblDisponible.text = titleDataDisponible//consumoTitle
        lblDisponible.textColor = institutionalColors.claroLightGrayColor
        lblDisponible.font = UIFont(name: RobotoFontName.RobotoRegular.rawValue, size: CGFloat(14.0))
        self.addSubview(lblDisponible)
        
        let lblDataValue = BlackTitleLabel()
        lblDataValue.frame = CGRect(x: viewGraphic.frame.maxX + 5, y: lblDisponible.frame.maxY + 5.0, width: widthLabel, height: 20.0)
        lblDataValue.center.y = viewGraphic.center.y
        lblDataValue.textAlignment = .center
        lblDataValue.text = dataPlanUserText//NSString(format:"%@ %@", consumoValue, planUnit.uppercased()) as String
        lblDataValue.textColor = institutionalColors.claroBlackColor
        lblDataValue.font = UIFont(name: RobotoFontName.RobotoMedium.rawValue, size: CGFloat(20.0))
        self.addSubview(lblDataValue)
        
        let lblDate = BlackBodyLabel()
        lblDate.frame = CGRect(x: viewGraphic.frame.maxX + 5, y: lblDataValue.frame.maxY + 10.0, width: widthLabel, height: 20.0)
        lblDate.textAlignment = .center
        lblDate.text = NSString(format: "%@ %@", dateTitle, dateValue) as String
        lblDate.textColor = institutionalColors.claroLightGrayColor
        lblDate.font = UIFont(name: RobotoFontName.RobotoRegular.rawValue, size: CGFloat(14.0))
        self.addSubview(lblDate)
        
    }
    
    @objc func toolTipAction() {
        self.delegate?.showAlertSheet(typeServices: self.typeServices)
    }
    
    func getFormatDataConsuming(data: Float, planUnit: String) -> String {
//        var data = data
        var unit = planUnit.uppercased()
        var finalText = ""
        
        switch unit {
        case "INTERNET":
            finalText = self.convertMBtoGB(data: data, unit: unit)
            self.typeServices = "datosIlimitados"
            break
        case "MB":
            finalText = self.convertMBtoGB(data: data, unit: unit)
            self.typeServices = "datosIlimitados"
            break
        case "VOZ":
            unit = "MINS"
            finalText = NSString(format:"%d %@",Int(data),unit) as String
            self.typeServices = "minutosIlimitados"
            break
        case "SMS":
            unit = "SMS"
            finalText = NSString(format:"%d %@",Int(data),unit) as String
            self.typeServices = "smsIlimitados"
            break
        case "RRSS-1909":
            finalText = self.convertMBtoGB(data: data, unit: unit)
            self.typeServices = "rrssIlimitados"
            break
        case "GPRS":
            finalText = self.convertMBtoGB(data: data, unit: unit)
            self.typeServices = "datosIlimitados"
            break
        case "UNIDADES":
            unit = "SMS"
            finalText = NSString(format:"%d %@",Int(data),unit) as String
            self.typeServices = "smsIlimitados"
            break
        case "MINUTOS", "MINS":
            unit = "MINS"
            finalText = NSString(format:"%d %@",Int(data),unit) as String
            self.typeServices = "minutosIlimitados"
            break
        default:
            break
        }
        
        
//        if data == -1 {
//            finalText = "ILIMITADO"
//        }
        
        return finalText
    }
    
    // Funcion para obtener el tipo de red social
    func setSocialNetwork(social: String){
        arrayWithIDsocial = []
        
        let socialTmp = social.replacingOccurrences(of: "RRSS-", with: "")
        let arraySocial = socialTmp.split(separator: ";")
        
        for socialAux in arraySocial {
            let idSocial = String(socialAux)
            
            switch idSocial {
            case "1":
                arrayWithIDsocial?.append(.Facebook)
                break
            case "2":
                arrayWithIDsocial?.append(.Twitter)
                break
            case "3":
                arrayWithIDsocial?.append(.Whatsapp)
                break
            case "4":
                arrayWithIDsocial?.append(.Instagram)
                break
            case "5":
                arrayWithIDsocial?.append(.ClaroMusica)
                break
            case "6":
                arrayWithIDsocial?.append(.Snapchat)
                break
            case "7":
                arrayWithIDsocial?.append(.Waze)
                break
            case "8":
                arrayWithIDsocial?.append(.ColaboraCloud)
                break
            case "9":
                arrayWithIDsocial?.append(.Gmail)
                break
            case "10":
                arrayWithIDsocial?.append(.Hotmail)
                break
            case "11":
                arrayWithIDsocial?.append(.Yahoo)
                break
            case "12":
                arrayWithIDsocial?.append(.facebookMessenger)
                break
            default:
                break
            }
        }
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
    
    func convertMBtoGB(data: Float, unit: String) -> String {
        var data = data
        var unitType = unit
        if data > 1000 {
            data = data / 1000
            unitType = "GB"
        }else {
            unitType = "MB"
        }
        
//        return NSString(format:"%d %@",Int(data),unitType) as String
        return NSString(format:"%.1f %@",data,unitType) as String
    }
    
    /// mostrar el detalle de una cuenta
    func goToDetail(_ sender : Any) {
        NotificationCenter.default.post(name: Notification.Name("detailInformation"), object: nil, userInfo:  self._tab)
    }
    
    //    func showBtnDetail(show: Bool) {
    //        self.btnShowDetail.isHidden = true
    //    }
    /// ocultar la vista expandible
    func hideInterfaceView() {
        
        for view in self.subviews {
            view.removeFromSuperview()
        }
        
        UIView.animateKeyframes(withDuration: 0.5, delay: 0.2, options: .calculationModeLinear, animations: {
            self.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: self.bounds.width, height: 20.0)
        }, completion: nil)
    }
    /// Actualizar la altura del view expandible
    /// Parameter newHeight: nueva altura
    func updateHeightView(newHeight: CGFloat) {
        let heightContentView = newHeight//heightContentView + newHeight
        print("HEIGHT VIEW BODY EXPAND \(heightContentView), POSY : \(self.frame.origin.y)")
        self.frame = CGRect(x: 10.0, y: self.frame.origin.y, width: self.frame.width - 20.0, height: heightContentView)
    }
    /// Obtener la altura del view expandible
    func getHeightViewBodyExpand() -> CGFloat {
        return self.frame.height//self.bounds.height
    }
    /// Mostrar u ocultar el view expandible
    /// Parameter expand: bandera para saber si se debe mostrar u ocultar el view expandible
    /// Parameter hiddeBtnDetail: bandera para ocultar el botón de detalles
    func showExpandView(expand: Bool, hiddeBtnDetail: Bool, showGraphicMovil: Bool = false) {
        if expand {
            if showGraphicMovil {
                self.showGraphicMovilData()
            }else {
                self.showInterfaceView(hiddeBtnDetail: hiddeBtnDetail)
            }
            
        }else {
            self.hideInterfaceView()
        }
    }
    /// Colocar bordes a la card
    /// Parameter sides: lados donde deben de ir los bordes
    func setLayers(sides: SideView) {
        if sides.Left {
            let leftL = CALayer()
            self.sides = .left
            let border = (self.sides, leftL)
            
            self.borders.append(border)
        }
        if sides.Right {
            let leftL = CALayer()
            self.sides = .right
            let border = (self.sides, leftL)
            
            self.borders.append(border)
        }
        if sides.Top {
            let leftL = CALayer()
            self.sides = .top
            let border = (self.sides, leftL)
            
            self.borders.append(border)
        }
        if sides.Bottom {
            let leftL = CALayer()
            self.sides = .bottom
            let border = (self.sides, leftL)
            
            self.borders.append(border)
        }
    }
    /// Obtener los layers para los bordes
    func getLayers() -> [(Sides, CALayer)]{
        return self.borders
    }
}
