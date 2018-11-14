//
//  Registro.swift
//  MiClaro
//
//  Created by Roberto Gutierrez Resendiz on 08/08/17.
//  Copyright © 2017 am. All rights reserved.
//

import UIKit
import ObjectMapper

/// Clase relacionada con la definición del archivo de configuración
class Registro: NSObject, Mappable {

    var confirmPrepaid : String?
    var header : String?
    var pinValidation : String?
    var pinValidationResendText : String?
    var registerFirstStep : String?
    var registerPrepaid : String?
    var registerPrepaidNumber : String?
    var registerSuccessText : String?
    var registerSuccessTitle : String?
    var registerThirdStep : String?
    var registerTyCFinal : String?
    var registerTyCFirst : String?
    var title : String?
    var tooltipDescription : String?
    var tooltipNew : String?
    var tooltipNewText : String?
    var tooltipOld : String?
    var tooltipOldText : String?
    var tooltipTitle : String?

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
        confirmPrepaid <- map["confirmPrepaid"]
        header <- map["header"]
        pinValidation <- map["pinValidation"]
        pinValidationResendText <- map["pinValidationResendText"]
        registerFirstStep <- map["registerFirstStep"]
        registerPrepaid <- map["registerPrepaid"]
        registerPrepaidNumber <- map["registerPrepaidNumber"]
        registerSuccessText <- map["registerSuccessText"]
        registerSuccessTitle <- map["registerSuccessTitle"]
        registerThirdStep <- map["registerThirdStep"]
        registerTyCFinal <- map["registerTyC_Final"]
        registerTyCFirst <- map["registerTyC_First"]
        title <- map["title"]
        tooltipDescription <- map["tooltipDescription"]
        tooltipNew <- map["tooltipNew"]
        tooltipNewText <- map["tooltipNewText"]
        tooltipOld <- map["tooltipOld"]
        tooltipOldText <- map["tooltipOldText"]
        tooltipTitle <- map["tooltipTitle"]
    }
}
