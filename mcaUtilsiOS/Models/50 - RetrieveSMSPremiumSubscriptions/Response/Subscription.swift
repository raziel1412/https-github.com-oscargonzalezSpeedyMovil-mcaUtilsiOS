//
//  Subscription.swift
//  MiClaro
//
//  Created by Omar Israel Trujillo Osornio on 13/09/18.
//  Copyright © 2018 am. All rights reserved.
//

import Foundation
import ObjectMapper

class Subscription : BaseResponse{
    
    var mSISDN : String?
    var origin : String?
    var password : String?
    var provider : String?
    var service : String?
    var shortNumber : String?
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
        origin <- map["Origin"]
        password <- map["Password"]
        provider <- map["Provider"]
        service <- map["Service"]
        shortNumber <- map["ShortNumber"]
        subscriptionDate <- map["SubscriptionDate"]
        
    }
    

    
}
