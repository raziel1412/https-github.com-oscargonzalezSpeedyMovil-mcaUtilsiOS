//
//	UpdateProfileInformationResult.swift
//	Model file Generated using: 
//	Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport 
//	(forked from Ahmed-Ali's JSONExport)
//

import Foundation
import ObjectMapper

/// Clase que representa los datos del Response utilizado para consumir el servicio UpdateProfileInformation. Actualiza la información de perfil de la cuenta de usuario
/// Forma parte del adaptador MC_IdentityManagementAdapter
class UpdateProfileInformationResult : BaseResult {

	var updateProfileInformationResponse : UpdateProfileInformationResponse?
    var updateProfileInformationFault : BaseFault?

    override init() {
        super.init();
    }

    required init?(map: Map) {
        super.init();
    }

    override func mapping(map: Map)
    {
        super.mapping(map: map);
		updateProfileInformationResponse <- map["UpdateProfileInformationResponse"]
		updateProfileInformationFault <- map["UpdateProfileInformationFault"]
	}

}
