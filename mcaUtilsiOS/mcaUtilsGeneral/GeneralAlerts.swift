//
//  GeneralAlerts.swift
//  MiClaro
//
//  Created by Roberto on 11/21/18.
//  Copyright © 2018 am. All rights reserved.
//
import Foundation
import UIKit

public class GeneralAlerts {
    
    //case YesNoAlert
    public static func showYesNo(title: String = "", text: String = "", acceptTitle: String = "Aceptar", cancelTitle: String = "Cancelar", icon: AlertIconType? = nil, acceptColorBtn: UIColor? = nil, onAcceptEvent: @escaping ()->() = {}, onCancelEvent: @escaping ()->() = {}){
        
        let alert = AlertYesNo()
        if title != "" {
            alert.title = title
        }
        if text != "" {
            alert.text = text
        }
        if acceptTitle != "" {
            alert.acceptTitle = acceptTitle
        }
        if cancelTitle != "" {
            alert.cancelTitle = cancelTitle
        }
        if acceptColorBtn != nil {
            alert.acceptButtonColor = acceptColorBtn
        }
        if icon != nil {
            alert.icon = icon!
        }
        
        alert.onAcceptEvent = {
            onAcceptEvent()
        }
        alert.onCancelEvent = {
            onCancelEvent()
        }
        Observers.YesNoAlert(info: alert)
    }
    
    //case AcceptOnlyAlert
    public static func showAcceptOnly(title: String = "", text: String = "", icon: AlertIconType, cancelBtnColor: UIColor? = nil, cancelButtonName: String = "", acceptTitle: String = "", acceptBtnColor: UIColor? = nil, buttonName: String = "", onAcceptEvent: @escaping() -> Void, isEnabledLabelCopy: Bool = false) {
        let alert = AlertAcceptOnly();
        alert.title = title
        alert.icon = icon
        alert.onAcceptEvent = onAcceptEvent
        if title != "" {
            alert.title = title
        }
        if acceptTitle != "" {
            alert.acceptTitle = acceptTitle
        }
        if text != "" {
            alert.text = text
        }
        if acceptBtnColor != nil{
            alert.buttonColor = acceptBtnColor
        }
        if buttonName != "" {
            alert.buttonName = buttonName
        }
        alert.cancelButtonColor = cancelBtnColor
        alert.cancelButtonName = cancelButtonName
        alert.isEnabledLabelCopy = isEnabledLabelCopy
        
        Observers.AcceptOnlyAlert(info: alert)
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
        
        Observers.WebViewAlert(info: alert)
        
        
    }
    
    //case PlanDataDetailAlert
    public static func showPlanDataDetail(title: String = "", subtitle: String = "", includes: String = "", detallePlan: String = "", acceptTitle: String = "Aceptar", icon: AlertIconType = .NoIcon){
        
        let alert = PlanDetailAlertData();
        
        alert.title = title
        alert.subtitle = subtitle
        alert.includes = includes
        alert.text = detallePlan
        alert.acceptTitle = acceptTitle
        alert.icon = icon
            
            Observers.PlanDataDetailAlert(info: alert)
        
    }
    
    //case ShowWaitDialog
    public static func showWaitDialog(userEnabled: Bool = false){
        Observers.ShowWaitDialog(userEnabled: userEnabled)
    }
    
    //case HideWaitDialog
    public static func hideWaitDialog(){
        Observers.HideWaitDialog()
    }
    
    //case RefreshConfigurationFile
    
    
    //case FotoAlert
    public static func showFoto(title:String = "", acceptTitle:String = "Aceptar", nameProfile: String, abrirCamaraTitle:String = "", eliminarFotoTitle:String = "", cancelTitle:String = "", icon: AlertIconType = .NoIcon, onAcceptEvent: @escaping ()->() = {}, onCamaraEvent: @escaping ()->() = {}, onDeletePhotoEvent: @escaping ()->() = {}, onCancelEvent: @escaping ()->() = {}){
        
        let alert = AlertFoto();
        alert.title = title
        alert.acceptTitle = acceptTitle
        alert.abrirCamaraTitle = abrirCamaraTitle
        alert.eliminarFotoTitle = eliminarFotoTitle
        alert.cancelTitle = cancelTitle
        alert.icon = icon
        alert.nameProfile = nameProfile
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
        
        Observers.FotoAlert(info: alert)
        
        
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
        
//        PIPRNotificationCenter.default.post(name:Observers.ObserverList.AcceptOnlyAlertPasswordReq.name,
//        object: alert);
        
        //traer la informacion de alerta crear registros en entidades
        //se procede a borrar
        //appDelegate.killEntities()
        
    }
    
    
}

