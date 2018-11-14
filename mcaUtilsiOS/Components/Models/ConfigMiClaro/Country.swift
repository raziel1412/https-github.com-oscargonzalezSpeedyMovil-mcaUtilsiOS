//
//	Country.swift
//	Model file Generated using:
//	Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport
//	(forked from Ahmed-Ali's JSONExport)
//

import Foundation
import ObjectMapper

/// Clase relacionada con la definición del archivo de configuración
class Country : NSObject, Mappable{
    
    var code : String?
    var currency : String?
    var name : String?
    var phoneCountryCode : String?
    var userProfileIdConfig : UserProfileIdConfig?

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
        code <- map["code"]
        currency <- map["currency"]
        name <- map["name"]
        phoneCountryCode <- map["phoneCountryCode"]
        userProfileIdConfig <- map["userProfileIdConfig"]
    }
}
