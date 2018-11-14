//
//  Contact.swift
//  MiClaro
//
//  Created by Omar Israel Trujillo Osornio on 10/11/18.
//  Copyright © 2018 am. All rights reserved.
//

import Foundation
import ObjectMapper

class Contact : BaseRequest{
    
    var addressContact : String?
    var emailContactAddress : String?
    var mobileContactNumber : String?
    var userFirstName : String?
    var userLastName : String?
    var userProfileID : String?
    var userSecondLastName : String?
    
    
    override init() {
        super.init()
    }
    required init?(map: Map) {
        super.init(map: map);
    }
    
    
    override func mapping(map: Map)
    {
        super.mapping(map: map);
        addressContact <- map["AddressContact"]
        emailContactAddress <- map["EmailContactAddress"]
        mobileContactNumber <- map["MobileContactNumber"]
        userFirstName <- map["UserFirstName"]
        userLastName <- map["UserLastName"]
        userProfileID <- map["UserProfileID"]
        userSecondLastName <- map["UserSecondLastName"]
        
    }
    

    
}
