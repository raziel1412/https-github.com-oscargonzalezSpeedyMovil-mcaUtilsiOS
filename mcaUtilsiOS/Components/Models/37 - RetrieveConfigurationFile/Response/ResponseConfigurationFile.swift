//
//  ResponseConfigurationFile.swift
//  MiClaro
//
//  Created by Mauricio Javier Perez Flores on 9/27/17.
//  Copyright © 2017 am. All rights reserved.
//

import UIKit
import ObjectMapper

/// Clase que representa el Response utilizado para consumir el servicio ConfigurationFile
class ResponseConfigurationFile: NSObject, Mappable {

    var code : String?
    var descriptionConfigFile : String?
    var configuration: String?
    
    override init() {
        super.init()
    }
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map)
    {
        code <- map["codigo"]
        descriptionConfigFile <- map["descripcion"]
        configuration <- map["configuracion"]
    }
    
}
