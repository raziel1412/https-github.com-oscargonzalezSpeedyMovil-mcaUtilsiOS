//
//  PermissionConfig.swift
//  MiClaro
//
//  Created by Roberto Gutierrez Resendiz on 20/12/17.
//  Copyright © 2017 am. All rights reserved.
//

import UIKit
import ObjectMapper

/// Clase relacionada con la definición del archivo de configuración
class PermissionConfig : NSObject, Mappable{

    var profiles : [ProfilePermission]?

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
        profiles <- map["profiles"]
    }
}
