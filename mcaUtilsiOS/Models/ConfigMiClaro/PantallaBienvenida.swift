//
//  PantallaBienvenida.swift
//  MiClaro
//
//  Created by Roberto Gutierrez Resendiz on 22/02/18.
//  Copyright © 2018 am. All rights reserved.
//

import UIKit
import ObjectMapper

/// Clase útil para generar el contenido usado para mostrar las pantallas de bienvenida
class PantallaBienvenida: NSObject, Mappable {

    /// Arreglo de pantallas
    var pantallas : [Pantalla]?

    required init?(map: Map) {

    }
    /// Funcion encargada de mapear el JSON en el array
    /// - parameter Map: Objeto de tipo Map
    func mapping(map: Map)
    {
        pantallas <- map["Pantallas"]
    }
}


