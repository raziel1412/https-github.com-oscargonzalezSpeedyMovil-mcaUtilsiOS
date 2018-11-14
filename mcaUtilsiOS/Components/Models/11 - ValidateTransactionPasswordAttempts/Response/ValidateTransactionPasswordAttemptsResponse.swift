//
//	ValidateTransactionPasswordAttemptsResponse.swift
//	Model file Generated using: 
//	Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport 
//	(forked from Ahmed-Ali's JSONExport)
//

import Foundation
import ObjectMapper

/// Clase que representa los datos del Response utilizado para consumir el servicio ValidateTransactionPasswordAttempts. Valida que los reintentos de captura de contraseña (UpdateTransactionPasswordAttempts) no rebasen la regla establecida
/// Forma parte del adaptador MC_IdentityManagementAdapter
class ValidateTransactionPasswordAttemptsResponse : BaseResponse{

    override init() {
        super.init()
    }

    required init?(map: Map) {
        super.init(map: map);
    }

    override func mapping(map: Map)
    {
        super.mapping(map: map);
		
	}

}
