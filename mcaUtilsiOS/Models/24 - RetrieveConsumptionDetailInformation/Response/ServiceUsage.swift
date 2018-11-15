//
//	ServiceUsage.swift
//	Model file Generated using: 
//	Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport 
//	(forked from Ahmed-Ali's JSONExport)
//

import Foundation
import ObjectMapper

/// Clase que representa los datos del Response utilizado para consumir el servicio RetrieveConsumptionDetailInformation. Regresa el detalle de uso de los servicios de una cuenta para un periodo en especifico
/// Forma parte del adaptador MC_ServiceManagementAdapter
class ServiceUsage : NSObject,Mappable{

    var serviceFeatureUsage : [ServiceFeatureUsage]?
    var serviceID : String?
    var serviceType : String?
    var serviceUsagePeriod : ServiceUsagePeriod?
    
    override init() {

    }

    required init?(map: Map) {
        
    }

	func mapping(map: Map)
	{
		serviceFeatureUsage <- map["ServiceFeatureUsage"]
		serviceID <- map["ServiceID"]
		serviceType <- map["ServiceType"]
		serviceUsagePeriod <- map["ServiceUsagePeriod"]
		
	}

}
