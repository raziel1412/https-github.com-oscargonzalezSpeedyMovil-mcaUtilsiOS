//
//  LoginConfig.swift
//  MiClaro
//
//  Created by Roberto Gutierrez Resendiz on 08/08/17.
//  Copyright © 2017 am. All rights reserved.
//

import UIKit
import ObjectMapper

/// Clase relacionada con la definición del archivo de configuración
class LoginConfig: NSObject, Mappable {
    var help : String?
    var hint : String?
    var loginBtn : String?
    var password : String?
    var passwordRecovery : String?
    var registerBtn : String?
    var subtitle : String?
    var title : String?
    var user : String?
    var version : String?
    var copyright : String?
    var rememberRut : String?
    
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
        help <- map["help"]
        hint <- map["hint"]
        loginBtn <- map["loginBtn"]
        password <- map["password"]
        passwordRecovery <- map["passwordRecovery"]
        registerBtn <- map["registerBtn"]
        subtitle <- map["subtitle"]
        title <- map["title"]
        user <- map["user"]
        version <- map["version"]
        copyright <- map["copyright"]
        rememberRut <- map["rememberRut"]
    }
}
