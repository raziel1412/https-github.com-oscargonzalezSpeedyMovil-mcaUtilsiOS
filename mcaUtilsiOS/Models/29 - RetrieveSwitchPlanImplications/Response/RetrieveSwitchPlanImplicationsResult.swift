//
//	RetrieveSwitchPlanImplicationsResult.swift
//	Model file Generated using: 
//	Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport 
//	(forked from Ahmed-Ali's JSONExport)
//

import Foundation
import ObjectMapper

/// Clase que representa el Response utilizado para consumir el servicio RetrieveSwitchPlanImplications. Para obtener el costo y la información relacionada a un cambio de plan
/// Forma parte del adaptador MC_ServiceManagementAdapter
class RetrieveSwitchPlanImplicationsResult : BaseResult {

	var retrieveSwitchPlanImplicationsResponse : RetrieveSwitchPlanImplicationsResponse?
    var retrieveSwitchPlanImplicationsFault : BaseFault?

    override init() {
        super.init();
    }

    required init?(map: Map) {
        super.init();
    }

    override func mapping(map: Map)
    {
        super.mapping(map: map);
		retrieveSwitchPlanImplicationsResponse <- map["RetrieveSwitchPlanImplicationsResponse"]
		retrieveSwitchPlanImplicationsFault <- map["RetrieveSwitchPlanImplicationsFault"]
	}

}
