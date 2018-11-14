//
//	BillingPeriod.swift
//	Model file Generated using: 
//	Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport 
//	(forked from Ahmed-Ali's JSONExport)
//

import Foundation
import ObjectMapper

/// Clase que representa los datos del Response utilizado para consumir el servicio RetrieveBillDetails. Esta operación regresa los detalles de las facturas
/// Forma parte del adaptador MC_BillingManagementAdapter
class BillingPeriod : NSObject,Mappable{

    var endDate : String?
    var startDate : String?

    override init() {

    }

    required init?(map: Map) {

    }

	func mapping(map: Map)
	{
		endDate <- map["EndDate"]
		startDate <- map["StartDate"]
		
	}

}
