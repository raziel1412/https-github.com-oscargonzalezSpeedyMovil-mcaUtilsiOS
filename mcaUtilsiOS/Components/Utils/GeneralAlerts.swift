//
//  GeneralAlerts.swift
//  MiClaro
//
//  Created by Roberto on 11/21/18.
//  Copyright © 2018 am. All rights reserved.
//
import Foundation
import UIKit
//import mcaManageriOS

public class GeneralAlerts {
    
    //case YesNoAlert
    
    init() {
    }
    
    public static func showYesNo(title: String = "", text: String = "", acceptTitle: String = "Aceptar", cancelTitle: String = "Cancelar", icon: AlertIconType = .NoIcon, acceptColorBtn: UIColor = institutionalColors.claroBlueColor, onAcceptEvent: @escaping ()->() = {}, onCancelEvent: @escaping ()->() = {}){
        
        let alert = AlertYesNo();
        alert.title = title
        alert.text = text
        alert.acceptTitle = acceptTitle
        alert.cancelTitle = cancelTitle
        alert.acceptButtonColor = acceptColorBtn
        alert.icon = icon
        //alert.presenter = presenter
        
        alert.onAcceptEvent = {
            onAcceptEvent()
        };
        alert.onCancelEvent = {
            onCancelEvent()
        };
        
        /*if(presenter != nil){
            let presenterData:[String: UIViewController] = ["presenter": presenter!]
            //NotificationCenter.default.post(name: Observers.ObserverList.UpdateAppAlert.name, object: alert, userInfo: presenterData);
            NotificationCenter.default.post(name: Observers.ObserverList.YesNoAlert.name,
                                            object: alert, userInfo: presenterData);
        }else{
            print("> No has definido el ViewController")
        }*/
        
        NotificationCenter.default.post(name: Observers.ObserverList.YesNoAlert.name,
                                        object: alert);

    }
    
    //case AcceptOnlyAlert
    public static func showAcceptOnly(title: String = "", text: String = "", acceptTitle: String = "Aceptar", icon: AlertIconType = .NoIcon, onAcceptEvent: @escaping ()->() = {}){
        
        let alert = AlertAcceptOnly();
        alert.title = title
        alert.text = text
        alert.icon = icon
        alert.acceptTitle = acceptTitle
        alert.onAcceptEvent = {
            onAcceptEvent()
        }
        //alert.presenter = presenter
        
        /*if(presenter != nil){
            let presenterData:[String: UIViewController] = ["presenter": presenter!]
            //NotificationCenter.default.post(name: Observers.ObserverList.UpdateAppAlert.name, object: alert, userInfo: presenterData);
            NotificationCenter.default.post(name: Observers.ObserverList.AcceptOnlyAlert.name, object: alert, userInfo: presenterData);
        }else{
            print("> No has definido el ViewController")
        }*/
        
        NotificationCenter.default.post(name: Observers.ObserverList.AcceptOnlyAlert.name, object: alert);
        

    }
    
    //case WebViewAlertData
    public static func showDataWebView(title: String = "", url: String = "", method: String = "POST", acceptTitle: String = "Aceptar", onAcceptEvent: @escaping ()->() = {}){
        
        let alert = WebViewAlertData();
        alert.method = method
        alert.url = url
        alert.title = title
        alert.acceptTitle = acceptTitle
        alert.onAcceptEvent = {
            onAcceptEvent()
        }
        //alert.presenter = presenter
        
        /*if(presenter != nil){
            let presenterData:[String: UIViewController] = ["presenter": presenter!]
            //NotificationCenter.default.post(name: Observers.ObserverList.UpdateAppAlert.name, object: alert, userInfo: presenterData);
            NotificationCenter.default.post(name: Observers.ObserverList.WebViewAlert.name,
                                            object: alert, userInfo: presenterData);
        }else{
            print("> No has definido el ViewController")
        }*/
        
        NotificationCenter.default.post(name: Observers.ObserverList.WebViewAlert.name,
                                        object: alert);
        
        
    }
    
