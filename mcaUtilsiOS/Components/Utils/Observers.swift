//
//  Observers.swift
//  MiClaro
//
//  Created by Roberto Gutierrez Resendiz on 31/07/17.
//  Copyright © 2017 am. All rights reserved.
//

import UIKit
import PKHUD
import Lottie
import Cartography
import ReachabilitySwift
import IQKeyboardManager

/// Clase usada para el uso del NotificationCenter (Observabilidad)
public class Observers: NSObject {
    
    /// Constante del formato del título
    static let titleFont = [NSFontAttributeName: UIFont(name: RobotoFontName.RobotoRegular.rawValue, size: 14.0)!]
    
    /// Constante del formato del contenido del mensaje
    static let messageFont = [NSFontAttributeName: UIFont(name: RobotoFontName.RobotoLight.rawValue, size: 12.0)!]
    
    /// Función que ayuda a enviar un AcceptOnlyAlert popup
    /// - parameter info : NSNotification
    static func AcceptOnlyAlert(info:AlertAcceptOnly) {
        
        let topMost = UIApplication.shared.keyWindow?.rootViewController//PIPRUIApplication.shared.keyWindow?.topMostWindowController;
        if nil != topMost && true == topMost?.isKind(of: CustomAlertView.self) {
            return; // Evita que se muestren en pantalla dos o más alertas
        }
        let custom = CustomAlertView()
        custom.alertData = info
        custom.providesPresentationContextTransitionStyle = true;
        custom.definesPresentationContext = true;
        custom.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        custom.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        topMost?.present(custom, animated: true, completion: nil)//PIPRUIApplication.shared.keyWindow?.currentViewController?.present(custom,
//                                                                           animated: true,
//                                                                           completion: nil);
    }
    
    /// Función que ayuda a enviar un WebViewAlert popup
    /// - parameter info : NSNotification
    static func WebViewAlert(info:WebViewAlertData) {
        
        let topMost = UIApplication.shared.keyWindow?.rootViewController//PIPRlet topMost = UIApplication.shared.keyWindow?.topMostWindowController;
        if nil != topMost && true == topMost?.isKind(of: CustomAlertView.self) {
            return; // Evita que se muestren en pantalla dos o más alertas
        }
        let custom = WebViewAlertViewController()
        custom.alertData = info
        custom.providesPresentationContextTransitionStyle = true;
        custom.definesPresentationContext = true;
        custom.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        custom.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        topMost?.present(custom, animated: true, completion: nil)//PIPRUIApplication.shared.keyWindow?.currentViewController?.present(custom,
            //                                                                           animated: true,
            //                                                                           completion: nil);
    }
    
    /// Función que ayuda a enviar un YesNoAlert popup
    /// - parameter info : NSNotification
    static func YesNoAlert(info:AlertYesNo) {
        let custom = CustomAlertView();
        custom.alertData = info
        custom.providesPresentationContextTransitionStyle = true;
        custom.definesPresentationContext = true;
        custom.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        custom.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        UIApplication.shared.keyWindow?.currentViewController?.present(custom,
                                                                       animated: true,
                                                                       completion: nil)
    }
    
    /// Función que ayuda a enviar un FotoAlert popup
    /// - parameter info : NSNotification
    static func FotoAlert(info: AlertFoto) {
            let custom = CustomAlertView();
            custom.alertData = info
            custom.providesPresentationContextTransitionStyle = true;
            custom.definesPresentationContext = true;
            custom.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            custom.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            UIApplication.shared.keyWindow?.rootViewController?.present(custom, animated: true, completion: nil)//            PIPRUIApplication.shared.keyWindow?.currentViewController?.present(custom,
//                                                                           animated: true,
//                                                                           completion: nil);
    }
    
    static func PlanDataDetailAlert(info : PlanDetailAlertData) {
        
        let topMost = UIApplication.shared.keyWindow?.rootViewController//PIPRlet topMost = UIApplication.shared.keyWindow?.topMostWindowController;
        if nil != topMost && true == topMost?.isKind(of: PlanDetailAlertData.self) {
            return; // Evita que se muestren en pantalla dos o más alertas
        }
        let custom = PlanDetailAlertViewController()
        custom.alertData = info
        custom.providesPresentationContextTransitionStyle = true;
        custom.definesPresentationContext = true;
        custom.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        custom.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        topMost?.present(custom, animated: true, completion: nil);
    }
    
