//
//  RetrieveSMSPremiumHistoryRequest.swift
//  MiClaro
//
//  Created by Omar Israel Trujillo Osornio on 13/09/18.
//  Copyright © 2018 am. All rights reserved.
//
import Foundation
import ObjectMapper

class RetrieveSMSPremiumHistoryRequest : NSObject, Mappable{
    
    var retrieveSMSPremiumHistory : RetrieveSMSPremiumHistory?
    
    
    override init() {
        retrieveSMSPremiumHistory = RetrieveSMSPremiumHistory()
    }
    
    required init?(map: Map) {
        
    }
 
    
    func mapping(map: Map)
    {
        retrieveSMSPremiumHistory <- map["RetrieveSMSPremiumHistory"]
        
    }
    
    
}
