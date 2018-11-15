//
//  Rule.swift
//  MiClaro
//
//  Created by Roberto Gutierrez Resendiz on 08/08/17.
//  Copyright © 2017 am. All rights reserved.
//

import UIKit
import ObjectMapper

/// Clase relacionada con la definición del archivo de configuración
class Rule: NSObject, Mappable {

    var mandatoryFields : MandatoryField?
    var mobileNumberRules : MobileNumberRule?
    var passwordRules : PasswordRule?
    var profile : Profile?

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
        mandatoryFields <- map["mandatoryFields"]
        mobileNumberRules <- map["mobileNumberRules"]
        passwordRules <- map["passwordRules"]
        profile <- map["profile"]
    }
}
