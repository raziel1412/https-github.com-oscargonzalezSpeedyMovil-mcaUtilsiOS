//
//  CardCellView.swift
//  MiClaro
//
//  Created by Omar Israel Trujillo Osornio on 01/09/17.
//  Copyright © 2017 am. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

public class CardCellViewModel {
    
    var planName: String!
    var accountId: String!
    var period: String!
    var totalIssued: String!
    var expiration: String!
    var activatePaperless: String!
    var sendBill: String!
    var downloadBill: String!
    
    ///PARAMS
//    accountId (conf?.translations?.data?.billing?.accountId)
//    period (conf?.translations?.data?.billing?.period)
//    totalIssued (conf?.translations?.data?.billing?.totalIssued)
//    expiration (conf?.translations?.data?.billing?.expiration)
//    activatePaperless (conf?.translations?.data?.billing?.activatePaperless)
//    sendBill (conf?.translations?.data?.billing?.sendBill)
//    downloadBill (conf?.translations?.data?.billing?.downloadBill)
    
    init(planName: String?, accountId: String?, period: String?, totalIssued: String?, expiration: String?, activatePaperless: String?, sendBill: String?, downloadBill: String?) {
        self.planName = planName ?? ""
        self.accountId = accountId ?? ""
        self.period = period ?? ""
        self.totalIssued = totalIssued ?? ""
        self.expiration = expiration ?? ""
        self.activatePaperless = activatePaperless ?? ""
        self.sendBill = sendBill ?? ""
        self.downloadBill = downloadBill ?? ""
    }
    
    
}

public class CardCellView: UITableViewCell, UITextFieldDelegate {

    //MARK: Variables
    ///Varibles que se utilizan como referencia en la celda 
    var yOffset40 : CGFloat = 40
    var yOffset30 : CGFloat = 30
    var yOffset20 : CGFloat = 20
    var yOffset10 : CGFloat = 10
    var fontSize18 : CGFloat = 18
    var fontSize16 : CGFloat = 18
    var fontSize14 : CGFloat = 14

    //MARK: UI-Variables
    ///Textfield contenedor del mes actual de la boleta
    var txtPeriods = UITextField()
    ///Etiqueta que contiene la informacion de la variable billing?.activatePaperless
    var activarBoleta : LinkableLabel?;
    ///Etiqueta que contiene la informacion de la variable billing?.sendBill
    var enviarBoleta : LinkableLabel?;
    ///Etiqueta que contiene la informacion de la variable billing?.downloadBill
    var descargaBoleta : LinkableLabel?
    /// Etiqueta que muestra la informacion de la variable lbVenc
    let lbVencimiento = UILabel()
    /// Etiqueta que muestra la informacion de la variable dueDateString
    let lbVencimientoTipo = UILabel()
    /// Etiqueta que muestra la informacion de la variable self.plan?.plan?.planName
    let lbNombrePlan = UILabel()
    ///View que forma el contorno de la boleta con grecas en la parte inferior
    let vcContainer = UIView()
    /// Etiqueta que muestra la informacion de la variable lbNoCta
    let lbNumCta = UILabel()
    /// Etiqueta que muestra la informacion de la variable self.plan.accountId
    let lbNumCtaTipo = UILabel()
    /// Etiqueta que muestra la informacion de la variable lbSeleccPeriods
    let lbTitleTextfieldPeriods = UILabel()
    /// Etiqueta que muestra la informacion de la variable lbmontoEmitido
    let lbmonto = UILabel()
    /// Etiqueta que muestra la informacion de la variable totalAmountFormat
    let lbMontoTipo = UILabel()
    ///Imagen que se muestra arriba del la etiqueta activarBoleta
    var imgSend = UIImageView()
    ///Imagen que se muestra arriba del la etiqueta enviarBoleta
    var imgMail = UIImageView()
    ///Imagen que se muestra arriba del la etiqueta descargaBoleta
    var imgDownload = UIImageView()
    ///Imagen de flecha dentro de txtPeriods
    var imageHeader = UIImageView()
    ///Vista contenedora de las grecas inferiores de la boleta
    let vcLinesLower = UIView()


