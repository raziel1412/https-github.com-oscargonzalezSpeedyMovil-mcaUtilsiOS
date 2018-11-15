//
//  AddSMSPremiumToBlackListResult.swift
//  MiClaro
//
//  Created by Jonathan Abimael Cruz Orozco on 13/09/18.
//  Copyright © 2018 am. All rights reserved.
//

import Foundation
import ObjectMapper

class AddSMSPremiumToBlackListResult: BaseResult {
    var addSMSPremiumToBlackListResponse : AddSMSPremiumToBlackListResponse?
    
    override init() {
        super.init();
    }
    
    required init?(map: Map) {
        super.init();
    }
    
    override func mapping(map: Map)
    {
        super.mapping(map: map);
        addSMSPremiumToBlackListResponse <- map["AddSMSPremiumToBlackListResponse"]
    }
}
