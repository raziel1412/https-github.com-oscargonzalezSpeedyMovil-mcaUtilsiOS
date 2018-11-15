//
//  RetrieveSMSPremiumBlackListStatusRequest.swift
//  MiClaro
//
//  Created by Omar Israel Trujillo Osornio on 13/09/18.
//  Copyright © 2018 am. All rights reserved.
//
import Foundation
import ObjectMapper


class RetrieveSMSPremiumBlackListStatusRequest : NSObject, Mappable{
    
    var retrieveSMSPremiumBlackListStatus : RetrieveSMSPremiumBlackListStatus?
    
    
    override init() {
        retrieveSMSPremiumBlackListStatus = RetrieveSMSPremiumBlackListStatus()
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map)
    {
        retrieveSMSPremiumBlackListStatus <- map["RetrieveSMSPremiumBlackListStatus"]
        
    }
    
}
