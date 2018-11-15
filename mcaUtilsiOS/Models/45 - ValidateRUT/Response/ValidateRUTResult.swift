//
//  ValidateRUTResult.swift
//  MiClaro
//
//  Created by Roberto Gutierrez Resendiz on 17/08/18.
//  Copyright © 2018 am. All rights reserved.
//

import UIKit
import ObjectMapper

class ValidateRUTResult: BaseResult {
    var validateRUTResponse :  ValidateRUTResponse?
    var validateRUTFault : BaseFault?

    override init() {
        super.init();
    }

    required init?(map: Map) {
        super.init();
    }

    override func mapping(map: Map)
    {
        super.mapping(map: map);
        validateRUTResponse <- map["ValidateRutResponse"]
        validateRUTFault <- map["ValidateRUTFault"]
    }
}
