//
//  FlagsCountry.swift
//  MiClaro
//
//  Created by Jonathan Abimael Cruz Orozco on 03/09/18.
//  Copyright © 2018 am. All rights reserved.
//

import Foundation
import ObjectMapper

class FlagsCountry: NSObject, Mappable {
    var flag : String?
    
    required init?(map: Map) {
        
    }
    /// Funcion encargada de mapear el JSON en el array
    /// - parameter Map: Objeto de tipo Map
    func mapping(map: Map)
    {
        flag <- map["flag"]
    }
}
