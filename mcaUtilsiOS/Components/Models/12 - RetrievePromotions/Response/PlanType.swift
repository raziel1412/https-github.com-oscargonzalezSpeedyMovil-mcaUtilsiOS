//
//	PlanType.swift
//	Model file Generated using: 
//	Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport 
//	(forked from Ahmed-Ali's JSONExport)
//

import Foundation
import ObjectMapper

/// Clase que representa los datos del Response utilizado para consumir el servicio RetrievePromotions. Esta operación permite obtener promociones que aplicables  a la cuenta de usuario,  promociones genéricas,  planes recomendados y servicios de valor agregado (Claro Ideas)
/// Forma parte del adaptador MC_BusinessAnalyticsManagementAdapter
class PlanType : NSObject,Mappable{

    var planAmount : Float?
    var planCurrency : String?
    var planDescription : String?
    var planID : String?
    var planLines : [PlanLine]?
    var planName : String?
    var planType : String?
    
    override init() {

    }

    required init?(map: Map) {

    }

	func mapping(map: Map)
	{
		planAmount <- map["PlanAmount"]
		planCurrency <- map["PlanCurrency"]
		planDescription <- map["PlanDescription"]
		planID <- map["PlanID"]
		planLines <- map["PlanLines"]
		planName <- map["PlanName"]
		planType <- map["PlanType"]
		
	}

}
