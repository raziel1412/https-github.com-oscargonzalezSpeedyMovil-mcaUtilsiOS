//
//  Texto.swift
//  MiClaro
//
//  Created by Roberto Gutierrez Resendiz on 22/02/18.
//  Copyright © 2018 am. All rights reserved.
//

import UIKit
import ObjectMapper

/// Clase relacionada con la definición del archivo de configuración
class Texto: NSObject, Mappable {
    var pantalla01 : Pantalla01?
    var pantalla02 : Pantalla02?
    var pantalla03 : Pantalla03?
    var pantalla04 : Pantalla04?

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
        pantalla01 <- map["Pantalla01"]
        pantalla02 <- map["Pantalla02"]
        pantalla03 <- map["Pantalla03"]
        pantalla04 <- map["Pantalla04"]
    }
}


