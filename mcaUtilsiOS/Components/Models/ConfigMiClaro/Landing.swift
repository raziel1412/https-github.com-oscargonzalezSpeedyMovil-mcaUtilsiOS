//
//  Landing.swift
//  MiClaro
//
//  Created by Roberto Gutierrez Resendiz on 08/08/17.
//  Copyright © 2017 am. All rights reserved.
//

import UIKit
import ObjectMapper

/// Clase relacionada con la definición del archivo de configuración
class Landing: NSObject, Mappable {

    var summaryDescription : String?
    var summaryServicesDetail : String?
    var summaryTitle : String?

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
        summaryDescription <- map["summaryDescription"]
        summaryServicesDetail <- map["summaryServicesDetail"]
        summaryTitle <- map["summaryTitle"]
    }
}
