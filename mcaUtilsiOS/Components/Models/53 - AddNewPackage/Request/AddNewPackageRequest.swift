//
//  AddNewPackageRequest.swift
//  MiClaro
//
//  Created by Omar Israel Trujillo Osornio on 10/11/18.
//  Copyright © 2018 am. All rights reserved.
//

import Foundation
import ObjectMapper

class AddNewPackageRequest : NSObject, Mappable{
    
    var addNewPackage : AddNewPackage?
    
    override init() {
        super.init()
        addNewPackage = AddNewPackage();
    }
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map)
    {
        addNewPackage <- map["AddNewPackage"]
    }

}
