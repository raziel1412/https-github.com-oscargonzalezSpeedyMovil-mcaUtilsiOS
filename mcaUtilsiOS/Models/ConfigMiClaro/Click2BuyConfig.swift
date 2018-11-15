//
//  Click2BuyConfig.swift
//  MiClaro
//
//  Created by Roberto Gutierrez Resendiz on 08/08/18.
//  Copyright © 2018 am. All rights reserved.
//

import UIKit
import ObjectMapper

class Click2BuyConfig: NSObject, Mappable {

    var click2BuyCallURL : String?
    var click2BuyWhatsappNumber : String?

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
        click2BuyCallURL <- map["click2BuyCallURL"]
        click2BuyWhatsappNumber <- map["click2BuyWhatsappNumber"]
    }
}
