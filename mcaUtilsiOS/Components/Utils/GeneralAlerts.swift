//
//  GeneralAlerts.swift
//  MiClaro
//
//  Created by Roberto on 11/21/18.
//  Copyright © 2018 am. All rights reserved.
//
import Foundation
import UIKit
import mcaManageriOS

public class GeneralAlerts {
    
    //case YesNoAlert
    
    private init() {
    }
    
    static func showYesNo(title: String, text: String, acceptTitle: String, cancelTitle: String, icon: AlertIconType, acceptColorBtn: UIColor, onAcceptEvent: @escaping ()->(), onCancelEvent: @escaping ()->()){
        
        let alert = AlertYesNo();
        alert.title = title
        alert.text = text
        alert.acceptTitle = acceptTitle
        alert.cancelTitle = cancelTitle
        alert.acceptButtonColor = acceptColorBtn
        alert.icon = icon
        
        alert.onAcceptEvent = {
            onAcceptEvent()
        };
        alert.onCancelEvent = {
            onCancelEvent()
        };
        
        NotificationCenter.default.post(name: Observers.ObserverList.YesNoAlert.name,
                                        object: alert);
    }
    
    //case AcceptOnlyAlert
    static func showAcceptOnly(title: String, text: String, acceptTitle: String, icon: AlertIconType, onAcceptEvent: @escaping ()->()){
        
        let alert = AlertAcceptOnly();
        alert.title = title
        alert.text = text
        alert.icon = icon
        alert.acceptTitle = acceptTitle
        alert.onAcceptEvent = {
            onAcceptEvent()
        }
        
        NotificationCenter.default.post(name: Observers.ObserverList.AcceptOnlyAlert.name, object: alert);
    }
    
    //case WebViewAlertData
    static func showDataWebView(title: String, url: String, method: String, acceptTitle: String, onAcceptEvent: @escaping ()->()){
        
        let alert = WebViewAlertData();
        alert.method = method
        alert.url = url
        alert.title = title
        alert.acceptTitle = acceptTitle
        alert.onAcceptEvent = {
            onAcceptEvent()
        }
        NotificationCenter.default.post(name: Observers.ObserverList.WebViewAlert.name,
                                        object: alert);
        
    }
    
    //case PlanDataDetailAlert
    static func showPlanDataDetail(title: String, subtitle: String, includes: String, detallePlan: String, acceptTitle: String, icon: AlertIconType){
        
        let alert = PlanDetailAlertData();
        
        alert.title = title//conf?.translations?.data?.updatePlan?.actualPlanDetail ?? "";
        alert.subtitle = subtitle//nombrePlan;
        alert.includes = includes//conf?.translations?.data?.updatePlan?.planIncludes ?? "";
        alert.text = detallePlan//detallePlan;
        alert.acceptTitle = acceptTitle//conf?.translations?.data?.generales?.closeBtn ?? "";
        alert.icon = icon//.IconoAlertaInformacion;
        
        NotificationCenter.default.post(name: Observers.ObserverList.PlanDataDetailAlert.name,
                                        object: alert);
    }
    
    //case ShowWaitDialog
    static func showWaitDialog(){
        NotificationCenter.default.post(name: Observers.ObserverList.ShowWaitDialog.name, object: nil);
    }
    
    //case HideWaitDialog
    static func hideWaitDialog(){
        NotificationCenter.default.post(name: Observers.ObserverList.HideWaitDialog.name, object: nil);
    }
    
    //case ShowOfflineMessage
    //case RefreshConfigurationFile
    
    
    //case FotoAlert
    static func showFoto(title:String, acceptTitle:String, abrirCamaraTitle:String, eliminarFotoTitle:String, cancelTitle:String, icon: AlertIconType, onAcceptEvent: @escaping ()->(), onCamaraEvent: @escaping ()->(), onDeletePhotoEvent: @escaping ()->(), onCancelEvent: @escaping ()->()){
        
        let alert = AlertFoto();
        alert.title = title
        alert.acceptTitle = acceptTitle
        alert.abrirCamaraTitle = abrirCamaraTitle
        alert.eliminarFotoTitle = eliminarFotoTitle
        alert.cancelTitle = cancelTitle
        alert.icon = icon
        
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
        
        NotificationCenter.default.post(name: Observers.ObserverList.FotoAlert.name,
                                        object: alert)
        
        
    }
    
    //case UpdateAppAlert
    static func UpdateApp(){
        
    }
    
    //case AcceptOnlyAlertPasswordReq
    static func showAcceptOnlyPassword(title:String, text:String, userEmail:String, userPhone:String, acceptTitle:String, icon: AlertIconType, acceptColorBtn: UIColor, onAcceptEvent: @escaping ()->()){
        
        //let appDelegate = UIApplication.shared.delegate as! AppDelegate;
        
        let alertInfo = AlertAcceptOnlyPasswordReq();
        alertInfo.userEmail = userEmail.maskAsEmail()
        alertInfo.userPhone = userPhone.maskAsPhone()
        alertInfo.text = text
        alertInfo.title = title
        alertInfo.icon = icon
        alertInfo.buttonName = acceptTitle
        alertInfo.buttonColor = acceptColorBtn
        alertInfo.onAcceptEvent = {
            onAcceptEvent()
        }
        
        NotificationCenter.default.post(name: Observers.ObserverList.AcceptOnlyAlertPasswordReq.name,
                                        object: alertInfo);
        //traer la informacion de alerta crear registros en entidades
        //se procede a borrar
        //appDelegate.killEntities()
        
    }
    
    
}

