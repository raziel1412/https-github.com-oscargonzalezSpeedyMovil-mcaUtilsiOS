//
//  Promos.swift
//  MiClaro
//
//  Created by Jonathan Abimael Cruz Orozco on 11/07/18.
//  Copyright © 2018 am. All rights reserved.
//

import Foundation
import ObjectMapper

class Promos: NSObject, Mappable {
    var imgUrl: String = ""
    var linkUrl: String = ""
    
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
        imgUrl <- map["imgUrl"]
        linkUrl <- map["linkUrl"]
    }
}
