//
//  Paperles.swift
//  MiClaro
//
//  Created by Roberto Gutierrez Resendiz on 08/08/17.
//  Copyright © 2017 am. All rights reserved.
//

import UIKit
import ObjectMapper

/// Clase relacionada con la definición del archivo de configuración
class Paperles: NSObject, Mappable {

    var anotherEmail : String?
    var header : String?
    var mailTo : String?
    var paperlessActivate : String?
    var paperlessDescription : String?
    var successOperation : String?
    var yourBill : String?

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
        anotherEmail <- map["anotherEmail"]
        header <- map["header"]
        mailTo <- map["mailTo"]
        paperlessActivate <- map["paperlessActivate"]
        paperlessDescription <- map["paperlessDescription"]
        successOperation <- map["successOperation"]
        yourBill <- map["yourBill"]
    }

}
