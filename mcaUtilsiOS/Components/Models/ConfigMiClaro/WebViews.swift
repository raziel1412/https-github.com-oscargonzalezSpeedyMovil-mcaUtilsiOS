//
//  WebViews.swift
//  MiClaro
//
//  Created by Omar Israel Trujillo Osornio on 10/3/18.
//  Copyright © 2018 am. All rights reserved.
//

import Foundation
import ObjectMapper


class WebViews : NSObject, Mappable{
    
    
    var descriptionField : String?
    var id : Int?
    var url : String?
    
    override init(){}
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map)
    {
        descriptionField <- map["description"]
        id <- map["id"]
        url <- map["url"]
    }
}



