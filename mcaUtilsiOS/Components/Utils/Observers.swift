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

/// Clase usada para el uso del NotificationCenter (Observabilidad)
public class Observers: NSObject {
    
    /// Constante del formato del título
    static let titleFont = [NSFontAttributeName: UIFont(name: RobotoFontName.RobotoRegular.rawValue, size: 14.0)!]
    
    /// Constante del formato del contenido del mensaje
    static let messageFont = [NSFontAttributeName: UIFont(name: RobotoFontName.RobotoLight.rawValue, size: 12.0)!]
    
    static func updateAppAlert(info: NSNotification) {
//       PIPR let conf = SessionSingleton.sharedInstance.getGeneralConfig()
//
//        let updateAvailable = conf?.newUpdateAvailable?.updateAvailable ?? false
//        let forceToUpdate = conf?.newUpdateAvailable?.forcedUpdate ?? false
//
//        if updateAvailable && SessionSingleton.sharedInstance.getIsUpdateAppAvailable() && (forceToUpdate || SessionSingleton.sharedInstance.getCanUpdateApp()) {
//            let custom = NewUpdateAlertViewController()
//            custom.providesPresentationContextTransitionStyle = true;
//            custom.definesPresentationContext = true;
//            custom.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
//            custom.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
//            if UIApplication.shared.keyWindow?.currentViewController is NewUpdateAlertViewController {
//                print("already presented!")
//            } else {
//                UIApplication.shared.keyWindow?.currentViewController?.present(custom,
//                                                                               animated: true,
//                                                                               completion: nil)
//            }
//
//        }
    }
    
