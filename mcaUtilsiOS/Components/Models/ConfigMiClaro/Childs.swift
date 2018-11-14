//
//  Childs.swift
//  MiClaro
//
//  Created by Omar Israel Trujillo Osornio on 04/07/18.
//  Copyright © 2018 am. All rights reserved.
//

import Foundation
import ObjectMapper

/// Clase relacionada con la definición del archivo de configuración
class Childs : NSObject, Mappable{
    
    var childOrder : Int?
    var childCode : String?
    var childText : String?
    var childImage : String?
    var childStatus : Int?

    
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
        childOrder <- map["childOrder"]
        childCode <- map["childCode"]
        childText <- map["childText"]
        childImage <- map["childImage"]
        childStatus <- map["childStatus"]

    }
}

