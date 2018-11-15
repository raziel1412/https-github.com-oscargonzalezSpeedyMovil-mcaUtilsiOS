//
//	UpdatePasswordResult.swift
//	Model file Generated using: 
//	Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport 
//	(forked from Ahmed-Ali's JSONExport)
//

import Foundation
import ObjectMapper

/// Clase que representa el Response utilizado para consumir el servicio UpdatePassword. Actualiza y aplica una nueva contraseña a la cuenta de usuario
/// Forma parte del adaptador MC_IdentityManagementAdapter
class UpdatePasswordResult : BaseResult {

	var updatePasswordResponse : UpdatePasswordResponse?
    var updatePasswordFault : BaseFault?

    override init() {
        super.init();
    }

    required init?(map: Map) {
        super.init();
    }

    override func mapping(map: Map)
    {
        super.mapping(map: map);
		updatePasswordResponse <- map["UpdatePasswordResponse"]
		updatePasswordFault <- map["UpdatePasswordFault"]
	}

}
