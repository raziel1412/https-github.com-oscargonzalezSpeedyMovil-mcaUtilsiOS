//
//  AddSMSPremiumToBlackListRequest.swift
//  MiClaro
//
//  Created by Jonathan Abimael Cruz Orozco on 13/09/18.
//  Copyright © 2018 am. All rights reserved.
//

import Foundation
import ObjectMapper

class AddSMSPremiumToBlackListRequest: NSObject, Mappable {
    var addSMSPremiumToBlackList : AddSMSPremiumToBlackList?
    
    override init() {
        addSMSPremiumToBlackList = AddSMSPremiumToBlackList();
    }
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map)
    {
        addSMSPremiumToBlackList <- map["AddSMSPremiumToBlackList"]
    }
}
