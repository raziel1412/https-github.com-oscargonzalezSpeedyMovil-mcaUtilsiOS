//
//  Account.swift
//  MiClaro
//
//  Created by Mauricio Javier Perez Flores on 9/26/17.
//  Copyright © 2017 am. All rights reserved.
//

import UIKit
import ObjectMapper

/// Clase que representa los datos del Request utilizado para consumir el servicio Token
class Account: NSObject, Mappable {

    var user : String?
    var password : String?

    override init() {
        super.init()
    }
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        user <- map["usuario"]
        password <- map["contrasenia"]
    }
    
}
