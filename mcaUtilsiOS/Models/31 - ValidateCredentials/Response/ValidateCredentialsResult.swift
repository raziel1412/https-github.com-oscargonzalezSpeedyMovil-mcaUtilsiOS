//
//	ValidateCredentialsResult.swift
//	Model file Generated using: 
//	Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport 
//	(forked from Ahmed-Ali's JSONExport)
//

import Foundation
import ObjectMapper

/// Clase que representa el Response utilizado para consumir el servicio ValidateCredentials. Validación de usuario y contraseña
/// Forma parte del adaptador MC_IdentityLoginAdapter
class ValidateCredentialsResult : BaseResult {

	var validateCredentialsResponse : ValidateCredentialsResponse?
    var validateCredentialsFault : BaseFault?

    override init() {
        super.init();
    }

    required init?(map: Map) {
        super.init();
    }

    override func mapping(map: Map)
    {
        super.mapping(map: map);
		validateCredentialsResponse <- map["ValidateCredentialsResponse"]
        validateCredentialsFault <- map["ValidateCredentialsFault"]
	}

}
