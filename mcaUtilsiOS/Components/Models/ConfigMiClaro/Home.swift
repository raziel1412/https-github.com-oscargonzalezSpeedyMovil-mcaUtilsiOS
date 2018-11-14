//
//  Home.swift
//  MiClaro
//
//  Created by Jonathan Abimael Cruz Orozco on 19/07/18.
//  Copyright © 2018 am. All rights reserved.
//

import Foundation
import ObjectMapper

class Home: NSObject, Mappable {
    var header : String?
    var homeDescription : String?
    var moreOptions : String?
    var optionsDescriptions : String?
    var profileDescription : String?
    var promo : String?
    var promoDescriptions : String?
    var servicesDescription : String?
    var cacDateTitle : String?
    var cacDateDescription : String?

    override init() {
        
    }
    
    /// Función encargada de mapear el JSON correspondiente
    /// - parameter Map: Objeto de tipo Map
    required init?(map: Map) {
        
    }
    
    /// Función encargada de mapear el JSON correspondiente
    /// - parameter Map: Objeto de tipo Map
    func mapping(map: Map)
    {
        header <- map["header"]
        homeDescription <- map["homeDescription"]
        moreOptions <- map["moreOptions"]
        optionsDescriptions <- map["optionsDescriptions"]
        profileDescription <- map["profileDescription"]
        promo <- map["promo"]
        promoDescriptions <- map["promoDescriptions"]
        servicesDescription <- map["servicesDescription"]
        cacDateTitle <- map["cacDateTitle"]
        cacDateDescription <- map["cacDateDescription"]
    }
}
