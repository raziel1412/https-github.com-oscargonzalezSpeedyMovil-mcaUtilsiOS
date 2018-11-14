//
//	RetrieveAccountDetailsResult.swift
//	Model file Generated using: 
//	Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport 
//	(forked from Ahmed-Ali's JSONExport)
//

import Foundation
import ObjectMapper

/// Clase que representa el Response utilizado para consumir el servicio RetrieveAccountDetails. Obtiene el detalle de una cuenta, basado en la respuesta de RetrieveAccountList
/// Forma parte del adaptador MC_AccountManagementAdapter
class RetrieveAccountDetailsResult : BaseResult {
    var retrieveAccountDetailsResponse : RetrieveAccountDetailsResponse?
    var retrieveAccountDetailsFault : BaseFault?

    override init() {
        super.init();
    }

    required init?(map: Map) {
        super.init();
    }

    override func mapping(map: Map)
    {
        super.mapping(map: map);
        retrieveAccountDetailsResponse <- map["RetrieveAccountDetailsResponse"]
        retrieveAccountDetailsFault <- map["RetrieveAccountDetailsFault"]
	}

}
