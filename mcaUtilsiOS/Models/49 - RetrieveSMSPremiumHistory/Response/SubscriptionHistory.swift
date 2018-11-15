//
//  SubscriptionHistory.swift
//  MiClaro
//
//  Created by Omar Israel Trujillo Osornio on 13/09/18.
//  Copyright © 2018 am. All rights reserved.
//

import Foundation
import ObjectMapper

class SubscriptionHistory : BaseResponse{
    
    var mSISDN : String?
    var provider : String?
    var service : String?
    var shortNumber : String?
    var status : Int?
    var subscriptionDate : String?
    
    override init() {
        super.init()
    }
    
    required init?(map: Map) {
        super.init(map: map);
    }
    
    override func mapping(map: Map)
    {
        super.mapping(map: map);
        mSISDN <- map["MSISDN"]
        provider <- map["Provider"]
        service <- map["Service"]
        shortNumber <- map["ShortNumber"]
        status <- map["Status"]
        subscriptionDate <- map["SubscriptionDate"]
        
    }

    
}
