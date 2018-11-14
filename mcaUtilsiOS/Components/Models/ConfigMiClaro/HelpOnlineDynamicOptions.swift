//
//  HelpOnlineDynamicOptions.swift
//  MiClaro
//
//  Created by Jorge Isai Garcia Reyes on 18/10/18.
//  Copyright © 2018 am. All rights reserved.
//

import UIKit
import ObjectMapper

class HelpOnlineDynamicOptions: NSObject, Mappable {
    
    var options : [Options]?
    
    required init?(map: Map) {
        
    }
    /// Funcion encargada de mapear el JSON en el array
    /// - parameter Map: Objeto de tipo Map
    func mapping(map: Map)
    {
        options <- map["options"]
    }
}
