//
//  UpdateChannelStatus.swift
//  MiClaro
//
//  Created by Omar Israel Trujillo Osornio on 10/11/18.
//  Copyright © 2018 am. All rights reserved.
//

import Foundation
import ObjectMapper

class UpdateChannelStatus : BaseRequest{
    
    var action : String?
    var contact : Contact?
    var lineOfBusiness : String?
    var productRequest : ProductRequest?
    var serviceChannel : ServiceChannel?
    
    
    override init() {
        super.init()
    }
    required init?(map: Map) {
        super.init(map: map);
    }
    
    override func mapping(map: Map)
    {
        super.mapping(map: map);
        action <- map["Action"]
        contact <- map["Contact"]
        lineOfBusiness <- map["LineOfBusiness"]
        productRequest <- map["ProductRequest"]
        serviceChannel <- map["ServiceChannel"]
        
    }
}
