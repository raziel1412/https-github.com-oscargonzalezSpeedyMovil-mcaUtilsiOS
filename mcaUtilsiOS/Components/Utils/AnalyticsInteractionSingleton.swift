//
//  AnalyticsInteractionSingleton.swift
//  MiClaro
//
//  Created by Jorge Isai Garcia Reyes on 20/07/18.
//  Copyright © 2018 am. All rights reserved.
//

import UIKit
import mcaManageriOS

public class AnalyticsInteractionSingleton {
    static let sharedInstance = AnalyticsInteractionSingleton();
    var timer: Timer;
    var counter: Int;
    
    //var accountArray: [ServiceAccount] = [ServiceAccount]()
    //var arraySummary: [CardsSummaryModel] = [CardsSummaryModel]()
    
    //MARK:temporalmente
    var accountArray: [String] = [String]()
    var arraySummary: [String] = [String]()
    
    private init() {
        timer = Timer.init()
        counter = 0
    }
    //MARK: Funcion que obtiene parametros base para Analitycs
    func getBaseParams() -> NSMutableDictionary{
        
        ADBMobile.collectLifecycleData()
        
        let contextData = NSMutableDictionary()
        
        var countryCode = ""
        var perfilUser: String = ""
        var userId : String = ""
        
        let conf = mcaManagerSession.getGeneralConfig()
        if conf != nil{
            countryCode = (conf?.country?.code)!
            
            if countryCode == "CL"{
                countryCode = "Chile"
            }
        }
        
        let logSession = mcaManagerSession.getSession()
        var statusLogin: String = "No logueado"
        
        if(logSession != nil){
            
            statusLogin = "Logueado"
            
            if(accountArray.count == 0){
                if let accArray = mcaManagerSession.getFullAccountData(){
                    //MARK:temporalmente
                    //accountArray = accArray
                }
            }
            if(accountArray.count != 0){
                
                //MARK:temporalmente
                //let accountSummary = AccountManagement.init(arrayServices: accountArray)
                if(arraySummary.count == 0){
                    //MARK:temporalmente
                    //arraySummary = accountSummary.getSummaryAccount()
                }
                
                var hasMovilPre: Bool = false
                var hasMovilPos: Bool = false
                var hasTelevision: Bool = false
                //            var hasFijo: Bool = false
                var hasTodoClaro: Bool = false
                var hasInternet: Bool = false
                
                for summary in arraySummary {
                    //MARK:temporalmente
                    /*
                    if (summary.typeAccount == .MovilPrepago) {
                        hasMovilPre = true
                    }
                    if ( summary.typeAccount == .MovilPospago) {
                        hasMovilPos = true
                    }
                    if summary.typeAccount == .Television {
                        hasTelevision = true
                    }
                    if summary.typeAccount == .TodoClaro {
                        hasTodoClaro = true
                    }
                    if summary.typeAccount == .Internet {
                        hasInternet = true
                    }
                    */
                }
                
                if(hasMovilPre){
                    
                    if(perfilUser != ""){
                        perfilUser.append("|Movil Prepago")
                    }
                    else{
                        perfilUser.append("Movil Prepago")
                    }
                }
                if(hasMovilPos){
                    if(perfilUser != ""){
                        perfilUser.append("|Movil Pospago")
                    }
                    else{
                        perfilUser.append("Movil Pospago")
                    }
                }
                if(hasTelevision){
                    if(perfilUser != ""){
                        perfilUser.append("|Television")
                    }
                    else{
                        perfilUser.append("Television")
                    }
                }
                if(hasTodoClaro){
                    if(perfilUser != ""){
                        perfilUser.append("|Todo Claro")
                    }
                    else{
                        perfilUser.append("Todo Claro")
                    }
                }
                if(hasInternet){
                    if(perfilUser != ""){
                        perfilUser.append("|Internet")
                    }
                    else{
                        perfilUser.append("Internet")
                    }
                }
            }
            
            userId = (logSession?.retrieveProfileInformationResponse?.personalDetailsInformation?.rUT) ?? ""
        }
        var fechaHora: String = ""
        
        let date = Date()
        let formatter = DateFormatter()
        
        let day = self.loadDayName(forDate: date)
        
        formatter.dateFormat = "HH"
        let hora = formatter.string(from: date)
        fechaHora = day + "|" + hora + ":00"
        
        contextData.setValue(fechaHora, forKey :"appmc.general.fechaHora")
        contextData.setValue(perfilUser, forKey :"appmc.general.perfilUsuario")
        contextData.setValue(countryCode, forKey :"appmc.general.pais")
        contextData.setValue(userId, forKey :"appmc.general.userId")
        contextData.setValue(statusLogin, forKey :"appmc.general.estatusLogin")
        
        return contextData
    }
    //Funcion simple para el envio de vista a analytics
    func ADBTrackView(viewName:String, detenido:Bool, mensaje:String? = ""){
        var contextData = NSMutableDictionary()
        
        if(viewName == "Sector Ubicacion"){
            
            var fechaHora: String = ""
            
            let date = Date()
            let formatter = DateFormatter()
            
            let day = self.loadDayName(forDate: date)
            
            formatter.dateFormat = "HH"
            let hora = formatter.string(from: date)
            fechaHora = day + "|" + hora + ":00"
            
            contextData.setValue(fechaHora, forKey :"appmc.general.fechaHora")
            contextData.setValue("", forKey :"appmc.general.perfilUsuario")
            contextData.setValue("", forKey :"appmc.general.pais")
            contextData.setValue("", forKey :"appmc.general.userId")
            contextData.setValue("No logueado", forKey :"appmc.general.estatusLogin")
            
        }else{
            contextData = getBaseParams()
        }
        
        
        if(detenido){
            contextData.setValue(mensaje, forKey :"appmc.detenidos.mensaje")
        }
        if(viewName == "Home"){
            contextData.setValue("1", forKey :"appmc.se.home")
        }
        if viewName == "Alerta"{
            contextData.setValue("1", forKey : "appmc.se.alerta")
            contextData.setValue(mensaje, forKey : "appmc.alerta.mensaje")
        }
        
        print(viewName)
        print(contextData)
        ADBMobile.trackState(viewName, data: contextData as? [AnyHashable : Any])
    }
    
