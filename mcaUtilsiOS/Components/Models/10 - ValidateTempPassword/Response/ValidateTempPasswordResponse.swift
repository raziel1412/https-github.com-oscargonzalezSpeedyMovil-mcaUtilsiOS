//
//	ValidateTempPasswordResponse.swift
//	Model file Generated using: 
//	Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport 
//	(forked from Ahmed-Ali's JSONExport)
//

import Foundation
import ObjectMapper

/// Clase que representa los datos del Response utilizado para consumir el servicio ValidateTempPassword. Valida la contraseña enviada por el proceso de restablecimiento en el método GetTempPassword
/// Forma parte del adaptador MC_IdentityManagementAdapter
class ValidateTempPasswordResponse : BaseResponse {

    override init() {
        super.init()
    }

    required init?(map: Map) {
        super.init(map: map);
    }

    override func mapping(map: Map)
    {
        super.mapping(map: map);

	}

}
