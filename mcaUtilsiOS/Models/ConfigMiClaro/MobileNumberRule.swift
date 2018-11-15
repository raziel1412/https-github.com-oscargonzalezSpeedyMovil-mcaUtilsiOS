//
//  MobileNumberRule.swift
//  MiClaro
//
//  Created by Roberto Gutierrez Resendiz on 27/07/18.
//  Copyright © 2018 am. All rights reserved.
//

import UIKit
import ObjectMapper

class MobileNumberRule: NSObject, Mappable {
    var mobileMaxLength : String?

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
        mobileMaxLength <- map["mobile_max_length"]
    }
}
