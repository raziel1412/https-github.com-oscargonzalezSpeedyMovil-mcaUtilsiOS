//
//  Mobile.swift
//  MiClaro
//
//  Created by Roberto Gutierrez Resendiz on 08/08/17.
//  Copyright © 2017 am. All rights reserved.
//

import UIKit
import ObjectMapper

/// Clase relacionada con la definición del archivo de configuración
class Mobile: NSObject, Mappable {
    var balance : String?
    var endingDays : String?
    var internetAvailable : String?
    var internetUsed : String?
    var mobileChangePlan : String?
    var refillCycle : String?
    var remainingDays : String?
    var startingDays : String?
    var topUpBtn : String?

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
        balance <- map["balance"]
        endingDays <- map["endingDays"]
        internetAvailable <- map["internetAvailable"]
        internetUsed <- map["internetUsed"]
        mobileChangePlan <- map["mobileChangePlan"]
        refillCycle <- map["refillCycle"]
        remainingDays <- map["remainingDays"]
        startingDays <- map["startingDays"]
        topUpBtn <- map["topUpBtn"]
    }
}
