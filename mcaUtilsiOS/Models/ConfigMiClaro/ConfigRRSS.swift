//
//  ConfigRRSS.swift
//  MiClaro
//
//  Created by Roberto Gutierrez Resendiz on 27/07/18.
//  Copyright © 2018 am. All rights reserved.
//

import Foundation
import ObjectMapper

/// Clase relacionada con la definición del archivo de configuración
class ConfigRRSS: NSObject, Mappable {

    var idRRSS : Int?
    var nombre : String?
    var apiVersion : String?
    var appVersion : String?
    var configFileLifeTime : String?
    var context : String?
    var googleAPIKey : String?
    var https : Bool?
    var languagePreferences : String?
    var port : String?
    var pushTime : String?
    var reviewTime : String?
    var scope : String?
    var secret : String?
    var timeout : String?
    var token : String?
    var triesForPasswordRecovery : Int?
    var url : String?

    override init() {

    }

    /// Función encargada de mapear el JSON correspondiente
    /// - parameter Map: Objeto de tipo Map
    required init?(map: Map) {

    }

    /// Función encargada de mapear el JSON correspondiente
    /// - parameter Map: Objeto de tipo Map
    func mapping(map: Map)
    {
        idRRSS <- map["idRRSS"]
        nombre <- map["nombre"]
        apiVersion <- map["apiVersion"]
        appVersion <- map["appVersion"]
        configFileLifeTime <- map["configFileLifeTime"]
        context <- map["context"]
        googleAPIKey <- map["googleAPIKey"]
        https <- map["https"]
        languagePreferences <- map["languagePreferences"]
        port <- map["port"]
        pushTime <- map["pushTime"]
        reviewTime <- map["reviewTime"]
        scope <- map["scope"]
        secret <- map["secret"]
        timeout <- map["timeout"]
        token <- map["token"]
        triesForPasswordRecovery <- map["triesForPasswordRecovery"]
        url <- map["url"]
    }
}
