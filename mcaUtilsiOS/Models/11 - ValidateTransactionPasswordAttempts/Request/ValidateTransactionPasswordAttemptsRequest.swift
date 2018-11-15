//
//	ValidateTransactionPasswordAttemptsRequest.swift
//	Model file Generated using: 
//	Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport 
//	(forked from Ahmed-Ali's JSONExport)
//

import Foundation
import ObjectMapper

/// Clase que representa el Request utilizado para consumir el servicio ValidateTransactionPasswordAttempts. Valida que los reintentos de captura de contraseña (UpdateTransactionPasswordAttempts) no rebasen la regla establecida
/// Forma parte del adaptador MC_IdentityManagementAdapter
class ValidateTransactionPasswordAttemptsRequest : NSObject,Mappable{

	var validateTransactionPasswordAttempts : ValidateTransactionPasswordAttempt?

    override init() {
        validateTransactionPasswordAttempts = ValidateTransactionPasswordAttempt()
    }

    required init?(map: Map) {
        
    }

	func mapping(map: Map)
	{
		validateTransactionPasswordAttempts <- map["ValidateTransactionPasswordAttempts"]
		
	}

}
