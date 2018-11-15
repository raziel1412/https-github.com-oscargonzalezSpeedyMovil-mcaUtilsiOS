//
//  ChannelList.swift
//  MiClaro
//
//  Created by Omar Israel Trujillo Osornio on 10/11/18.
//  Copyright © 2018 am. All rights reserved.
//

import Foundation
import ObjectMapper

class ChannelList : BaseResponse{
    
    var conditions : String?
    var descriptionField : String?
    var id : String?
    var imageUrl : String?
    var name : String?
    var price : Float?
    
    
    override init() {
        super.init()
    }
    
    required init?(map: Map) {
        super.init(map: map);
    }
    override func mapping(map: Map)
    {
        super.mapping(map: map);
        conditions <- map["Conditions"]
        descriptionField <- map["Description"]
        id <- map["Id"]
        imageUrl <- map["ImageUrl"]
        name <- map["Name"]
        price <- map["Price"]
        
    }
    
}
