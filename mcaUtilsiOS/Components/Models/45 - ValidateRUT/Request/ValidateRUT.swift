//
//  ValidateRUT.swift
//  MiClaro
//
//  Created by Roberto Gutierrez Resendiz on 17/08/18.
//  Copyright © 2018 am. All rights reserved.
//

import UIKit
import ObjectMapper

class ValidateRUT: BaseRequest {

    var rut : String?
    var serialDocument : String?
    var lineOfBusiness : String?

    override init() {
        super.init()
    }

    required init?(map: Map) {
        super.init(map: map);
    }

    override func mapping(map: Map)
    {
        lineOfBusiness <- map["LineOfBusiness"]
        rut <- map["Rut"]
        serialDocument <- map["SerialDocument"]
    }
}
