//
//  RemoveSMSPremiumFromBlackListResult.swift
//  MiClaro
//
//  Created by Omar Israel Trujillo Osornio on 13/09/18.
//  Copyright © 2018 am. All rights reserved.
//


import Foundation
import ObjectMapper

class RemoveSMSPremiumFromBlackListResult : BaseResult{
    
    var removeSMSPremiumFromBlackListResponse : RemoveSMSPremiumFromBlackListResponse?

    
    override init() {
        super.init();
    }
  
    required init?(map: Map) {
        super.init();
    }
    
    override func mapping(map: Map){
        super.mapping(map: map);
        removeSMSPremiumFromBlackListResponse <- map["RemoveSMSPremiumFromBlackListResponse"]

        
    }

    
}
