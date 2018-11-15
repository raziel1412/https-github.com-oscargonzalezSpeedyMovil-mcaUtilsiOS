//
//  FeatureRemainder.swift
//  MiClaro
//
//  Created by Jonathan Abimael Cruz Orozco on 03/09/18.
//  Copyright © 2018 am. All rights reserved.
//

import Foundation
import ObjectMapper

class FeatureRemainder: NSObject,Mappable {
    var quantity = 0.0
    var unit : String?
    
    override init() {
        
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map)
    {
        quantity <- (map["Quantity"])
        unit <- map["Unit"]
        
    }
}
