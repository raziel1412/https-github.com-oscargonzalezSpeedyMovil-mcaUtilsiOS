//
//  RetrieveSMSPremiumHistoryResult.swift
//  MiClaro
//
//  Created by Omar Israel Trujillo Osornio on 13/09/18.
//  Copyright © 2018 am. All rights reserved.
//

import Foundation
import ObjectMapper

class RetrieveSMSPremiumHistoryResult : BaseResult{
    
    var retrieveSMSPremiumHistoryResponse : RetrieveSMSPremiumHistoryResponse?

    
    override init() {
        super.init();
    }
    
    required init?(map: Map) {
        super.init();
    }

    override func mapping(map: Map)
    {
        super.mapping(map: map);
        retrieveSMSPremiumHistoryResponse <- map["RetrieveSMSPremiumHistoryResponse"]
        isSuccessful <- map["isSuccessful"]
        responseHeaders <- map["responseHeaders"]
        responseTime <- map["responseTime"]
        statusCode <- map["statusCode"]
        statusReason <- map["statusReason"]
        totalTime <- map["totalTime"]
        
    }

    
}
