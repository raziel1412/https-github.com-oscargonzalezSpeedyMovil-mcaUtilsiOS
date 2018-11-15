//
//	RetrieveAccountListResult.swift
//	Model file Generated using: 
//	Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport 
//	(forked from Ahmed-Ali's JSONExport)
//

import Foundation
import ObjectMapper

/// Clase que representa el Response utilizado para consumir el servicio RetrieveAccountList. Regresa la lista de cuentas asociadas a un ID de perfil
/// Forma parte del adaptador MC_AccountManagementAdapter
class RetrieveAccountListResult : BaseResult {

	var retrieveAccountListResponse : RetrieveAccountListResponse?
    var retrieveAccountListFault : BaseFault?

    override init() {
        super.init();
    }

    required init?(map: Map) {
        super.init();
    }

    override func mapping(map: Map)
    {
        super.mapping(map: map);
		retrieveAccountListResponse <- map["RetrieveAccountListResponse"]
        retrieveAccountListFault <- map["RetrieveAccountListFault"]
	}

}
