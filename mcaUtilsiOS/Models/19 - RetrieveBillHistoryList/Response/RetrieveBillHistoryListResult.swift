//
//	RetrieveBillHistoryListResult.swift
//	Model file Generated using: 
//	Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport 
//	(forked from Ahmed-Ali's JSONExport)
//

import Foundation
import ObjectMapper

/// Clase que representa el Response utilizado para consumir el servicio RetrieveBillHistoryList. Esta operación recuperará una lista de facturas históricas
/// Forma parte del adaptador MC_BillingManagementAdapter
class RetrieveBillHistoryListResult : BaseResult {

	var retrieveBillHistoryListResponse : RetrieveBillHistoryListResponse?
    var retrieveBillHistoryListFault : BaseFault?

    override init() {
        super.init();
    }

    required init?(map: Map) {
        super.init();
    }

    override func mapping(map: Map)
    {
        super.mapping(map: map);
		retrieveBillHistoryListResponse <- map["RetrieveBillHistoryListResponse"]
		retrieveBillHistoryListFault <- map["RetrieveBillHistoryListFault"]
	}

}
