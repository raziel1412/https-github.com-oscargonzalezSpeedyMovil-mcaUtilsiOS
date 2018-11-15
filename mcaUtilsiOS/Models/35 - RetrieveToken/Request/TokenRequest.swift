//
//  TokenRequest.swift
//  MiClaro
//
//  Created by Mauricio Javier Perez Flores on 9/26/17.
//  Copyright © 2017 am. All rights reserved.
//

import UIKit
import ObjectMapper

/// Clase que representa el Request utilizado para consumir el servicio Token
class TokenRequest: NSObject, Mappable {

    var account : Account?
    var uuid : String?
    var phone : String?
    
    override init() {
        super.init()
        account = Account()
    }
    
    required init?(map: Map) {
    }
    
   func mapping(map: Map)
    {
        account <- map["cuenta"]
        uuid <- map["uuid"]
        phone <- map["telefono"]
    }
    
}
