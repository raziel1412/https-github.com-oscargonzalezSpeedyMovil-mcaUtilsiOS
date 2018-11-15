//
//  NewUpdateAvailableText.swift
//  MiClaro
//
//  Created by Roberto Gutierrez Resendiz on 08/08/18.
//  Copyright © 2018 am. All rights reserved.
//

import UIKit
import ObjectMapper

class NewUpdateAvailableText: NSObject, Mappable {

    var newUpdateAvailableLater : String?
    var newUpdateAvailableNow : String?
    var updateForcedDescription : String?
    var updateForcedDescription2 : String?
    var updateForcedTitle : String?
    var updateOptionalDescription : String?
    var updateOptionalDescription2 : String?
    var updateOptionalTitle : String?

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
        newUpdateAvailableLater <- map["newUpdateAvailableLater"]
        newUpdateAvailableNow <- map["newUpdateAvailableNow"]
        updateForcedDescription <- map["updateForcedDescription"]
        updateForcedDescription2 <- map["updateForcedDescription2"]
        updateForcedTitle <- map["updateForcedTitle"]
        updateOptionalDescription <- map["updateOptionalDescription"]
        updateOptionalDescription2 <- map["updateOptionalDescription2"]
        updateOptionalTitle <- map["updateOptionalTitle"]
    }
}
