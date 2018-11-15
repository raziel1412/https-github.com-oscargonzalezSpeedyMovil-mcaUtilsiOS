//
//  ServiceChannel.swift
//  MiClaro
//
//  Created by Omar Israel Trujillo Osornio on 10/11/18.
//  Copyright © 2018 am. All rights reserved.
//

import Foundation
import ObjectMapper

class ServiceChannel : BaseRequest{
    
    var address : String?
    var serviceId : String?
    var serviceType : String?
    
    
    override init() {
        super.init()
    }
    required init?(map: Map) {
        super.init(map: map);
    }
    
    override func mapping(map: Map)
    {
        super.mapping(map: map);
        address <- map["Address"]
        serviceId <- map["ServiceId"]
        serviceType <- map["ServiceType"]
        
    }
    

    
}
