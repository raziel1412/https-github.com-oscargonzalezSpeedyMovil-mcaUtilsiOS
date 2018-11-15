//
//  ProductRequest.swift
//  MiClaro
//
//  Created by Omar Israel Trujillo Osornio on 10/11/18.
//  Copyright © 2018 am. All rights reserved.
//

import Foundation
import ObjectMapper

class ProductRequest : BaseRequest{
    
    var amount : Float?
    var productChannel : String?
    
    
    override init() {
        super.init()
    }
    required init?(map: Map) {
        super.init(map: map);
    }
    
    
    override func mapping(map: Map)
    {
        super.mapping(map: map);
        amount <- map["Amount"]
        productChannel <- map["Channel"]
        
    }
}

