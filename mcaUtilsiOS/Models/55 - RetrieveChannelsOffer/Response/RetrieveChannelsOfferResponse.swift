//
//  RetrieveChannelsOfferResponse.swift
//  MiClaro
//
//  Created by Omar Israel Trujillo Osornio on 10/11/18.
//  Copyright © 2018 am. All rights reserved.
//

import Foundation
import ObjectMapper

class RetrieveChannelsOfferResponse : BaseResponse{
    

    var compId : Int?
    var contratoSec : String?
    var servId : Int?
    var typeListChannels : [TypeListChannels]?
    
    
    override init() {
        super.init()
    }
    
    required init?(map: Map) {
        super.init(map: map);
    }
    
    override func mapping(map: Map)
    {
        super.mapping(map: map);
        compId <- map["CompId"]
        contratoSec <- map["ContratoSec"]
        servId <- map["ServId"]
        typeListChannels <- map["TypeListChannels"]
        
    }
}
