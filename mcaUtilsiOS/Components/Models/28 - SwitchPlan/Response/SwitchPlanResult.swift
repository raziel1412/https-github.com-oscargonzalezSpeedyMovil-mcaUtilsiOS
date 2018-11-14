//
//	SwitchPlanResult.swift
//	Model file Generated using: 
//	Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport 
//	(forked from Ahmed-Ali's JSONExport)
//

import Foundation
import ObjectMapper

/// Clase que representa el Response utilizado para consumir el servicio SwitchPlan. Aplica el cambio de plan elegido (upSell | Incremento)
/// Forma parte del adaptador MC_ServiceManagementAdapter
class SwitchPlanResult : BaseResult {

	var switchPlanResponse : SwitchPlanResponse?
    var switchPlanFault : BaseFault?

    override init() {
        super.init();
    }

    required init?(map: Map) {
        super.init();
    }

    override func mapping(map: Map)
    {
        super.mapping(map: map);
		switchPlanResponse <- map["SwitchPlanResponse"]
        switchPlanFault <- map["SwitchPlanFault"]
	}

}
