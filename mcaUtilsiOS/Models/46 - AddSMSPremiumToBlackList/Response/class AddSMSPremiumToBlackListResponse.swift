//
//  class AddSMSPremiumToBlackListResponse.swift
//  MiClaro
//
//  Created by Jonathan Abimael Cruz Orozco on 13/09/18.
//  Copyright © 2018 am. All rights reserved.
//

import Foundation
import ObjectMapper

class AddSMSPremiumToBlackListResponse: BaseResponse {
    override init() {
        super.init()
    }
    
    required init?(map: Map) {
        super.init(map: map);
    }
    
    override func mapping(map: Map)
    {
        super.mapping(map: map);
    }
}
