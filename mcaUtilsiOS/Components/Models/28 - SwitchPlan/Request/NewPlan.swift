//
//	NewPlan.swift
//	Model file Generated using: 
//	Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport 
//	(forked from Ahmed-Ali's JSONExport)
//

import Foundation
import ObjectMapper

/// Clase que representa los datos del Request utilizado para consumir el servicio SwitchPlan. Aplica el cambio de plan elegido (upSell | Incremento)
/// Forma parte del adaptador MC_ServiceManagementAdapter
class NewPlan : NSObject,Mappable{

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