    /// Función que ayuda a enviar un ShowWaitDialog popup
    /// - parameter info : NSNotification
    static func ShowWaitDialog(userEnabled:Bool, loadingText: String = "Cargando...") {
        if (nil == UIApplication.shared.keyWindow) {
            return;
        }
        PKHUD.sharedHUD.dimsBackground = !userEnabled;
        PKHUD.sharedHUD.userInteractionOnUnderlyingViewsEnabled = userEnabled;
        
        if (false == HUD.isVisible) {
            DispatchQueue.main.async {
                let ancho : CGFloat = 130;
                let alto : CGFloat = 130;
                let view = UIView(frame: CGRect(x: 0, y: 0, width: ancho, height: alto))
                let lblLoading = UILabel()
                lblLoading.font = UIFont(name: RobotoFontName.RobotoRegular.rawValue, size: CGFloat(16));
                lblLoading.text = loadingText
                lblLoading.textColor = institutionalColors.claroTitleColor
                lblLoading.numberOfLines = 0;
                lblLoading.lineBreakMode = NSLineBreakMode.byWordWrapping;
                lblLoading.textAlignment = .center;
                lblLoading.sizeToFit()
                view.addSubview(lblLoading);
                
                let anim = CustomWaitAnimation(width: 100, height: 100);
                view.addSubview(anim)
                
                constrain(view, anim, lblLoading) { (v, w, l) in
                    w.width == 100;
                    w.height == 100;
                    w.centerX == v.centerX;
                    l.centerX == v.centerX;
                    w.top == v.top;
                    l.top == w.bottom;
                    l.height == 25;
                }
                
                PKHUD.sharedHUD.contentView = view;
                PKHUD.sharedHUD.show()
            }
        }
    }
    
    /// Función que ayuda a ocultar un HideWaitDialog popup
    /// - parameter info : NSNotification
    static func HideWaitDialog() {
        if (nil == UIApplication.shared.keyWindow) {
            return;
        }
        DispatchQueue.main.async {
            if PKHUD.sharedHUD.isVisible {
                PKHUD.sharedHUD.hide();
            }
        }
    }
    
    /// Función que modifica el texto de una alerta
    /// - parameter text : String
    /// - Returns : String
    static func modifyTextAlert(text: String) -> String {
        let spaces = 4
        var textModify = ""
        //We separate text by spaces
        let newText = text.replacingOccurrences(of: "\n", with: " ").split(separator: " ")
        //Add \n when find two spaces
        for i in 0 ..< newText.count {
            let textTmp = "\(newText[i])"
            textModify = textModify + textTmp
            
            if i % spaces == 0 && i != 0 {
                textModify = textModify + "\n"
            }else {
                textModify = textModify + " "
            }
        }
        
        return textModify
    }
}

/// Enumerado tipo de IP
public enum IPType : String {
    case Unknown
    case WifiAddress
    case CellularAddress
}

public enum AlertIconType : String {
    case NoIcon = ""
    case IconoCodigoDeVerificacionDeTexto = "ico_codigo_de_verificacion_de_texto"
    case IconoCuentaExitosa = "ico_cuenta_exitosa"
    case IconoFelicidadesContraseñaCambiada = "ico_felicidades_contrasena_cambiada"
    case IconoNumeroDeSerie = "ico_numero_de_serie"
    case IconoAlertaSMS = "ico_alerta_sms"
    
    case IconoAlertaError = "ico_alerta_error"
    case IconoAlertaFelicidades = "ico_alerta_felicidades"
    case IconoAlertaOK = "ico_alerta_ok"
    case IconoAlertaPregunta = "ico_alerta_pregunta"
    case IconoAlertaResumen = "ico_seccion_mc_resumen"
    case IconoAlertaPerfil = "ico_avatar"
    case IconoAlertaInformacion = "ico_alerta_info"
    case IconoAlertaAviso = "ico-lo-siento"
    case IconoAlertaUnBlock = "ico_seccion_pass"
    case IconoAlertaBlock = "ico_seccion_block"
}

