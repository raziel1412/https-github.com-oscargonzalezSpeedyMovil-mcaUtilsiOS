//
//	RetrieveSwitchPlanImplicationsRequest.swift
//	Model file Generated using: 
//	Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport 
//	(forked from Ahmed-Ali's JSONExport)
//

import Foundation
import ObjectMapper

/// Clase que representa el Request utilizado para consumir el servicio RetrieveSwitchPlanImplications. Para obtener el costo y la información relacionada a un cambio de plan
/// Forma parte del adaptador MC_ServiceManagementAdapter
class RetrieveSwitchPlanImplicationsRequest : NSObject,Mappable{

	var retrieveSwitchPlanImplications : RetrieveSwitchPlanImplication?

    override init() {
        retrieveSwitchPlanImplications = RetrieveSwitchPlanImplication()
    }

    required init?(map: Map) {
        
    }

	func mapping(map: Map)
	{
		retrieveSwitchPlanImplications <- map["RetrieveSwitchPlanImplications"]
		
	}

}
