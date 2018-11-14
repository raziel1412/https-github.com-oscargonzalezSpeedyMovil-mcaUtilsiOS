//
//	RetrieveProfileInformation.swift
//	Model file Generated using: 
//	Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport 
//	(forked from Ahmed-Ali's JSONExport)
//

import Foundation
import ObjectMapper

/// Clase que representa los datos del Request utilizado para consumir el servicio RetrieveProfileInformation. Despliega la información del perfil de la cuenta de usuario
/// Forma parte del adaptador MC_IdentityManagementAdapter
class RetrieveProfileInformation : BaseRequest{

    var lineOfBusiness : String?

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
		
	}

}
