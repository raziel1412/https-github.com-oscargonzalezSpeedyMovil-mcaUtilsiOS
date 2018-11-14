//
//  RetrieveSMSPremiumHistoryResponse.swift
//  MiClaro
//
//  Created by Omar Israel Trujillo Osornio on 13/09/18.
//  Copyright © 2018 am. All rights reserved.
//

import Foundation
import ObjectMapper

class RetrieveSMSPremiumHistoryResponse : BaseResponse{
    
    var subscriptionHistory : [SubscriptionHistory]?
    var accountId : String = ""
    var lineOfBusiness : String = ""
    var serviceID : String = ""
    
    override init() {
        super.init()
    }
    
    required init?(map: Map) {
        super.init(map: map);
    }
    
    override func mapping(map: Map)
    {
        super.mapping(map: map);
        subscriptionHistory  <- map["SubscriptionHistory"]
    }
    
    
}
