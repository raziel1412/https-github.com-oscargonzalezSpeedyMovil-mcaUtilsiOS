//
//	IdentityLoginRequest.swift
//	Model file Generated using: 
//	Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport 
//	(forked from Ahmed-Ali's JSONExport)
//

import Foundation
import ObjectMapper

/// Clase que representa el Request utilizado para consumir el servicio IdentityLogin. Validación de usuario y contraseña
/// Forma parte del adaptador MC_IdentityLoginAdapter
class IdentityLoginRequest : NSObject,Mappable{

	var identityLogin : IdentityLogin?

    override init() {
        identityLogin = IdentityLogin();

    }

    required init?(map: Map) {

    }

	func mapping(map: Map)
	{
		identityLogin <- map["IdentityLogin"]
		
	}

}
