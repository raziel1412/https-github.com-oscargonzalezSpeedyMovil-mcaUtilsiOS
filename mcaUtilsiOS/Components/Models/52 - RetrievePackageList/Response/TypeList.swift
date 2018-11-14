//
//  TypeList.swift
//  MiClaro
//
//  Created by Omar Israel Trujillo Osornio on 10/11/18.
//  Copyright © 2018 am. All rights reserved.
//

import Foundation
import ObjectMapper

class TypeList : BaseResponse{
    
    var id : String?
    var name : String?
    var observation : String?
    var packagesList : [PackagesList]?
    
    override init() {
        super.init()
    }
    
    required init?(map: Map) {
        super.init(map: map);
    }
    
    
    override func mapping(map: Map)
    {
        super.mapping(map: map);
        id <- map["Id"]
        name <- map["Name"]
        observation <- map["Observation"]
        packagesList <- map["PackagesList"]
        
    }
    
}