    //MARK: Flujo - Soporte
    func ADBTrackViewSoporte(viewName : String, message : String = "") {
        let contextData = getBaseParams()
        
        if viewName == "Soporte|Reportar fallas"{
            contextData.setValue("1", forKey : "appmt.se.reporteFallas")
        }
        if viewName == "Soporte|Reportar fallas|Exito"{
            contextData.setValue("1", forKey : "appmt.se.reporteFallasExito")
            if message != "" {
                contextData.setValue(message, forKey: "appmc.soporte.fallasReportadas")
            }
        }
        if viewName == "Soporte|Sugerencias"{
            
            if message != "" {
                contextData.setValue("1", forKey : "appmt.se.reporteSugerencias")
                contextData.setValue(message, forKey: "appmc.soporte.sugerenciasRealizadas")
            }
        }
        
        if viewName == "Soporte|Sugerencias|Exito"{
            contextData.setValue("1", forKey : "appmt.se.reporteSugerenciasExito")
            contextData.setValue(message, forKey : "appmc.soporte.sugerenciasRealizadas")
        }
        
        print(viewName)
        ADBMobile.trackState(viewName, data: contextData as? [AnyHashable : Any])
        print("ADBTrackViewSoporte \(viewName, contextData)")
    }
    
    //MARK: - Flujo - Mis Facturas (Mis boletas)
    func ADBTrackViewMenuBoletas(viewName : String){
        let contextData = getBaseParams()
        
        print(viewName)
        print("ADBTrackViewMenuBoletas \(viewName, contextData)")
        ADBMobile.trackState(viewName, data: contextData as? [AnyHashable : Any])
    }
    
    func ADBTrackViewBoletas(type :  String, viewName : String, nombreServicio : String, detalleServicio : String, fechaVencimiento : String, estatus : String, saldo : String){
        
        let contextData = getBaseParams()
        let typeValue = type
        switch typeValue {
        case "1":
            contextData.setValue("1", forKey : "appmc.se.facturasMovil")
        case "3":
            contextData.setValue("1", forKey : "appmc.se.facturasTelFijo")
        case "4":
            contextData.setValue("1", forKey : "appmc.se.facturasTelevision")
        case "5":
            contextData.setValue("1", forKey : "appmc.se.facturasInternet")
        default:
            break
        }
        contextData.setValue(nombreServicio, forKey : "appmc.misServicios.nombreServicio")
        contextData.setValue(detalleServicio, forKey :"appmc.misServicios.detalleServicio")
        contextData.setValue(fechaVencimiento, forKey :"appmc.misServicios.fechaVencimiento")
        contextData.setValue(estatus, forKey :"appmc.misServicios.estatus")
        contextData.setValue(saldo, forKey :"appmc.misServicios.saldo")
        
        print(viewName)
        print("ADBTrackViewBoletas \(contextData)")
        ADBMobile.trackState(viewName, data: contextData as? [AnyHashable : Any])
    }
    
