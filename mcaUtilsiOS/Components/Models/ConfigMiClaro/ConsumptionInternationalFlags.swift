//
//  ConsumptionInternationalFlags.swift
//  MiClaro
//
//  Created by Jonathan Abimael Cruz Orozco on 03/09/18.
//  Copyright © 2018 am. All rights reserved.
//

import UIKit
import ObjectMapper

class ConsumptionInternationalFlags: NSObject, Mappable {
    
    var eightCountries : [FlagsCountry]?
    var threeCountries : [FlagsCountry]?
    
    required init?(map: Map) {
        
    }
    /// Funcion encargada de mapear el JSON en el array
    /// - parameter Map: Objeto de tipo Map
    func mapping(map: Map)
    {
        eightCountries <- map["eightCountries"]
        threeCountries <- map["threeCountries"]
    }
}
