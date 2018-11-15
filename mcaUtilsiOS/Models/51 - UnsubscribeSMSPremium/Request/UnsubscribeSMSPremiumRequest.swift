//
//  UnsubscribeSMSPremiumRequest.swift
//  MiClaro
//
//  Created by Omar Israel Trujillo Osornio on 13/09/18.
//  Copyright © 2018 am. All rights reserved.
//
import Foundation
import ObjectMapper

class UnsubscribeSMSPremiumRequest : NSObject, Mappable{
    
    var unsubscribeSMSPremium : UnsubscribeSMSPremium?
    
    override init() {
        super.init()
        unsubscribeSMSPremium = UnsubscribeSMSPremium();
    }
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map)
    {
        unsubscribeSMSPremium <- map["UnsubscribeSMSPremium"]
        
    }
}
