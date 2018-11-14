//
//  PrepaidStatusInfo.swift
//  MiClaro
//
//  Created by Roberto Gutierrez Resendiz on 18/05/18.
//  Copyright © 2018 am. All rights reserved.
//

import UIKit
import ObjectMapper

class PrepaidStatusInfo: NSObject, Mappable {
    var status : String?
    var zB1EndDate : String?
    var zB2EndDate : String?

    override init() {
        super.init();
    }

    required init?(map: Map) {
        super.init();
    }

    func mapping(map: Map)
    {
        status <- map["Status"]
        zB1EndDate <- map["ZB1EndDate"]
        zB2EndDate <- map["ZB2EndDate"]

    }
}
