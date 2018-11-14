//
//  RetrievePackageListRequest.swift
//  MiClaro
//
//  Created by Omar Israel Trujillo Osornio on 10/11/18.
//  Copyright © 2018 am. All rights reserved.
//

import Foundation
import ObjectMapper

class RetrievePackageListRequest : NSObject, Mappable{
    
    var retrievePackageList : RetrievePackageList?
    
    override init() {
        super.init()
        retrievePackageList = RetrievePackageList();
    }
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map)
    {
        retrievePackageList <- map["RetrievePackageList"]
        
    }
    
}
