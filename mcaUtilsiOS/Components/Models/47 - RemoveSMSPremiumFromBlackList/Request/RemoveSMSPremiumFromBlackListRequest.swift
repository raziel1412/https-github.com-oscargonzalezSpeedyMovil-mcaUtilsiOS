//
//  RemoveSMSPremiumFromBlackListRequest.swift
//  MiClaro
//
//  Created by Omar Israel Trujillo Osornio on 13/09/18.
//  Copyright © 2018 am. All rights reserved.
//



import UIKit
import ObjectMapper

class RemoveSMSPremiumFromBlackListRequest : NSObject, Mappable{
    
    var removeSMSPremiumFromBlackList : RemoveSMSPremiumFromBlackList?
    
    
    override init() {
        removeSMSPremiumFromBlackList = RemoveSMSPremiumFromBlackList();
    }
    required init?(map: Map) {}
    
    func mapping(map: Map)
    {
        removeSMSPremiumFromBlackList <- map["RemoveSMSPremiumFromBlackList"]
    }
}
