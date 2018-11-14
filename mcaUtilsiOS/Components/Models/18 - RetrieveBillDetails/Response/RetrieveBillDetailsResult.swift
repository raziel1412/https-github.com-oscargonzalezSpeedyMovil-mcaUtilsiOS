//
//	RetrieveBillDetailsResult.swift
//	Model file Generated using: 
//	Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport 
//	(forked from Ahmed-Ali's JSONExport)
//

import Foundation
import ObjectMapper

/// Clase que representa el Response utilizado para consumir el servicio RetrieveBillDetails. Esta operación regresa los detalles de las facturas
/// Forma parte del adaptador MC_BillingManagementAdapter
class RetrieveBillDetailsResult : BaseResult {

	var retrieveBillDetailsResponse : RetrieveBillDetailsResponse?
    var retrieveBillDetailsFault : BaseFault?

    override init() {
        super.init();
    }

    required init?(map: Map) {
        super.init();
    }

    override func mapping(map: Map)
    {
        super.mapping(map: map);
		retrieveBillDetailsResponse <- map["RetrieveBillDetailsResponse"]
        retrieveBillDetailsFault <- map["RetrieveBillDetailsFault"]
	}

}
