//
//	SubscriptionPeriod.swift
//	Model file Generated using: 
//	Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport 
//	(forked from Ahmed-Ali's JSONExport)
//

import Foundation
import ObjectMapper

/// Clase que representa los datos del Response utilizado para consumir el servicio RetrieveVASDetails. Regresa el listado a detalle de los servicios de valor agregado
/// Forma parte del adaptador MC_ServiceManagementAdapter
class SubscriptionPeriod : NSObject,Mappable{

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
