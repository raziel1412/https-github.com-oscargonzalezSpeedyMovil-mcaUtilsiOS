//
//  Pantalla02.swift
//  MiClaro
//
//  Created by Roberto Gutierrez Resendiz on 22/02/18.
//  Copyright © 2018 am. All rights reserved.
//

import UIKit
import ObjectMapper

/// Clase relacionada con la definición del archivo de configuración
class Pantalla02: NSObject, Mappable {
    var anterior : String?
    var saltarIntro : String?
    var siguiente : String?
    var text01 : String?
    var text02 : String?
    var text03 : String?
    var text04 : String?
    var wallpaper : String?

    override init() {

    }

    /// Función encargada de mapear el JSON correspondiente
    /// - parameter Map: Objeto de tipo Map
    required init?(map: Map) {

    }

    /// Función encargada de mapear el JSON correspondiente
    /// - parameter Map: Objeto de tipo Map
    func mapping(map: Map) {
        anterior <- map["Anterior"]
        saltarIntro <- map["SaltarIntro"]
        siguiente <- map["Siguiente"]
        text01 <- map["Text01"]
        text02 <- map["Text02"]
        text03 <- map["Text03"]
        text04 <- map["Text04"]
        wallpaper <- map["Wallpaper"]
    }
}
