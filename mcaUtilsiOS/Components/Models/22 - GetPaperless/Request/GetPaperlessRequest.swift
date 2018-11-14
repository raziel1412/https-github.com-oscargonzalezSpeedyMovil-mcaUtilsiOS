//
//	GetPaperlessRequest.swift
//	Model file Generated using: 
//	Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport 
//	(forked from Ahmed-Ali's JSONExport)
//

import Foundation
import ObjectMapper

/// Clase que representa el Request utilizado para consumir el servicio GetPaperless. Despliega si la opción de paperless ha sido seleccionada o no
/// Forma parte del adaptador MC_BillingManagementAdapter
class GetPaperlessRequest : NSObject,Mappable{

	var getPaperless : GetPaperles?

    override init() {
        getPaperless = GetPaperles()

    }

    required init?(map: Map) {

    }

	func mapping(map: Map)
	{
		getPaperless <- map["GetPaperless"]
		
	}

}
