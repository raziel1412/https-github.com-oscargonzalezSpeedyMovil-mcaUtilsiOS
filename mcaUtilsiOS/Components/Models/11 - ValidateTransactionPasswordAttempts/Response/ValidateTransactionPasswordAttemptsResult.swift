//
//	ValidateTransactionPasswordAttemptsResult.swift
//	Model file Generated using: 
//	Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport 
//	(forked from Ahmed-Ali's JSONExport)
//

import Foundation
import ObjectMapper

/// Clase que representa el Response utilizado para consumir el servicio ValidateTransactionPasswordAttempts. Valida que los reintentos de captura de contraseña (UpdateTransactionPasswordAttempts) no rebasen la regla establecida
/// Forma parte del adaptador MC_IdentityManagementAdapter
class ValidateTransactionPasswordAttemptsResult : BaseResult {

	var validateTransactionPasswordAttemptsResponse : ValidateTransactionPasswordAttemptsResponse?
    var validateTransactionPasswordAttemptsFault : BaseFault?

    override init() {
        super.init();
    }

    required init?(map: Map) {
        super.init();
    }

    override func mapping(map: Map)
    {
        super.mapping(map: map);
		validateTransactionPasswordAttemptsResponse <- map["ValidateTransactionPasswordAttemptsResponse"]
		validateTransactionPasswordAttemptsFault <- map["ValidateTransactionPasswordAttemptsFault"]
	}

}
