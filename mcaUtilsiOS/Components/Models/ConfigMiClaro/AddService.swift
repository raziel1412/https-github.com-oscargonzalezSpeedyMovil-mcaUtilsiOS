//
//  AddService.swift
//  MiClaro
//
//  Created by Roberto Gutierrez Resendiz on 08/08/17.
//  Copyright © 2017 am. All rights reserved.
//

import UIKit
import ObjectMapper

/// Clase relacionada con la definición del archivo de configuración
class AddService: NSObject, Mappable {

    var addPrepaidNumber : String?
    var addServiceFirstStep : String?
    var addServiceSuccess : String?
    var confirmPrepaid : String?
    var header : String?
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
        addPrepaidNumber <- map["addPrepaidNumber"]
        addServiceFirstStep <- map["addServiceFirstStep"]
        addServiceSuccess <- map["addServiceSuccess"]
        confirmPrepaid <- map["confirmPrepaid"]
        header <- map["header"]
        title <- map["title"]
    }
}
