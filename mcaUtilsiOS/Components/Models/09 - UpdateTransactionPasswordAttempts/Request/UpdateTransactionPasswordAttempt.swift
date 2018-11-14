//
//	UpdateTransactionPasswordAttempt.swift
//	Model file Generated using: 
//	Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport 
//	(forked from Ahmed-Ali's JSONExport)
//

import Foundation
import ObjectMapper

/// Clase que representa los datos del Request utilizado para consumir el servicio UpdateTransactionPasswordAttempts. Actualiza reintentos de captura de contraseña
/// Forma parte del adaptador MC_IdentityManagementAdapter
class UpdateTransactionPasswordAttempt : BaseRequest{

	var accountID : String?
	var isSuccess : Bool?
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
		isSuccess <- map["IsSuccess"]
		lineOfBusiness <- map["LineOfBusiness"]
		
	}

}
