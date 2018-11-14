//
//  PasswordRule.swift
//  MiClaro
//
//  Created by Roberto Gutierrez Resendiz on 08/08/17.
//  Copyright © 2017 am. All rights reserved.
//

import UIKit
import ObjectMapper

/// Clase relacionada con la definición del archivo de configuración
class PasswordRule: NSObject, Mappable {
    var passwordAllowedSymbols : String?
    var passwordMaxLength : String?
    var passwordMinLength : String?
    var passwordRequiresNumbers : Bool?
    var passwordRequiresUppercase : Bool?

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
        passwordAllowedSymbols <- map["password_allowed_symbols"]
        passwordMaxLength <- map["password_max_length"]
        passwordMinLength <- map["password_min_length"]
        passwordRequiresNumbers <- map["password_requires_numbers"]
        passwordRequiresUppercase <- map["password_requires_uppercase"]
    }
}
