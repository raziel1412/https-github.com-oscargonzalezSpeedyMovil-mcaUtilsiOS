//
//  countryList.swift
//  MiClaro
//
//  Created by Omar Israel Trujillo Osornio on 28/08/17.
//  Copyright © 2017 am. All rights reserved.
//

import UIKit
import ObjectMapper

/// Clase relacionada con la definición del archivo de configuración
class CountryList: NSObject, Mappable {
    var code : String?
    var enabled : Bool?
    var name : String?
    
    override init() {}
    
    /// Función encargada de mapear el JSON correspondiente
    /// - parameter Map: Objeto de tipo Map
    required init?(map: Map) {}
    
    /// Función encargada de mapear el JSON correspondiente
    /// - parameter Map: Objeto de tipo Map
    func mapping(map: Map) {
        code <- map["code"]
        enabled <- map["enabled"]
        name <- map["name"]
    }
}
