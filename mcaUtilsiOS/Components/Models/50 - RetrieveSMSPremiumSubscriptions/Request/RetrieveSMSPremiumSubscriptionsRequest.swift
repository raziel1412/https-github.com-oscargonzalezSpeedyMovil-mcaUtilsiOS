//
//  RetrieveSMSPremiumSubscriptionsRequest.swift
//  MiClaro
//
//  Created by Omar Israel Trujillo Osornio on 13/09/18.
//  Copyright © 2018 am. All rights reserved.
//

import Foundation
import ObjectMapper


class RetrieveSMSPremiumSubscriptionsRequest : NSObject, Mappable{
    
    var retrieveSMSPremiumSubscriptions : RetrieveSMSPremiumSubscriptions?
    
    
    override init() {
        retrieveSMSPremiumSubscriptions = RetrieveSMSPremiumSubscriptions()
    }
    
    required init?(map: Map) {}
    
    func mapping(map: Map)
    {
        retrieveSMSPremiumSubscriptions <- map["RetrieveSMSPremiumSubscriptions"]
    }

    
}
