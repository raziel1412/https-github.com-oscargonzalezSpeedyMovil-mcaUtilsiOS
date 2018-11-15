//
//	ServiceFeatureUsage.swift
//	Model file Generated using: 
//	Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport 
//	(forked from Ahmed-Ali's JSONExport)
//

import Foundation
import ObjectMapper

/// Clase que representa los datos del Response utilizado para consumir el servicio RetrieveConsumptionDetailInformation. Regresa el detalle de uso de los servicios de una cuenta para un periodo en especifico
/// Forma parte del adaptador MC_ServiceManagementAdapter
class ServiceFeatureUsage : NSObject,Mappable{

    var featureUsage : FeatureUsage?
    var serviceFeatureSubType : String?
    var serviceFeatureType : String?
    var serviceFeatureUsageLimit : ServiceFeatureUsageLimit?
    var serviceUsagePeriod : ServiceUsagePeriod?
    var featureReminder: FeatureRemainder?
    
    override init() {

    }

    required init?(map: Map) {
        
    }

	func mapping(map: Map)
	{
        featureUsage <- map["FeatureUsage"]
        serviceFeatureSubType <- map["ServiceFeatureSubType"]
        serviceFeatureType <- map["ServiceFeatureType"]
        serviceFeatureUsageLimit <- map["ServiceFeatureUsageLimit"]
        serviceUsagePeriod <- map["ServiceUsagePeriod"]
        featureReminder <- map["FeatureRemainder"]
	}

}
