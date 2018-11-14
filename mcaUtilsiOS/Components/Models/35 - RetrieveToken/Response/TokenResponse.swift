//
//  TokenResponse.swift
//  MiClaro
//
//  Created by Mauricio Javier Perez Flores on 9/26/17.
//  Copyright © 2017 am. All rights reserved.
//

import UIKit
import ObjectMapper

/// Clase que representa el Response utilizado para consumir el servicio Token
class TokenResponse: NSObject, Mappable {

    var code : Int?
    var tokenDescription: String?
    var token: String?
    
    override init() {
        super.init()
    }
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map)
    {
        code <- map["codigo"]
        tokenDescription <- map["descripcion"]
        token <- map["token"]
    }

    
}
