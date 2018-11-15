//
//	UpdateTransactionPasswordAttemptsResult.swift
//	Model file Generated using: 
//	Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport 
//	(forked from Ahmed-Ali's JSONExport)
//

import Foundation
import ObjectMapper

/// Clase que representa el Response utilizado para consumir el servicio UpdateTransactionPasswordAttempts. Actualiza reintentos de captura de contraseña
/// Forma parte del adaptador MC_IdentityManagementAdapter
class UpdateTransactionPasswordAttemptsResult : BaseResult {

	var updateTransactionPasswordAttemptsResponse : UpdateTransactionPasswordAttemptsResponse?
    var updateTransactionPasswordAttemptsFault : BaseFault?

    override init() {
        super.init();
    }

    required init?(map: Map) {
        super.init();
    }

    override func mapping(map: Map)
    {
        super.mapping(map: map);
		updateTransactionPasswordAttemptsResponse <- map["UpdateTransactionPasswordAttemptsResponse"]
		updateTransactionPasswordAttemptsFault <- map["UpdateTransactionPasswordAttemptsFault"]
	}

}
