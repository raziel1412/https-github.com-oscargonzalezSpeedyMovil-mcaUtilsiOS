//
//  CacDatesTexts.swift
//  MiClaro
//
//  Created by Omar Israel Trujillo Osornio on 10/24/18.
//  Copyright © 2018 am. All rights reserved.
//

import Foundation
import ObjectMapper

class CacDatesTexts : NSObject, Mappable{
    
    var cacDates : String?
    var cacDatesDescription : String?
    var cacDatesFirstButtonDescription : String?
    var cacDatesFirstButtonTitle : String?
    var cacDatesHeader : String?
    var cacDatesSecondButtonDescription : String?
    var cacDatesSecondButtonTitle : String?
    var cacDatesTitle : String?
    var cacDatesViewDatesHeader : String?
    
    
    override init(){}
    
    required init?(map: Map) {
    }
    
    
    func mapping(map: Map)
    {
        cacDates <- map["cacDates"]
        cacDatesDescription <- map["cacDatesDescription"]
        cacDatesFirstButtonDescription <- map["cacDatesFirstButtonDescription"]
        cacDatesFirstButtonTitle <- map["cacDatesFirstButtonTitle"]
        cacDatesHeader <- map["cacDatesHeader"]
        cacDatesSecondButtonDescription <- map["cacDatesSecondButtonDescription"]
        cacDatesSecondButtonTitle <- map["cacDatesSecondButtonTitle"]
        cacDatesTitle <- map["cacDatesTitle"]
        cacDatesViewDatesHeader <- map["cacDatesViewDatesHeader"]
        
    }
    
}