/// Clase para guardar los elementos de un alert
public class AlertInfo {
    /// Variable de título
    public var title : String = "";
    /// Variable de texto
    public var text : String = "";
    /// Variable de Icono
    public var icon : AlertIconType = AlertIconType.NoIcon;
    /// Button name
    public var buttonName : String? = nil
    /// Button color
    public var buttonColor : UIColor? = institutionalColors.claroBlueColor;
    
    public var cancelButtonName : String? = nil
    /// Button color
    public var cancelButtonColor : UIColor? = institutionalColors.claroBlueColor;
    
    /// Variable para habilitar copiar texto del UILabel
    var isEnabledLabelCopy: Bool = false
}


/// Clase para guardar los elementos de un AlertFoto
class AlertFoto : AlertInfo {
    /// Variable de acceptTitle
    var acceptTitle : String = NSLocalizedString("alert-aceptar-button", comment: "");
    /// Variable de abrirCamaraTitle
    var abrirCamaraTitle : String = NSLocalizedString("alert-aceptar-button", comment: "");
    /// Variable de abrirCamaraTitle
    var eliminarFotoTitle : String = ""
    /// Variable de cancelTitle
    var cancelTitle : String = NSLocalizedString("alert-cancelar-button", comment: "");
    /// Trigger onAcceptEvent
    var onAcceptEvent = {};
    /// Trigger onCamaraEvent
    var onCamaraEvent = {};
    /// Trigger onCamaraEvent
    var onDeletePhotoEvent = {};
    /// Trigger onCancelEvent
    var onCancelEvent = {};
    
    var nameProfile: String = ""
}

/// Clase para guardar los elementos de un AlertYesNo
class AlertYesNo : AlertInfo {
    /// Variable de acceptTitle
    var acceptTitle : String = NSLocalizedString("alert-aceptar-button", comment: "");
    /// Variable de cancelTitle
    var cancelTitle : String = NSLocalizedString("alert-cancelar-button", comment: "");
    /// Trigger onAcceptEvent
    var onAcceptEvent = {};
    /// Trigger onCancelEvent
    var onCancelEvent = {};
    var acceptButtonColor: UIColor? = nil
}

/// Clase para guardar los elementos de un AlertAcceptOnly
class AlertAcceptOnly : AlertInfo {
    /// Variable de acceptTitle
    var acceptTitle : String = "" //FIXME: NSLocalizedString(/*"alert-aceptar-button"*/ mcaManagerSession.getGeneralConfig()?.translations?.data?.generales?.acceptBtn?.uppercased() ?? "", comment: "");
    /// Trigger onAcceptEvent
    var onAcceptEvent = {};
}

/// Clase para guardar los elementos de un AlertAcceptOnly
class AlertAcceptOnlyPasswordReq : AlertInfo {
    /// Variable de acceptTitle
    var acceptTitle : String = "" //FIXME: NSLocalizedString(/*"alert-aceptar-button"*/ mcaManagerSession.getGeneralConfig()?.translations?.data?.generales?.acceptBtn?.uppercased() ?? "", comment: "");
    /// Trigger onAcceptEvent
    var userEmail : String = ""
    var userPhone : String = ""
    
    var onAcceptEvent = {};
}

class WebViewAlertData : AlertInfo {
    var url : String?;
    var method : String = "GET";
    /// Variable de acceptTitle
    var acceptTitle : String = NSLocalizedString("alert-aceptar-button", comment: "");
    /// Trigger onAcceptEvent
    var onAcceptEvent = {};
}

class PlanDetailAlertData : AlertInfo {
    /// Variable de subtitle
    var subtitle : String?
    /// Variable de includes
    var includes : String?
    /// Variable de acceptTitle
    var acceptTitle : String = NSLocalizedString("alert-aceptar-button", comment: "");
    /// Trigger onAcceptEvent
    var onAcceptEvent = {};
}

