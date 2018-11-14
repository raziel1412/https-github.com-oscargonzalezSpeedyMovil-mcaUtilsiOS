//
//	ValidateTempPassword.swift
//	Model file Generated using: 
//	Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport 
//	(forked from Ahmed-Ali's JSONExport)
//

import Foundation
import ObjectMapper

/// Clase que representa los datos del Request utilizado para consumir el servicio ValidateTempPassword. Valida la contraseña enviada por el proceso de restablecimiento en el método GetTempPassword
/// Forma parte del adaptador MC_IdentityManagementAdapter
class ValidateTempPassword : BaseRequest{

    var lineOfBusiness : String?
    var password : String?

    override init() {
        super.init()
    }

    required init?(map: Map) {
        super.init(map: map);
    }

    override func mapping(map: Map)
    {
        super.mapping(map: map);
		lineOfBusiness <- map["LineOfBusiness"]
		password <- map["password"]
		
	}

}
