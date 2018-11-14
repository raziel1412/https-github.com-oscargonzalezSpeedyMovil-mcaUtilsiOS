//
//  AddNewPackage.swift
//  MiClaro
//
//  Created by Omar Israel Trujillo Osornio on 10/11/18.
//  Copyright © 2018 am. All rights reserved.
//

import Foundation
import ObjectMapper

class AddNewPackage : BaseRequest{
    
    var lineOfBusiness : String?
    var mSISDN : String?
    var packageField : String?
    
    

    override init() {
        super.init()
    }
    
    required init?(map: Map) {
        super.init(map: map);
    }
    
    
    override func mapping(map: Map)
    {
        super.mapping(map: map);
        lineOfBusiness <- map["LineOfBusiness"]
        mSISDN <- map["MSISDN"]
        packageField <- map["Package"]
        
    }
}
