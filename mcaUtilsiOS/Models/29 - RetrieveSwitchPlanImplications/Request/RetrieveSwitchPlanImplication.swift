//
//	RetrieveSwitchPlanImplication.swift
//	Model file Generated using: 
//	Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport 
//	(forked from Ahmed-Ali's JSONExport)
//

import Foundation
import ObjectMapper

/// Clase que representa los datos del Request utilizado para consumir el servicio RetrieveSwitchPlanImplications. Para obtener el costo y la información relacionada a un cambio de plan
/// Forma parte del adaptador MC_ServiceManagementAdapter
class RetrieveSwitchPlanImplication : BaseRequest{

    var accountId : String?
    var lineOfBusiness : String?
    var newPlan : NewPlan?
    var oldPlan : NewPlan?

    override init() {
        super.init()
    }

    required init?(map: Map) {
        super.init(map: map);
    }

    override func mapping(map: Map)
    {
        super.mapping(map: map);
		accountId <- map["AccountId"]
		lineOfBusiness <- map["LineOfBusiness"]
		newPlan <- map["NewPlan"]
		oldPlan <- map["OldPlan"]
		
	}

}
