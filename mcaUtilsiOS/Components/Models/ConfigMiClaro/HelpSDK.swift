//
//  HelpSDK.swift
//  MiClaro
//
//  Created by Roberto Gutierrez Resendiz on 17/08/17.
//  Copyright © 2017 am. All rights reserved.
//

import UIKit
import ObjectMapper

/// Clase relacionada con la definición del archivo de configuración
class HelpSDK: NSObject, Mappable {
    var android : Android?
    var ios : Android?
    var url : String?

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
        android <- map["android"]
        ios <- map["ios"]
        url <- map["url"]
    }
}
