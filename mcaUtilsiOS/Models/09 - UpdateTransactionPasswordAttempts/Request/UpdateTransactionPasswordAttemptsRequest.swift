//
//	UpdateTransactionPasswordAttemptsRequest.swift
//	Model file Generated using: 
//	Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport 
//	(forked from Ahmed-Ali's JSONExport)
//

import Foundation
import ObjectMapper

/// Clase que representa el Request utilizado para consumir el servicio UpdateTransactionPasswordAttempts. Actualiza reintentos de captura de contraseña
/// Forma parte del adaptador MC_IdentityManagementAdapter
class UpdateTransactionPasswordAttemptsRequest : NSObject,Mappable{

	var updateTransactionPasswordAttempts : UpdateTransactionPasswordAttempt?

    override init() {
        updateTransactionPasswordAttempts = UpdateTransactionPasswordAttempt();
    }

    required init?(map: Map) {
        
    }

	func mapping(map: Map)
	{
		updateTransactionPasswordAttempts <- map["UpdateTransactionPasswordAttempts"]
		
	}

}
