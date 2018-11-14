//
//  MandatoryField.swift
//  MiClaro
//
//  Created by Roberto Gutierrez Resendiz on 08/08/17.
//  Copyright © 2017 am. All rights reserved.
//

import UIKit
import ObjectMapper

/// Clase relacionada con la definición del archivo de configuración
class MandatoryField: NSObject, Mappable {

    var associateServiceNumber : Bool?
    var loginPassword : Bool?
    var loginUser : Bool?
    var passwordRecoveryPassword : Bool?
    var passwordRecoveryPin : Bool?
    var registerPassword : Bool?
    var registerPin : Bool?
    var registerPrepaidNumber : Bool?

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
        associateServiceNumber <- map["associateServiceNumber"]
        loginPassword <- map["loginPassword"]
        loginUser <- map["loginUser"]
        passwordRecoveryPassword <- map["passwordRecoveryPassword"]
        passwordRecoveryPin <- map["passwordRecoveryPin"]
        registerPassword <- map["registerPassword"]
        registerPin <- map["registerPin"]
        registerPrepaidNumber <- map["registerPrepaidNumber"]
    }
}
