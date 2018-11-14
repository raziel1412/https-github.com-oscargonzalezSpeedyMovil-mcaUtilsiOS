//
//  RRSSOption.swift
//  MiClaro
//
//  Created by Jorge Isai Garcia Reyes on 18/10/18.
//  Copyright © 2018 am. All rights reserved.
//

import Foundation
import ObjectMapper

class RRSSOption: NSObject, Mappable {
    var rrssHelpIcon : String?
    var rrssHelpName : String?
    var rrssHelpUrl : String?
    
    required init?(map: Map) {
        
    }
    /// Funcion encargada de mapear el JSON en el array
    /// - parameter Map: Objeto de tipo Map
    func mapping(map: Map)
    {
        rrssHelpIcon <- map["rrssHelpIcon"]
        rrssHelpName <- map["rrssHelpName"]
        rrssHelpUrl <- map["rrssHelpUrl"]

    }
}
