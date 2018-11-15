//
//  UpdateChannelStatusRequest.swift
//  MiClaro
//
//  Created by Omar Israel Trujillo Osornio on 10/11/18.
//  Copyright © 2018 am. All rights reserved.
//

import Foundation
import ObjectMapper

class UpdateChannelStatusRequest : NSObject, Mappable{
    
    
    var updateChannelStatus : UpdateChannelStatus?
    
    
    override init() {
        updateChannelStatus = UpdateChannelStatus();
    }
    required init?(map: Map) {}
    
    func mapping(map: Map)
    {
        updateChannelStatus <- map["UpdateChannelStatus"]
        
    }
}
