//
//  NewUpdateAvailable.swift
//  MiClaro
//
//  Created by Roberto Gutierrez Resendiz on 08/08/18.
//  Copyright © 2018 am. All rights reserved.
//

import UIKit
import ObjectMapper

class NewUpdateAvailable: NSObject, Mappable {

    var updateAvailable : Bool?
    var forcedUpdate : Bool?
    var itunesURL : String?
    var playstoreURL : String?

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
        updateAvailable <- map["UpdateAvailable"]
        forcedUpdate <- map["forcedUpdate"]
        itunesURL <- map["itunesURL"]
        playstoreURL <- map["playstoreURL"]
    }
}
