//
//  VerifyAssociationToUserIdRequest.swift
//  MiClaro
//
//  Created by Roberto Gutierrez Resendiz on 17/08/18.
//  Copyright © 2018 am. All rights reserved.
//

import UIKit
import ObjectMapper

class VerifyAssociationToUserIdRequest: NSObject, Mappable {
    var verifyAssociationToUserId : VerifyAssociationToUserId?
    var verifyAssociationToUserFault : BaseFault?

    override init() {
        super.init()
        verifyAssociationToUserId = VerifyAssociationToUserId();
    }

    required init?(map: Map) {
    }

    func mapping(map: Map)
    {
        verifyAssociationToUserId <- map["VerifyAssociationToUserId"]
        verifyAssociationToUserFault <- map["VerifyAssociationToUserIdFault"];
    }
}
