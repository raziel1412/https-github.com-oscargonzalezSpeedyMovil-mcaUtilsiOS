//
//	RetrievePlansResult.swift
//	Model file Generated using: 
//	Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport 
//	(forked from Ahmed-Ali's JSONExport)
//

import Foundation
import ObjectMapper

/// Clase que representa el Response utilizado para consumir el servicio RetrievePlans. Esta operación podría regresar los planes sugeridos disponibles para la cuenta, basados en las características del plan actual
/// Forma parte del adaptador MC_BusinessAnalyticsManagementAdapter
class RetrievePlansResult : BaseResult{

    var retrievePlansResponse : RetrievePlansResponse?;
    var retrievePlansFault : BaseFault?;

    override init() {
        super.init();
    }

    required init?(map: Map) {
        super.init();
    }

    override func mapping(map: Map)
    {
        super.mapping(map: map);
        retrievePlansResponse <- map["RetrievePlansResponse"];
        retrievePlansFault <- map["RetrievePlansFault"];
    }
}
