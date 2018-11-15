//
//  UpdateChannelsOffterResult.swift
//  MiClaro
//
//  Created by Omar Israel Trujillo Osornio on 10/11/18.
//  Copyright © 2018 am. All rights reserved.
//

import Foundation
import ObjectMapper

class UpdateChannelStatusResult : BaseResult{
    
    var updateChannelStatusResponse : UpdateChannelStatusResponse?

    
    override init() {
        super.init();
    }
    
    required init?(map: Map) {
        super.init();
    }
    override func mapping(map: Map)
    {
        super.mapping(map: map);
        updateChannelStatusResponse <- map["UpdateChannelStatusResponse"]
    }

    
}
