//
//  RetrieveChannelsOfferRequest.swift
//  MiClaro
//
//  Created by Omar Israel Trujillo Osornio on 10/11/18.
//  Copyright © 2018 am. All rights reserved.
//

import Foundation
import ObjectMapper


class RetrieveChannelsOfferRequest : NSObject, Mappable{
    
    var retrieveChannelsOffer : RetrieveChannelsOffer?
    
    
    
    override init() {
        retrieveChannelsOffer = RetrieveChannelsOffer();
    }
    required init?(map: Map) {}
    
    func mapping(map: Map)
    {
        retrieveChannelsOffer <- map["RetrieveChannelsOffer"]
        
    }

    
}
