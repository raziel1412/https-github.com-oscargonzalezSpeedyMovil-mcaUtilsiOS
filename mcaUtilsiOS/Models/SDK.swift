//
//  SDK.swift
//  MiClaro
//
//  Created by Roberto Gutierrez Resendiz on 18/05/18.
//  Copyright © 2018 am. All rights reserved.
//

import UIKit
import ObjectMapper

class SDK: NSObject, Mappable {
    var configs : [AnyObject]?
    var enabled : Bool?
    var id : String?

    override init() {

    }

    /// Función encargada de mapear el JSON correspondiente
    /// - parameter Map: Objeto de tipo Map
    required init?(map: Map) {

    }

    func mapping(map: Map)
    {
        configs <- map["configs"]
        enabled <- map["enabled"]
        id <- map["id"]

    }
}
