//
//  VerifyAssociationToUserId.swift
//  MiClaro
//
//  Created by Roberto Gutierrez Resendiz on 17/08/18.
//  Copyright © 2018 am. All rights reserved.
//

import UIKit
import ObjectMapper

class VerifyAssociationToUserId: BaseRequest {
    var lineOfBusiness : String?
    var mSISDN : String?
    var userProfileID : String?

    override init() {
        super.init()
    }

    required init?(map: Map) {
        super.init(map: map);
    }

    override func mapping(map: Map)
    {
        lineOfBusiness <- map["LineOfBusiness"]
        mSISDN <- map["MSISDN"]
        userProfileID <- map["UserProfileID"]
    }
}