    /// Función que determina si posee internet el dispositivo
    /// - parameter info : NSNotification
    static func ReachabilityChanged(info: NSNotification) {
//        PIPRguard let myReach = Reachability() else {
//            print("No WiFi address")
//            SessionSingleton.sharedInstance.setIpAddress(newIpAddress: nil)
//            return;
//        }
//
//        let reachableWifi = myReach.isReachableViaWiFi
//        let status = myReach.isReachable;
//
//        if status {
//            if reachableWifi {
//                print("Reachable via WiFi")
//            } else {
//                print("Reachable via Cellular")
//            }
//
//            if let addr = self.getWiFiAddress() {
//                print("ipAddress : \(addr.getIP())")
//                SessionSingleton.sharedInstance.setIpAddress(newIpAddress: addr.getIP())
//            } else {
//                SessionSingleton.sharedInstance.setIpAddress(newIpAddress: nil) // No IP captures
//                print("No WiFi address")
//            }
//        } else {
//            SessionSingleton.sharedInstance.setIpAddress(newIpAddress: nil) // No IP captures
//            print("Unreachable Network")
//        }
    }
    
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
            let custom = CustomAlertView()
            custom.alertData = info
            custom.providesPresentationContextTransitionStyle = true;
            custom.definesPresentationContext = true;
            custom.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            custom.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            UIApplication.shared.keyWindow?.rootViewController?.present(custom, animated: true, completion: nil)
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
    static func ShowWaitDialog(userEnabled:Bool) {
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
                lblLoading.text = "Cargando...";
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
    
    /// Función que ayuda a notificar un ChangeDateTime
    /// - parameter info : NSNotification
    static func ChangeDateTime(info: NSNotification) {
        let worker = DispatchWorkItem {
            if (Reachability()?.isReachable ?? true) {
                mcaUtilsHelper.refreshConfigurationFile()//PIPRNotificationCenter.default.post(name: ObserverList.RefreshConfigurationFile.name,
//                                                object: nil);
            } else {
                NotificationCenter.default.post(name: NSNotification.Name.NSSystemClockDidChange,
                                                object: nil);
            }
        }

//        if false == SessionSingleton.sharedInstance.isNetworkConnected() || SessionSingleton.sharedInstance.isConsumingService() {
//            SessionSingleton.sharedInstance.setRefreshConfigWorker(worker: nil);
//            DispatchQueue.main.asyncAfter(deadline: SessionSingleton.sharedInstance.getExpiration(), execute: worker);
//            SessionSingleton.sharedInstance.setRefreshConfigWorker(worker: worker);
//            return;
//        }
//
//        if SessionSingleton.sharedInstance.isExpiredTime() /* && nil != SessionSingleton.sharedInstance.getCurrentSession() */{
//            DispatchQueue.main.async {
//                if SessionSingleton.sharedInstance.isNetworkConnected() {
//                    NotificationCenter.default.post(name: ObserverList.RefreshConfigurationFile.name,
//                                                    object: nil);
//                }
//            }
//        } else {
//            SessionSingleton.sharedInstance.setRefreshConfigWorker(worker: nil);
//            DispatchQueue.main.asyncAfter(deadline: SessionSingleton.sharedInstance.getExpiration(), execute: worker);
//            SessionSingleton.sharedInstance.setRefreshConfigWorker(worker: worker);
//        }
//
//                if (true == SessionSingleton.sharedInstance.isExpiredTime()) {
//                    let myApp = UIApplication.shared.delegate as? AppDelegate;
//                    SessionSingleton.sharedInstance.setGeneralConfig(config: nil);
//                    myApp?.loadMainScreen();
//                }
    }
    
    // Return IP address of WiFi interface (en0) as a String, or `nil`
    /// Función que ayuda a obtener la ip de la interfáz del wifi
    /// - Returns : InternetProtocolAddress?
    private static func getWiFiAddress() -> InternetProtocolAddress? {
        let wifi_name = "en0";
        let cellular_name = "pdp_ip0";
        
        var addresses = [InternetProtocolAddress]()
        
        var ifaddr : UnsafeMutablePointer<ifaddrs>?
        guard getifaddrs(&ifaddr) == 0 else { return nil }
        guard let firstAddr = ifaddr else { return nil }
        
        for ptr in sequence(first: firstAddr, next: { $0.pointee.ifa_next }) {
            let flags = Int32(ptr.pointee.ifa_flags)
            let addr = ptr.pointee.ifa_addr.pointee
            
            if (flags & (IFF_UP|IFF_RUNNING|IFF_LOOPBACK)) == (IFF_UP|IFF_RUNNING) {
                if addr.sa_family == UInt8(AF_INET) /*|| addr.sa_family == UInt8(AF_INET6)*/ {
                    
                    var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                    let name = String(cString: ptr.pointee.ifa_name);
                    if (wifi_name == name || cellular_name == name) {
                        if (getnameinfo(ptr.pointee.ifa_addr, socklen_t(addr.sa_len), &hostname, socklen_t(hostname.count), nil, socklen_t(0), NI_NUMERICHOST) == 0) {
                            let address = String(cString: hostname)
                            var ipType = IPType.Unknown;
                            if (wifi_name == name) {
                                ipType = IPType.WifiAddress;
                            } else if(cellular_name == name) {
                                ipType = IPType.CellularAddress;
                            }
                            let ipInfo = InternetProtocolAddress(ip: address, ipType: ipType)
                            addresses.append(ipInfo)
                        }
                    }
                }
            }
        }
        
        freeifaddrs(ifaddr)
        
        return addresses.first
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

/// Clase de Internet Protocol
public class InternetProtocolAddress {
    private var ip : String;
    private var ipType : IPType;
    /// Inicializador
    init () {
        self.ip = "";
        self.ipType = IPType.Unknown;
    }
    /// Inicializador
    /// - parameter ip: String
    /// - parameter ipType : IPType
    init(ip : String, ipType : IPType) {
        self.ip = ip;
        self.ipType = ipType;
    }
    /// Función para setear el valor de la IP
    /// - parameter value : String
    public func setIP(value : String) {
        self.ip = value;
    }
    /// Función que obtiene la IP
    /// - Returns : String
    public func getIP() -> String {
        return ip;
    }
    /// Función para setear el tipo de la IP
    /// - parameter value : IPType
    public func setIPType(value : IPType) {
        self.ipType = value;
    }
    /// Función que obtiene la Tipo de Ip
    /// - Returns : IPType
    public func getIPType() -> IPType {
        return ipType;
    }
}

/// Protocolo de Notification name
protocol NotificationName {
    var name: Notification.Name { get }
}

/// Extensión de RawRepresentable
extension RawRepresentable where RawValue == String, Self: NotificationName {
    var name: Notification.Name {
        get {
            return Notification.Name(self.rawValue)
        }
    }
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
class AlertInfo {
    /// Variable de título
    var title : String = "";
    /// Variable de texto
    var text : String = "";
    /// Variable de Icono
    var icon : AlertIconType = AlertIconType.NoIcon;
    /// Button name
    var buttonName : String? = nil
    /// Button color
    var buttonColor : UIColor? = institutionalColors.claroBlueColor;
    
    var cancelButtonName : String? = nil
    /// Button color
    var cancelButtonColor : UIColor? = institutionalColors.claroBlueColor;
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

