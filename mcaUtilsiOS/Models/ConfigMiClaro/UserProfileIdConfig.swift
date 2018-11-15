//
//  UserProfileIdConfig.swift
//  MiClaro
//
//  Created by Roberto Gutierrez Resendiz on 19/12/17.
//  Copyright © 2017 am. All rights reserved.
//

import UIKit
import ObjectMapper

/// Clase relacionada con la definición del archivo de configuración
class UserProfileIdConfig : NSObject, Mappable{

    var max : Int?
    var min : Int?
    var msgError : String?
    var posicion : Int?
    var separador : String?

    override init() {}

    /// Función encargada de mapear el JSON correspondiente
    /// - parameter Map: Objeto de tipo Map
    required init?(map: Map) {

    }
    /// Función encargada de mapear el JSON correspondiente
    /// - parameter Map: Objeto de tipo Map
    func mapping(map: Map) {
        max <- map["max"]
        min <- map["min"]
        msgError <- map["msgError"]
        posicion <- map["posicion"]
        separador <- map["separador"]
    }
}
