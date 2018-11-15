//
//	InfoSupport.swift
//	Model file Generated using: 
//	Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport 
//	(forked from Ahmed-Ali's JSONExport)
//

import Foundation
import ObjectMapper

/// Clase que representa los datos del Request utilizado para consumir el servicio HelpSupportRequest
class InfoSupport : NSObject, Mappable{

	var soVersion : String?
	var userAgent : String?
	var userId : String?
	var versionCode : String?
	var versionName : String?


    override init() {
    }

    required init?(map: Map) {
    }

    func mapping(map: Map)
    {
		soVersion <- map["soVersion"]
		userAgent <- map["userAgent"]
		userId <- map["userId"]
		versionCode <- map["versionCode"]
		versionName <- map["versionName"]
		
	}

}
