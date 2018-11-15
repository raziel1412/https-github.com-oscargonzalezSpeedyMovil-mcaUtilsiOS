//
//  PackagesList.swift
//  MiClaro
//
//  Created by Omar Israel Trujillo Osornio on 10/11/18.
//  Copyright © 2018 am. All rights reserved.
//

import Foundation
import ObjectMapper

class PackagesList : BaseResponse{
    
    var observation : String?
    var duration : String?
    var id : Int?
    var name : String?
    var price : String?
    var priceFormat: String?
    var isSelected: Bool = false
    
    override init() {
        super.init()
    }
    
    required init?(map: Map) {
        super.init(map: map);
    }
    
    
    override func mapping(map: Map)
    {
        super.mapping(map: map);
        observation <- map["Observation"]
        duration <- map["Duration"]
        id <- map["Id"]
        name <- map["Name"]
        price <- map["Price"]
        priceFormat <- map["PriceFormat"]
    }
    
}
