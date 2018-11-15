//
//  BaseResult.swift
//  MiClaro
//
//  Created by Roberto Gutierrez Resendiz on 18/08/17.
//  Copyright © 2017 am. All rights reserved.
//

import UIKit
import ObjectMapper

// Esta clase almacena la estructura básica de todas las respuestas de tipo Response definiendo sus propiedades comunes para el consumo de los servicios. Se utiliza junto con los servicios enumerados del 1 - 37
class BaseResult: NSObject, Mappable {
    var isSuccessful : Bool?
    var responseHeaders : ResponseHeader?
    var responseTime : Int?
    var statusCode : Int?
    var statusReason : String?
    var totalTime : Int?

    override init() {
        super.init();
    }

    required init?(map: Map) {
        super.init();
    }

    func mapping(map: Map)
    {
        isSuccessful <- map["isSuccessful"]
        responseHeaders <- map["responseHeaders"]
        responseTime <- map["responseTime"]
        statusCode <- map["statusCode"]
        statusReason <- map["statusReason"]
        totalTime <- map["totalTime"]
    }
}
