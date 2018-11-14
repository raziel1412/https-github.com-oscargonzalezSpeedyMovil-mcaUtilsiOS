//
//  IdentifyUserLoBRequest.swift
//  MiClaro
//
//  Created by Roberto Gutierrez Resendiz on 17/08/18.
//  Copyright © 2018 am. All rights reserved.
//

import UIKit
import ObjectMapper

class IdentifyUserLoBRequest: NSObject, Mappable {
    var identifyUserLoB : IdentifyUserLoB?
    var identifyUserLoBFault : BaseFault?

    override init() {
        super.init()
        identifyUserLoB = IdentifyUserLoB();
    }

    required init?(map: Map) {
    }

    func mapping(map: Map)
    {
        identifyUserLoB <- map["IdentifyUserLoB"]
        identifyUserLoBFault <- map["IdentifyUserLoBFault"]
    }
}
