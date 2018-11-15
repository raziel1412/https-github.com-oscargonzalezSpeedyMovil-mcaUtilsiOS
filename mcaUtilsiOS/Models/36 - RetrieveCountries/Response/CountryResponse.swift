//
//  CountryResponse.swift
//  MiClaro
//
//  Created by Mauricio Javier Perez Flores on 9/27/17.
//  Copyright © 2017 am. All rights reserved.
//

import UIKit
import ObjectMapper

/// Clase que representa el Response utilizado para consumir el servicio Countries
class CountryResponse: NSObject, Mappable {
    
    var code : Int?
    var countryDescription : String?
    var countryList : [CountryListResponse]?
    
    override init() {}
    required init?(map: Map) {
    }
    func mapping(map: Map)
    {
        code <- map["codigo"]
        countryDescription <- map["descripcion"]
        countryList <- map["paises"]
    }
}
