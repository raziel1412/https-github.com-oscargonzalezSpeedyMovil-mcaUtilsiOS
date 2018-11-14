//
//  ServiceFeatureUsageLimit.swift
//  MiClaro
//
//  Created by Roberto Gutierrez Resendiz on 18/05/18.
//  Copyright © 2018 am. All rights reserved.
//

import UIKit
import ObjectMapper

class ServiceFeatureUsageLimit: NSObject, Mappable {

    var quantity : Float?
    var unit : String?

    override init() {

    }

    required init?(map: Map) {

    }

    func mapping(map: Map)
    {
        quantity <- (map["Quantity"])
        unit <- map["Unit"]

    }
    
}
