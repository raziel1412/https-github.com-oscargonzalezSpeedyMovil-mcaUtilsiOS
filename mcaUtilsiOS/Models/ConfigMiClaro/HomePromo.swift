//
//  HomePromo.swift
//  MiClaro
//
//  Created by Jonathan Abimael Cruz Orozco on 11/07/18.
//  Copyright © 2018 am. All rights reserved.
//

import Foundation
import ObjectMapper

class HomePromo: NSObject, Mappable {
    var promos: [Promos]?
    
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
        promos <- map["promos"]
    }
}
