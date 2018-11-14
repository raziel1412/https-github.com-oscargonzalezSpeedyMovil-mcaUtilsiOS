//
//  PasswordRecovery.swift
//  MiClaro
//
//  Created by Roberto Gutierrez Resendiz on 08/08/17.
//  Copyright © 2017 am. All rights reserved.
//

import UIKit
import ObjectMapper

/// Clase relacionada con la definición del archivo de configuración
class PasswordRecovery: NSObject, Mappable {

    var RUT : String?
    var header : String?
    var pinValidation : String?
    var recoveryFirstStep : String?
    var recoverySuccessTitle : String?
    var recoveryThirdStep : String?
    var registerTyCFinal : String?
    var registerTyCFirst : String?
    var rutHint : String?
    var title : String?

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
        RUT <- map["RUT"]
        header <- map["header"]
        pinValidation <- map["pinValidation"]
        recoveryFirstStep <- map["recoveryFirstStep"]
        recoverySuccessTitle <- map["recoverySuccessTitle"]
        recoveryThirdStep <- map["recoveryThirdStep"]
        registerTyCFinal <- map["registerTyC_Final"]
        registerTyCFirst <- map["registerTyC_First"]
        rutHint <- map["rutHint"]
        title <- map["title"]
    }
}
