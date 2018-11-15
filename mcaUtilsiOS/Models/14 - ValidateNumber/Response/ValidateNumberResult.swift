//
//	ValidateNumberResult.swift
//	Model file Generated using: 
//	Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport 
//	(forked from Ahmed-Ali's JSONExport)
//

import Foundation
import ObjectMapper

/// Clase que representa el Response utilizado para consumir el servicio ValidateNumber. Valida si el número móvil o el número de cuenta pertenece a Claro
/// Forma parte del adaptador MC_AccountManagementAdapter
class ValidateNumberResult : BaseResult{

	var validateNumberResponse : ValidateNumberResponse?
    var validateNumberFault : BaseFault?

    override init() {
        super.init();
    }

    required init?(map: Map) {
        super.init();
    }

    override func mapping(map: Map)
    {
        super.mapping(map: map);
		validateNumberResponse <- map["ValidateNumberResponse"]
        validateNumberFault <- map["ValidateNumberFault"]		
	}

}
