//
//	ServiceUsagePeriod.swift
//	Model file Generated using: 
//	Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport 
//	(forked from Ahmed-Ali's JSONExport)
//

import Foundation
import ObjectMapper

/// Clase que representa los datos del Response utilizado para consumir el servicio RetrieveConsumptionDetailInformation. Regresa el detalle de uso de los servicios de una cuenta para un periodo en especifico
/// Forma parte del adaptador MC_ServiceManagementAdapter
class ServiceUsagePeriod : NSObject,Mappable{

    var endDate : String?
    var reportDate : String?
    var startDate : String?
    
    override init() {

    }

    required init?(map: Map) {
        
    }

	func mapping(map: Map)
	{
		endDate <- map["EndDate"]
		startDate <- map["StartDate"]
		reportDate <- map["ReportDate"]
		
	}

}
