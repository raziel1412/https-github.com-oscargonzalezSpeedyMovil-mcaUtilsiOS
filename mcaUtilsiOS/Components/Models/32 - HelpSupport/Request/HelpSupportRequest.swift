//
//	HelpSupportRequest.swift
//	Model file Generated using: 
//	Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport 
//	(forked from Ahmed-Ali's JSONExport)
//

import Foundation
import ObjectMapper

/// Clase que representa el Request utilizado para consumir el servicio HelpSupportRequest
class HelpSupportRequest : NSObject, Mappable{

	var info : InfoSupport?
	var message : String?
	var userMail : String?


    override init() {
    }

    required init?(map: Map) {
    }

    func mapping(map: Map)
    {
		info <- map["info"]
		message <- map["message"]
		userMail <- map["userMail"]
		
	}

}
