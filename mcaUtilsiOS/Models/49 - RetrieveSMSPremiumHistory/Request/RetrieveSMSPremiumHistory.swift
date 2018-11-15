//
//  RetrieveSMSPremiumHistory.swift
//  MiClaro
//
//  Created by Omar Israel Trujillo Osornio on 13/09/18.
//  Copyright © 2018 am. All rights reserved.
//

import Foundation
import ObjectMapper


class RetrieveSMSPremiumHistory : BaseRequest{
    
    var accountId : String?
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
//        super.mapping(map: map);
        accountId <- map["AccountId"]
        lineOfBusiness <- map["LineOfBusiness"]
        mSISDN <- map["MSISDN"]
        userProfileID <- map["UserProfileID"]
        
    }

    
}
