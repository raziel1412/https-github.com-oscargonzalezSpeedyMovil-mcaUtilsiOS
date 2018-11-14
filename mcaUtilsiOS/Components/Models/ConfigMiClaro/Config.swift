//
//	Config.swift
//	Model file Generated using:
//	Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport
//	(forked from Ahmed-Ali's JSONExport)
//

import Foundation
import ObjectMapper

/// Clase relacionada con la definición del archivo de configuración
class Config : NSObject, Mappable{
    
    var https : Bool?
    var port : String?
    var pushTime : String?
    var reviewTime : String?
    var token : String?
    var url : String?
    var context : String?
    var scope : String?
    var secret : String?
    var languagePreferences : String?
    var apiVersion : String?
    var appVersion : String?
    var timeout : String?
    var googleAPIKey : String?
    var configFileLifeTime : String?
    var triesForPasswordRecovery : Int?

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
