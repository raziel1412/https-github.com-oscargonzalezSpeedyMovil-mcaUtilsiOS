//
//  BaseFault.swift
//  MiClaro
//
//  Created by Roberto Gutierrez Resendiz on 25/09/17.
//  Copyright © 2017 am. All rights reserved.
//

import UIKit
import ObjectMapper

// Esta clase almacena la estructura básica de todas las respuestas de tipo Fault definiendo sus propiedades comunes para el consumo de los servicios. Se utiliza junto con los servicios enumerados del 1 - 37
class BaseFault: NSObject, Mappable {
    var action : String?
    var code : String?
    var component : String?
    var descriptionField : String?
    var message : String?
    var method : String?

    override init() {
        super.init();
    }

    required init?(map: Map) {
        super.init();
    }

    func mapping(map: Map)
    {
        action <- map["Action"]
        code <- map["Code"]
        component <- map["Component"]
        descriptionField <- map["Description"]
        message <- map["Message"]
        method <- map["Method"]
    }
}