    func ADBTrackViewActivarBoletas(viewName : String, type :  String, message :  String  = ""){
        let contextData = getBaseParams()
        let typeValue = type
        switch typeValue {
        case "Confirmacion":
            contextData.setValue("1", forKey : "appmc.se.activarPaperlessP1")
        case "Solicitar":
            contextData.setValue("1", forKey: "appmc.se.activarPaperlessP2")
        case "Detenido":
            contextData.setValue("1", forKey: "appmc.se.activarPaperlessP2Detenido")
            contextData.setValue(message, forKey: "appmc.detenidos.mensaje")
        case "Exito":
            contextData.setValue("1", forKey: "appmc.se.activarPaperlessExito")
        default:
            break
        }
        
        print(viewName)
        print("ADBTrackViewActivarBoletas \(contextData)")
        ADBMobile.trackState(viewName, data: contextData as? [AnyHashable : Any])
    }
    
    //MARK: Flujo - Registro
    // Pantallas Registro
    func ADBTrackViewRegistro(viewName:String, type:Int? = 1, detenido:Bool, mensaje:String? = ""){
        
        let contextData = getBaseParams()
        
        switch type {
        case 1:
            if(detenido){
                contextData.setValue("1", forKey :"appmc.se.registroP1Detenido")
            }else{
                contextData.setValue("1", forKey :"appmc.se.registroP1")
            }
            break
        case 2:
            contextData.setValue("1", forKey :"appmc.se.registroP2")
            break
        case 3:
            contextData.setValue("1", forKey :"appmc.se.registroP3")
            break
        case 4:
            contextData.setValue("1", forKey :"appmc.se.registroP4")
            break
        case 5:
            if(detenido){
                contextData.setValue("1", forKey :"appmc.se.registroP5Detenido")
            }else{
                contextData.setValue("1", forKey :"appmc.se.registroP5")
            }
        case 6:
            contextData.setValue("1", forKey :"appmc.se.registroExito")
            break
        default:
            break
        }
        
        if(detenido){
            contextData.setValue(mensaje, forKey :"appmc.detenidos.mensaje")
        }
        
        print(viewName)
        print(contextData)
        ADBMobile.trackState(viewName, data: contextData as? [AnyHashable : Any])
    }
    // Pantallas recuperar Contraseña
    func ADBTrackViewRecoveryPass(viewName:String, type:Int? = 0, detenido:Bool, mensaje:String? = "", intervalo:String? = ""){
        
        let contextData = getBaseParams()
        
        switch type {
        case 1:
            if(detenido){
                contextData.setValue("1", forKey :"appmc.se.recuperaContrasenaP1Detenido")
            }else{
                contextData.setValue("1", forKey :"appmc.se.recuperaContrasenaP1")
            }
            break
        case 2:
            contextData.setValue("1", forKey :"appmc.se.recuperaContrasenaP2")
            break
        case 3:
            contextData.setValue("1", forKey :"appmc.se.recuperaContrasenaP3")
            contextData.setValue(intervalo, forKey :"appmc.general.intervaloSms")
            break
        case 4:
            contextData.setValue("1", forKey :"appmc.se.recuperaContrasenaP4")
            break
        case 5:
            contextData.setValue("1", forKey :"appmc.se.recuperaContrasenaExito")
            break
        default:
            break
        }
        
        if(detenido){
            contextData.setValue(mensaje, forKey :"appmc.detenidos.mensaje")
        }
        
        print(viewName)
        print(contextData)
        ADBMobile.trackState(viewName, data: contextData as? [AnyHashable : Any])
    }
    //MARK: Flujo - Mi Perfil
    // Pantallas Mi Perfil
    func ADBTrackViewMiPerfil(viewName:String, type:Int? = 1){
        
        let contextData = getBaseParams()
        switch type {
        case 1:
            contextData.setValue("1", forKey :"appmc.se.cambioContrasenaP1")
            break
        case 2:
            contextData.setValue("1", forKey :"appmc.se.cambioContrasenaP2")
            break
        case 3:
            contextData.setValue("1", forKey :"appmc.se.cambioContrasenaExito")
            break
        default:
            break
        }
        
        print(viewName)
        print(contextData)
        ADBMobile.trackState(viewName, data: contextData as? [AnyHashable : Any])
    }
    