    //case PlanDataDetailAlert
    public static func showPlanDataDetail(title: String = "", subtitle: String = "", includes: String = "", detallePlan: String = "", acceptTitle: String = "Aceptar", icon: AlertIconType = .NoIcon){
        
        let alert = PlanDetailAlertData();
        
        alert.title = title//conf?.translations?.data?.updatePlan?.actualPlanDetail ?? "";
        alert.subtitle = subtitle//nombrePlan;
        alert.includes = includes//conf?.translations?.data?.updatePlan?.planIncludes ?? "";
        alert.text = detallePlan//detallePlan;
        alert.acceptTitle = acceptTitle//conf?.translations?.data?.generales?.closeBtn ?? "";
        alert.icon = icon//.IconoAlertaInformacion;
        //alert.presenter = presenter
            
            /*if(presenter != nil){
                let presenterData:[String: UIViewController] = ["presenter": presenter!]
                //NotificationCenter.default.post(name: Observers.ObserverList.UpdateAppAlert.name, object: alert, userInfo: presenterData);
                NotificationCenter.default.post(name: Observers.ObserverList.PlanDataDetailAlert.name,
                                                object: alert, userInfo: presenterData);
            }else{
                print("> No has definido el ViewController")
            }*/
            
            NotificationCenter.default.post(name: Observers.ObserverList.PlanDataDetailAlert.name,
                                            object: alert);
        
    }
    
    //case ShowWaitDialog
    public static func showWaitDialog(){
        NotificationCenter.default.post(name: Observers.ObserverList.ShowWaitDialog.name, object: nil);
    }
    
    //case HideWaitDialog
    public static func hideWaitDialog(){
        NotificationCenter.default.post(name: Observers.ObserverList.HideWaitDialog.name, object: nil);
    }
    
    //case ShowOfflineMessage
    //case RefreshConfigurationFile
    
    
    //case FotoAlert
    public static func showFoto(title:String = "", acceptTitle:String = "Aceptar", abrirCamaraTitle:String = "", eliminarFotoTitle:String = "", cancelTitle:String = "", icon: AlertIconType = .NoIcon, onAcceptEvent: @escaping ()->() = {}, onCamaraEvent: @escaping ()->() = {}, onDeletePhotoEvent: @escaping ()->() = {}, onCancelEvent: @escaping ()->() = {}){
        
        let alert = AlertFoto();
        alert.title = title
        alert.acceptTitle = acceptTitle
        alert.abrirCamaraTitle = abrirCamaraTitle
        alert.eliminarFotoTitle = eliminarFotoTitle
        alert.cancelTitle = cancelTitle
        alert.icon = icon
        //alert.presenter = presenter
        
        alert.onAcceptEvent = {
            onAcceptEvent()
        }
        
        alert.onCamaraEvent = {
            onCamaraEvent()
        }
        
        alert.onDeletePhotoEvent = {
            onDeletePhotoEvent()
        }
        
        alert.onCancelEvent = {
            onCancelEvent()
        }
        
        /*if(presenter != nil){
            let presenterData:[String: UIViewController] = ["presenter": presenter!]
            //NotificationCenter.default.post(name: Observers.ObserverList.UpdateAppAlert.name, object: alert, userInfo: presenterData);
            NotificationCenter.default.post(name: Observers.ObserverList.FotoAlert.name,
                                            object: alert, userInfo: presenterData)
        }else{
            print("> No has definido el ViewController")
        }*/
        
        NotificationCenter.default.post(name: Observers.ObserverList.FotoAlert.name,
                                        object: alert)
        
        
    }
    
    
    //case AcceptOnlyAlertPasswordReq
    public static func showAcceptOnlyPassword(title:String = "", text:String = "", userEmail:String = "", userPhone:String = "", acceptTitle:String = "Aceptar", icon: AlertIconType = .NoIcon, acceptColorBtn: UIColor = institutionalColors.claroBlackColor, onAcceptEvent: @escaping ()->() = {}){
        
        //let appDelegate = UIApplication.shared.delegate as! AppDelegate;
        
        let alert = AlertAcceptOnlyPasswordReq();
        alert.userEmail = userEmail.maskAsEmail()
        alert.userPhone = userPhone.maskAsPhone()
        alert.text = text
        alert.title = title
        alert.icon = icon
        alert.buttonName = acceptTitle
        alert.buttonColor = acceptColorBtn
        alert.onAcceptEvent = {
            onAcceptEvent()
        }
        //alert.presenter = presenter
        
        /*if(presenter != nil){
            let presenterData:[String: UIViewController] = ["presenter": presenter!]
            //NotificationCenter.default.post(name: Observers.ObserverList.UpdateAppAlert.name, object: alert, userInfo: presenterData);
            NotificationCenter.default.post(name: Observers.ObserverList.AcceptOnlyAlertPasswordReq.name,
                                            object: alert, userInfo: presenterData);
        }else{
            print("> No has definido el ViewController")
        }*/
        
        NotificationCenter.default.post(name:Observers.ObserverList.AcceptOnlyAlertPasswordReq.name,
        object: alert);
        
        //traer la informacion de alerta crear registros en entidades
        //se procede a borrar
        //appDelegate.killEntities()
        
    }
    
    
}

