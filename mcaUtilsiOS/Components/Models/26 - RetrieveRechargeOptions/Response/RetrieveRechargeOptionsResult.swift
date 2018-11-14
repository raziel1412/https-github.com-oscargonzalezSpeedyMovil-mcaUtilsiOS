//
//	RetrieveRechargeOptionsResult.swift
//	Model file Generated using: 
//	Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport 
//	(forked from Ahmed-Ali's JSONExport)
//

import Foundation
import ObjectMapper

/// Clase que representa el Response utilizado para consumir el servicio RetrieveRechargeOptions. Para definir valores posibles de cada característica (voz | datos | texto) [BAM.RetrievePromotions  | BAM.RetrievePlans]
/// Forma parte del adaptador MC_ServiceManagementAdapter
class RetrieveRechargeOptionsResult : BaseResult {

	var retrieveRechargeOptionsResponse : RetrieveRechargeOptionsResponse?
    var retrieveRechargeOptionsFault : BaseFault?

    override init() {
        super.init();
    }

    required init?(map: Map) {
        super.init();
    }

    override func mapping(map: Map)
    {
        super.mapping(map: map);
		retrieveRechargeOptionsResponse <- map["RetrieveRechargeOptionsResponse"]
        retrieveRechargeOptionsFault <- map["RetrieveRechargeOptionsFault"]
	}

}