    override public func awakeFromNib() {
        super.awakeFromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override public func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: false)
    }
    
 
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    
    func createBorderHeader(view: UIView) {
        let side = SideView(Left: true, Right: true, Top: true, Bottom: false)
        view.addBorder(sides: side, color: institutionalColors.claroLightGrayColor, thickness: 0.5)
    }
    //MARK: - Funcion que construye los objetos de la celda
    ///Creacion he inicializacion de los objetos que seran utilizado dentro de la celda customizada, que sera utilizada en Boletas
    func setup (cardCellInfo: CardCellViewModel) {
        
        self.contentView.backgroundColor = institutionalColors.claroWhiteColor
        let screenSize = UIScreen.main.bounds
        
        let kWidth = screenSize.width
        let yHeight = screenSize.height
        let textFieldWidth = kWidth * 0.8
        
        switch Int(yHeight) {
        case 568:
            yOffset40 = 40
            yOffset30 = 30
            yOffset20 = 20
            yOffset10 = 10
            fontSize18 = 18
            fontSize16 = 16
            fontSize14 = 14
            break
        default:
            yOffset40 = 50
            yOffset30 = 40
            yOffset20 = 20
            yOffset10 = 20
            fontSize18 = 20
            fontSize16 = 18
            fontSize14 = 16
            break
        }

        self.backgroundColor = UIColor.white
        vcContainer.frame = CGRect(x: 0.0, y: yOffset20, width: 300, height: self.frame.size.height - 140)
        vcContainer.backgroundColor = UIColor.white
        vcContainer.borderCard()
        self.addSubview(vcContainer)

        lbNombrePlan.text =  cardCellInfo.planName
        lbNombrePlan.frame = CGRect(x: 50, y: 50, width: textFieldWidth, height: 40)
        lbNombrePlan.textColor = institutionalColors.claroBlackColor
        lbNombrePlan.textAlignment = NSTextAlignment .left
        lbNombrePlan.numberOfLines = 2
        if kWidth == 320{
            lbNombrePlan.font = UIFont(name: RobotoFontName.RobotoBlack.rawValue, size: CGFloat(17.0))
        }else{
            lbNombrePlan.font = UIFont(name: RobotoFontName.RobotoBlack.rawValue, size: CGFloat(19.0))
        }
        lbNombrePlan.sizeToFit()
        self.addSubview(lbNombrePlan)
        
        let circleView = UIView.initializeCircle(frame: CGRect(x: 30, y: 50, width: 5, height: 5))
        circleView.center = CGPoint(x: circleView.center.x, y: lbNombrePlan.center.y)
        self.addSubview(circleView)


        lbNumCta.text = cardCellInfo.accountId
        lbNumCta.frame = CGRect(x: 50, y: lbNombrePlan.frame.maxY + 5, width: 100, height: 40)
        lbNumCta.textAlignment = NSTextAlignment .left
        lbNumCta.font = UIFont(name: RobotoFontName.RobotoRegular.rawValue, size: CGFloat(14.0))
        lbNumCta.textColor = institutionalColors.claroTextColor
        lbNumCta.sizeToFit()
        self.addSubview(lbNumCta)
        
        lbNumCtaTipo.text = "" //FIXME: self.plan.accountId ?? ""
        lbNumCtaTipo.frame = CGRect(x: lbNumCta.frame.maxX + 10, y: lbNombrePlan.frame.maxY + 5, width: 100, height: 40)
        lbNumCtaTipo.textAlignment = NSTextAlignment .right
        lbNumCtaTipo.font = UIFont(name: RobotoFontName.RobotoRegular.rawValue, size: CGFloat(14.0))
        lbNumCtaTipo.textColor = institutionalColors.claroTextColor
        lbNumCtaTipo.sizeToFit()
        self.addSubview(lbNumCtaTipo)

        //Linea punteada debajo del accountId del usuario
        vcLinesLower.backgroundColor = institutionalColors.claroBlackColor
        vcLinesLower.frame = CGRect(x: 25.0, y: lbNumCta.frame.maxY + 20 , width: screenSize.size.width - 50, height: 1.0)
        vcLinesLower.addBottomlines()
        self.addSubview(vcLinesLower)
        
        lbTitleTextfieldPeriods.text = cardCellInfo.period
        lbTitleTextfieldPeriods.frame = CGRect(x: 30, y: vcLinesLower.frame.maxY + 20, width: self.frame.width, height: 40)
        lbTitleTextfieldPeriods.textAlignment = NSTextAlignment .left
        lbTitleTextfieldPeriods.font = UIFont(name: RobotoFontName.RobotoRegular.rawValue, size: CGFloat(12.0))
        lbTitleTextfieldPeriods.textColor = institutionalColors.claroTextColor
        lbTitleTextfieldPeriods.sizeToFit()
        self.addSubview(lbTitleTextfieldPeriods)
        
        txtPeriods.textColor = institutionalColors.claroBlackColor
        txtPeriods.frame = CGRect (x: 30, y: lbTitleTextfieldPeriods.frame.maxY + 5, width: textFieldWidth, height: 44)
        txtPeriods.borderStyle = .roundedRect
        self.addSubview(txtPeriods)
        
        imageHeader = UIImageView(frame: CGRect(x: textFieldWidth - 30, y: txtPeriods.frame.size.height - 30, width: 21, height: 21))
        let image = mcaUtilsHelper.getImage(image: "ico_drop_down")
        imageHeader.image = image
        txtPeriods.addSubview(imageHeader)
        
        lbmonto.text = cardCellInfo.totalIssued //"Monto emitido"
        lbmonto.frame = CGRect(x: 30, y: txtPeriods.frame.maxY + 16, width: 200, height: 40)
        lbmonto.textAlignment = NSTextAlignment .left
        lbmonto.textColor = institutionalColors.claroBlackColor
        lbmonto.font =  UIFont(name: RobotoFontName.RobotoMedium.rawValue, size: CGFloat(20.0))
        lbmonto.sizeToFit()
        self.addSubview(lbmonto)
        
        lbMontoTipo.text = " "
        lbMontoTipo.frame = CGRect(x: self.frame.width / 2, y: txtPeriods.frame.maxY + 16, width: 170, height: 40)
        lbMontoTipo.textAlignment = NSTextAlignment .right
        lbMontoTipo.textColor = institutionalColors.claroBlackColor
        lbMontoTipo.font =  UIFont(name: RobotoFontName.RobotoBold.rawValue, size: CGFloat(20.0))
        lbMontoTipo.sizeToFit()
        lbMontoTipo.backgroundColor = institutionalColors.claroWhiteColor
        self.addSubview(lbMontoTipo)
        
        lbVencimiento.text = cardCellInfo.expiration //"Vencimiento"
        lbVencimiento.frame = CGRect(x: 30, y: lbmonto.frame.maxY + 5, width: 200, height: 40)
        lbVencimiento.textAlignment = NSTextAlignment .left
        lbVencimiento.textColor = institutionalColors.claroTextColor
        lbVencimiento.font =  UIFont(name: RobotoFontName.RobotoRegular.rawValue, size: CGFloat(12.0))
        lbVencimiento.sizeToFit()
        self.addSubview(lbVencimiento)
        
        lbVencimientoTipo.text = "Sin Información"
        lbVencimientoTipo.frame = CGRect(x: lbVencimiento.frame.maxX + 10, y: lbMontoTipo.frame.maxY + 5, width: 170, height: 40)
        lbVencimientoTipo.textAlignment = NSTextAlignment .left
        lbVencimientoTipo.textColor = institutionalColors.claroTextColor
        lbVencimientoTipo.font =  UIFont(name: RobotoFontName.RobotoRegular.rawValue, size: CGFloat(12.0))
        lbVencimientoTipo.sizeToFit()
        self.addSubview(lbVencimientoTipo)
        
        let containerWidth = screenSize.size.width - 30
        let centerImgSend = 15 + (containerWidth * 0.179)

        imgSend.frame = CGRect(x:40, y: lbVencimiento.frame.maxY + 20, width: 90, height: 30)
        imgSend.center = CGPoint(x: centerImgSend, y: imgSend.center.y)
        imgSend.contentMode = .scaleAspectFit
        imgSend.image = #imageLiteral(resourceName: "ico_accion_activar_boleta")
        self.addSubview(imgSend)
        
        activarBoleta = LinkableLabel();
        activarBoleta?.frame = CGRect (x: 20, y: imgSend.frame.maxY + 10, width: 135, height: 90)
        activarBoleta?.textColor = institutionalColors.claroBlueColor
        activarBoleta?.showText(text: cardCellInfo.activatePaperless)
        activarBoleta?.textAlignment = .center
        activarBoleta?.numberOfLines = 2
        activarBoleta?.font =  UIFont(name: RobotoFontName.RobotoRegular.rawValue, size: CGFloat(12.0))
        activarBoleta?.sizeToFit()
        activarBoleta?.center = CGPoint(x: imgSend.center.x, y: activarBoleta!.center.y)
        self.addSubview(activarBoleta!);
        

        
        imgMail.frame = CGRect(x:self.frame.width / 2, y: lbVencimiento.frame.maxY + 20, width: 90, height: 30)
        imgMail.center = CGPoint(x: screenSize.size.width/2, y: imgMail.center.y)
        imgMail.contentMode = .scaleAspectFit
        imgMail.image = #imageLiteral(resourceName: "ico_accion_enviar_boleta")
        self.addSubview(imgMail)
        
        enviarBoleta = LinkableLabel();
        enviarBoleta?.font = UIFont(name: RobotoFontName.RobotoRegular.rawValue, size: CGFloat(12.0))
        enviarBoleta?.frame = CGRect (x: imgMail.center.x - 35, y: imgMail.frame.maxY + 10, width: 100, height: 90)
        enviarBoleta?.textColor = institutionalColors.claroBlueColor
        enviarBoleta?.showText(text: cardCellInfo.sendBill)
        enviarBoleta?.textAlignment = .center
        enviarBoleta?.numberOfLines =  2
        enviarBoleta?.sizeToFit()
        enviarBoleta?.center = CGPoint(x: imgMail.center.x, y: enviarBoleta!.center.y)
        self.addSubview(enviarBoleta!);
        
 
        let centerImgDownload = 15 + (containerWidth * 0.821)

        imgDownload.frame = CGRect(x: imgMail.frame.maxX + 90, y: lbVencimiento.frame.maxY + 20, width: 90, height: 30)
        imgDownload.center = CGPoint(x: centerImgDownload, y: imgDownload.center.y)
        imgDownload.contentMode = .scaleAspectFit
        imgDownload.image = #imageLiteral(resourceName: "ico_accion_descargar_boleta")
        imgDownload.backgroundColor = UIColor.clear
        self.addSubview(imgDownload)
        
        descargaBoleta = LinkableLabel();
        descargaBoleta?.font = UIFont(name: RobotoFontName.RobotoRegular.rawValue, size: CGFloat(12.0))
        descargaBoleta?.frame = CGRect (x: imgDownload.center.x - 35, y: imgDownload.frame.maxY + 10, width: 60, height: 90)
        descargaBoleta?.backgroundColor = UIColor.clear
        descargaBoleta?.textColor = institutionalColors.claroBlueColor
        descargaBoleta?.showText(text: cardCellInfo.downloadBill)
        descargaBoleta?.textAlignment = .center;
        descargaBoleta?.numberOfLines = 2
        descargaBoleta? .sizeToFit()
        descargaBoleta?.center = CGPoint(x: imgDownload.center.x, y: descargaBoleta!.center.y)

        self.addSubview(descargaBoleta!);
        
        vcContainer.frame = CGRect(x: 15, y:yOffset20, width: screenSize.size.width - 30, height: descargaBoleta!.frame.maxY + 10)
        
        vcContainer.addBottomGrecas()
        self.createBorderHeader(view: vcContainer)
        
        self.clipsToBounds = false
    }

}
