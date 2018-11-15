//
//  UnsubscribeSMSPremium.swift
//  MiClaro
//
//  Created by Omar Israel Trujillo Osornio on 13/09/18.
//  Copyright © 2018 am. All rights reserved.
//

import Foundation
import ObjectMapper

class UnsubscribeSMSPremium : BaseRequest{
        
    var service : UnsubscribeService?
    var accountId : String?
    var lineOfBusiness : String?
    var userProfileID : String?
    var mSISDN : String?
    
    override init() { 
        super.init()
    }
    
    required init?(map: Map) {
        super.init(map: map);
    }
    
    override func mapping(map: Map)
    {
//        super.mapping(map: map);
        service <- map["Service"]
        accountId <- map["AccountId"]
        lineOfBusiness <- map["LineOfBusiness"]
        userProfileID <- map["UserProfileID"]
        mSISDN <- map["MSISDN"]
    }

    
}
