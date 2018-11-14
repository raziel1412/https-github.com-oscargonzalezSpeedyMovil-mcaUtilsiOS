//
//	ValidateTransactionPasswordAttempt.swift
//	Model file Generated using: 
//	Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport 
//	(forked from Ahmed-Ali's JSONExport)
//

import Foundation
import ObjectMapper

/// Clase que representa los datos del Request utilizado para consumir el servicio ValidateTransactionPasswordAttempts. Valida que los reintentos de captura de contraseña (UpdateTransactionPasswordAttempts) no rebasen la regla establecida
/// Forma parte del adaptador MC_IdentityManagementAdapter
class ValidateTransactionPasswordAttempt : BaseRequest{

    var accountID : String?
    var lineOfBusiness : String?

    override init() {
        super.init()
    }

    required init?(map: Map) {
        super.init(map: map);
    }

    override func mapping(map: Map)
    {
        super.mapping(map: map);
		accountID <- map["AccountID"]
		lineOfBusiness <- map["LineOfBusiness"]
		
	}

}
