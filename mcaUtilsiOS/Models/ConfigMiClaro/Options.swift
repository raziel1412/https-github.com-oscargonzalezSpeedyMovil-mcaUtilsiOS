//
//  Options.swift
//  MiClaro
//
//  Created by Jorge Isai Garcia Reyes on 18/10/18.
//  Copyright © 2018 am. All rights reserved.
//

import Foundation
import ObjectMapper

class Options: NSObject, Mappable {
    var idOption : String?
    var orderOption : String?
    var codeOption : String?
    var nameOption : String?
    var webViewUrlOption : String?
    var RRSSOption : [RRSSOption]?
    var status : String?
    
    
    required init?(map: Map) {
        
    }
    /// Funcion encargada de mapear el JSON en el array
    /// - parameter Map: Objeto de tipo Map
    func mapping(map: Map)
    {
        idOption <- map["idOption"]
        orderOption <- map["orderOption"]
        codeOption <- map["codeOption"]
        nameOption <- map["nameOption"]
        webViewUrlOption <- map["webViewUrlOption"]
        RRSSOption <- map["RRSSOption"]
        status <- map["status"]
    }
}
