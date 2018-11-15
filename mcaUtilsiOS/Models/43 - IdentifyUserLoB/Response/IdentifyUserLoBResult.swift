//
//  IdentifyUserLoBResult.swift
//  MiClaro
//
//  Created by Roberto Gutierrez Resendiz on 17/08/18.
//  Copyright © 2018 am. All rights reserved.
//

import UIKit
import ObjectMapper

class IdentifyUserLoBResult: BaseResult {
    var identifyUserLoBResponse :  IdentifyUserLoBResponse?
    var identifyUserLoBFault : BaseFault?

    override init() {
        super.init();
    }

    required init?(map: Map) {
        super.init();
    }

    override func mapping(map: Map)
    {
        super.mapping(map: map);
        identifyUserLoBResponse <- map["IdentifyUserLoBResponse"]
        identifyUserLoBFault <- map["IdentifyUserLoBFault"];
    }
}
