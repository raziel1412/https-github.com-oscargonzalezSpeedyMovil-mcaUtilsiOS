//
//  BaseResponse.swift
//  MiClaro
//
//  Created by Roberto Gutierrez Resendiz on 15/08/17.
//  Copyright © 2017 am. All rights reserved.
//

import UIKit
import ObjectMapper

// Esta clase almacena la estructura básica de todas las respuestas de tipo Response definiendo sus propiedades comunes para el consumo de los servicios. Se utiliza junto con los servicios enumerados del 1 - 37
class BaseResponse: NSObject, Mappable {

    var acknowledgementCode : String?
    var acknowledgementDescription : String?
    var acknowledgementIndicator : String?

    override init() {
        super.init();
    }

    required init?(map: Map) {
        super.init();
    }

    func mapping(map: Map)
    {
        acknowledgementCode <- map["AcknowledgementCode"]
        acknowledgementDescription <- map["AcknowledgementDescription"]
        acknowledgementIndicator <- map["AcknowledgementIndicator"]

    }
}
