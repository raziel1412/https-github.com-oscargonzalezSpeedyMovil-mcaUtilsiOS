//
//  CountriesRequest.swift
//  MiClaro
//
//  Created by Mauricio Javier Perez Flores on 9/26/17.
//  Copyright © 2017 am. All rights reserved.
//

import UIKit
import ObjectMapper

/// Clase que representa el Request utilizado para consumir el servicio Countries
class CountriesRequest: NSObject, Mappable {

    var token : String?
    var aplication : String?
    
    override init() {
        super.init()
    }
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map)
    {
        token <- map["token"]
        aplication <- map["aplicacion"]
    }
}
