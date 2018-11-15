//
//  Tooltip.swift
//  MiClaro
//
//  Created by Roberto Gutierrez Resendiz on 18/05/18.
//  Copyright © 2018 am. All rights reserved.
//

import UIKit
import ObjectMapper

class Tooltip: NSObject, Mappable {
    var text : String?
    var typeServices : String?

    override init() {

    }

    /// Función encargada de mapear el JSON correspondiente
    /// - parameter Map: Objeto de tipo Map
    required init?(map: Map) {
        super.init();
    }

    func mapping(map: Map)
    {
        text <- map["text"]
        typeServices <- map["typeServices"]
    }
}
