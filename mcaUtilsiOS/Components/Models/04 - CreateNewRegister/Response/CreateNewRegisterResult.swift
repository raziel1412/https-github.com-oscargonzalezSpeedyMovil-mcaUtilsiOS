//
//	CreateNewRegisterResult.swift
//	Model file Generated using: 
//	Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport 
//	(forked from Ahmed-Ali's JSONExport)
//

import Foundation
import ObjectMapper


/// Clase que representa el Response utilizado para consumir el servicio CreateNewRegister. Crea un nuevo registro de cuenta  en los sistemas de backend permitiendo la administración de los servicios
/// Forma parte del adaptador MC_IdentityManagementAdapter
class CreateNewRegisterResult : BaseResult{

	var createNewRegisterResponse : CreateNewRegisterResponse?
    var createNewRegisterFault : BaseFault?

    override init() {
        super.init();
    }

    required init?(map: Map) {
        super.init();
    }

    override func mapping(map: Map)
    {
        super.mapping(map: map);
		createNewRegisterResponse <- map["CreateNewRegisterResponse"]
		createNewRegisterFault <- map["CreateNewRegisterFault"]
	}

}
