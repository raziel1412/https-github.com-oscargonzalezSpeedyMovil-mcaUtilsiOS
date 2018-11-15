//
//	SwitchPlanRequest.swift
//	Model file Generated using: 
//	Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport 
//	(forked from Ahmed-Ali's JSONExport)
//

import Foundation
import ObjectMapper

/// Clase que representa el Request utilizado para consumir el servicio SwitchPlan. Aplica el cambio de plan elegido (upSell | Incremento)
/// Forma parte del adaptador MC_ServiceManagementAdapter
class SwitchPlanRequest : NSObject,Mappable{

	var switchPlan : SwitchPlan?

    override init() {
        switchPlan = SwitchPlan()
    }

    required init?(map: Map) {
        
    }

	func mapping(map: Map)
	{
		switchPlan <- map["SwitchPlan"]
		
	}

}
