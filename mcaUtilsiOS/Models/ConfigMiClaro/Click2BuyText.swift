//
//  Click2BuyText.swift
//  MiClaro
//
//  Created by Roberto Gutierrez Resendiz on 08/08/18.
//  Copyright © 2018 am. All rights reserved.
//

import UIKit
import ObjectMapper

class Click2BuyText: NSObject, Mappable {

    var click2BuyCall : String?
    var click2BuyCallDescription : String?
    var click2BuyDescription : String?
    var click2BuyDescription2 : String?
    var click2BuyHeader : String?
    var click2BuyWhatsapp : String?
    var click2BuyWhatsappDescription : String?

    override init() {

    }

    /// Función encargada de mapear el JSON correspondiente
    /// - parameter Map: Objeto de tipo Map
    required init?(map: Map) {
        super.init();
    }

    /// Función encargada de mapear el JSON correspondiente
    /// - parameter Map: Objeto de tipo Map
    func mapping(map: Map)
    {
        click2BuyCall <- map["click2BuyCall"]
        click2BuyCallDescription <- map["click2BuyCallDescription"]
        click2BuyDescription <- map["click2BuyDescription"]
        click2BuyDescription2 <- map["click2BuyDescription2"]
        click2BuyHeader <- map["click2BuyHeader"]
        click2BuyWhatsapp <- map["click2BuyWhatsapp"]
        click2BuyWhatsappDescription <- map["click2BuyWhatsappDescription"]
    }
}
