//
//	ValidateCredentialsRequest.swift
//	Model file Generated using: 
//	Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport 
//	(forked from Ahmed-Ali's JSONExport)
//

import Foundation
import ObjectMapper

/// Clase que representa el Request utilizado para consumir el servicio ValidateCredentials. Validación de usuario y contraseña
/// Forma parte del adaptador MC_IdentityLoginAdapter
class ValidateCredentialsRequest : NSObject, Mappable{

	var validateCredentials : ValidateCredential?

    override init() {
        validateCredentials = ValidateCredential();
    }

    required init?(map: Map) {

    }

    func mapping(map: Map)
    {
		validateCredentials <- map["ValidateCredentials"]
		
	}

}
