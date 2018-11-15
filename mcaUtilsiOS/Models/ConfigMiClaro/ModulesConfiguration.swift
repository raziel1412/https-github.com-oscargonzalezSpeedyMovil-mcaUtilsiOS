//
//  ModulesConfiguration.swift
//  MiClaro
//
//  Created by Roberto Gutierrez Resendiz on 22/08/18.
//  Copyright © 2018 am. All rights reserved.
//

import UIKit
import ObjectMapper

class ModulesConfiguration: NSObject, Mappable {

    var digitalBirthModuleStatus : Bool?
    var newRegisterModuleStatus : Bool?

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
        digitalBirthModuleStatus <- map["digitalBirthModuleStatus"]
        newRegisterModuleStatus <- map["newRegisterModuleStatus"]
    }
}
