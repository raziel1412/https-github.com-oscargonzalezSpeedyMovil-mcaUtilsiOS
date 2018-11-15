//
//	SetPaperlessRequest.swift
//	Model file Generated using: 
//	Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport 
//	(forked from Ahmed-Ali's JSONExport)
//

import Foundation
import ObjectMapper

/// Clase que representa el Request utilizado para consumir el servicio SetPaperless. Aplica la selección del usuario en correspondencia a la opción de paperless
/// Forma parte del adaptador MC_BillingManagementAdapter
class SetPaperlessRequest : NSObject,Mappable{

	var setPaperless : SetPaperles?

    override init() {
        setPaperless = SetPaperles()
    }

    required init?(map: Map) {
        
    }

	func mapping(map: Map)
	{
		setPaperless <- map["SetPaperless"]
		
	}

}