    func ADBTrackViewServicios(viewName : String, type :  String, nombreServicio : String, detalleServicio : String, fechaVencimiento : String, estatus : String, saldo : String){
        
        let strfechaVencimiento = fechaVencimiento.replacingOccurrences(of: "/", with: "|")
        
        let contextData = getBaseParams()
        let typeValue = type
        switch typeValue {
        case "1":
            contextData.setValue("1", forKey : "appmc.se.misServiciosMovil")
        case "2":
            contextData.setValue("1", forKey : "appmc.se.misServiciosTodoClaro")
        case "3":
            contextData.setValue("1", forKey : "appmc.se.misServiciosTelFijo")
        case "4":
            contextData.setValue("1", forKey : "appmc.se.misServiciosTelevision")
        case "5":
            contextData.setValue("1", forKey : "appmc.se.misServiciosInternet")
        default:
            break
        }
        contextData.setValue(nombreServicio, forKey : "appmc.misServicios.nombreServicio")
        contextData.setValue(detalleServicio, forKey :"appmc.misServicios.detalleServicio")
        contextData.setValue(strfechaVencimiento, forKey :"appmc.misServicios.fechaVencimiento")
        contextData.setValue(estatus, forKey :"appmc.misServicios.estatus")
        contextData.setValue(saldo, forKey :"appmc.misServicios.saldo")
        
        print(viewName)
        print("ADBTrackViewServicios \(contextData)")
        ADBMobile.trackState(viewName, data: contextData as? [AnyHashable : Any])
    }
    
    func ADBTrackViewServicioPrepago(viewName : String, type :  String, detenido:Bool, mensaje:String? = "", intervalo:String? = ""){
        
        let contextData = getBaseParams()
        
        let typeValue = type
        switch typeValue {
        case "1":
            if(detenido){
                contextData.setValue("1", forKey :"appmc.se.agregarPrepagoP1Detenido")
                contextData.setValue(mensaje, forKey :"appmc.detenidos.mensaje")
            }else{
                contextData.setValue("1", forKey : "appmc.se.agregarPrepagoP1")
            }
        case "2":
            contextData.setValue("1", forKey : "appmc.se.agregarPrepagoP2")
        case "3":
            contextData.setValue("1", forKey : "appmc.se.agregarPrepagoP3")
        case "4":
            contextData.setValue("1", forKey : "appmc.se.agregarPrepagoP4")
            contextData.setValue(intervalo, forKey :"appmc.general.intervaloSms")
        case "5":
            contextData.setValue("1", forKey : "appmc.se.agregarPrepagoExito")
        default:
            break
        }
        
        print(viewName)
        print("ADBTrackViewServicioPrepago \(contextData)")
        ADBMobile.trackState(viewName, data: contextData as? [AnyHashable : Any])
    }
    
    func loadDayName(forDate date: Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat  = "EEEE"//"EE" to get short style
        //        let dayInWeek = dateFormatter.string(from: date as Date)//"Sunday"
        
        let weekDay = Calendar.current.component(.weekday, from: Date())
        
        switch weekDay {
        case 1:
            return "Domingo"
        case 2:
            return "Lunes"
        case 3:
            return "Martes"
        case 4:
            return "Miercoles"
        case 5:
            return "Jueves"
        case 6:
            return "Viernes"
        case 7:
            return "Sabado"
        default:
            return "Nada"
        }
        //        return dayInWeek
    }
    
    func initTimer(){
        counter = 0
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        RunLoop.current.add(timer, forMode: RunLoopMode.commonModes)
    }
    
    @objc func updateTimer(){
        counter+=1
        print(counter)
    }
    
    func stopTimer() -> String{
        //reglas
        //        0:00 a 2:00 mins / 2:01 a 5:00 mins / 5:01 a 10:00 mins
        //        10:01 a 15:00 mins / 15:01 en adelante
        
        timer.invalidate()
        
        var intervaloSMS = ""
        
        if(counter>0 && counter<=120){
            intervaloSMS = "0:00 a 2:00 mins"
        }
        else if(counter>121 && counter<=300){
            intervaloSMS = "2:01 a 5:00 mins"
        }
        else if(counter>301 && counter<=600){
            intervaloSMS = "5:01 a 10:00 mins"
        }
        else if(counter>601 && counter<=900){
            intervaloSMS = "5:01 a 10:00 mins"
        }
        else if(counter>901){
            intervaloSMS = "15:01 en adelante"
        }
        
        return intervaloSMS
    }
    
    //Actions
    
    func ADBTrackCustomLink(viewName:String){
        
        let contextData = getBaseParams()
        
        print(viewName)
        print(contextData)
        ADBMobile.trackAction(viewName, data: contextData as? [AnyHashable : Any])
    }
    
    func cleanAccountArrays(){
        accountArray.removeAll()
        arraySummary.removeAll()
    }
}

