//
//  CountryListResponse.swift
//  MiClaro
//
//  Created by Mauricio Javier Perez Flores on 9/27/17.
//  Copyright © 2017 am. All rights reserved.
//

import UIKit
import ObjectMapper

/// Clase que representa los datos del Response utilizado para consumir el servicio Countries
class CountryListResponse: NSObject, Mappable {
    
    var code : String?
    var enabled : Bool?
    var name : String?
    
    override init() {}
    
    required init?(map: Map) {}
    
    func mapping(map: Map)
    {
        code <- map["codigo"]
        enabled <- map["estado"]
        name <- map["nombre"]
        
    }
    
    
}
