//
//	RetrieveAssociatedAccountsResult.swift
//	Model file Generated using: 
//	Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport 
//	(forked from Ahmed-Ali's JSONExport)
//

import Foundation
import ObjectMapper

/// Clase que representa el Response utilizado para consumir el servicio RetrieveAssociatedAccounts. Regresa la lista de cuentas asociadas a un perfil de usuario y para un tipo de cuenta en particular
/// Forma parte del adaptador MC_AccountManagementAdapter
class RetrieveAssociatedAccountsResult : BaseResult {

	var retrieveAssociatedAccountsResponse : RetrieveAssociatedAccountsResponse?
    var retrieveAssociatedAccountsFault : BaseFault?

    override init() {
        super.init();
    }

    required init?(map: Map) {
        super.init();
    }

    override func mapping(map: Map)
    {
        super.mapping(map: map);
		retrieveAssociatedAccountsResponse <- map["RetrieveAssociatedAccountsResponse"]
        retrieveAssociatedAccountsFault <- map["RetrieveAssociatedAccountsFault"]
	}

}
