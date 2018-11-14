//
//	IdentityLoginResult.swift
//	Model file Generated using: 
//	Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport 
//	(forked from Ahmed-Ali's JSONExport)
//

import Foundation
import ObjectMapper

/// Clase que representa el Response utilizado para consumir el servicio IdentityLogin. Validación de usuario y contraseña
/// Forma parte del adaptador MC_IdentityLoginAdapter
class IdentityLoginResult : BaseResult {

	var identityLoginResponse : IdentityLoginResponse?
    var identityLoginFault : BaseFault?

    override init() {
        super.init();
    }

    required init?(map: Map) {
        super.init();
    }

    override func mapping(map: Map)
    {
        super.mapping(map: map);
		identityLoginResponse <- map["IdentityLoginResponse"]
        identityLoginFault <- map["IdentityLoginFault"]
	}

}
