//
//	ValidateTempPasswordRequest.swift
//	Model file Generated using: 
//	Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport 
//	(forked from Ahmed-Ali's JSONExport)
//

import Foundation
import ObjectMapper

/// Clase que representa el Request utilizado para consumir el servicio ValidateTempPassword. Valida la contraseña enviada por el proceso de restablecimiento en el método GetTempPassword
/// Forma parte del adaptador MC_IdentityManagementAdapter
class ValidateTempPasswordRequest : NSObject,Mappable{

	var validateTempPassword : ValidateTempPassword?

    override init() {
        validateTempPassword = ValidateTempPassword()
    }

    required init?(map: Map) {
        
    }

	func mapping(map: Map)
	{
		validateTempPassword <- map["ValidateTempPassword"]
		
	}

}
