//
//  ValidateRUTRequest.swift
//  MiClaro
//
//  Created by Roberto Gutierrez Resendiz on 17/08/18.
//  Copyright © 2018 am. All rights reserved.
//

import UIKit
import ObjectMapper

class ValidateRUTRequest: NSObject, Mappable {
    var validateRUT : ValidateRUT?
    var validateRUTFault : BaseFault?

    override init() {
        super.init()
        validateRUT = ValidateRUT();
    }

    required init?(map: Map) {
    }

    func mapping(map: Map)
    {
        validateRUT <- map["ValidateRut"]
        validateRUTFault <- map["ValidateRUTFault"]
    }
}
