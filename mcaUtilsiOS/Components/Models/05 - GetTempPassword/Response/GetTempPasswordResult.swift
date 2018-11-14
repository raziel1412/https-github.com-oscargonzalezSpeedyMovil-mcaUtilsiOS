//
//	GetTempPasswordResult.swift
//	Model file Generated using: 
//	Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport 
//	(forked from Ahmed-Ali's JSONExport)
//

import Foundation
import ObjectMapper

/// Clase que representa el Response utilizado para consumir el servicio GetTempPassword. Cuando el usuario olvida su contraseña, el sistema la restablece y se la envía
/// Forma parte del adaptador MC_IdentityManagementAdapter
class GetTempPasswordResult : BaseResult{

	var getTempPasswordResponse : GetTempPasswordResponse?
    var getTempPasswordFault : BaseFault?

    override init() {
        super.init();
    }

    required init?(map: Map) {
        super.init();
    }

    override func mapping(map: Map)
    {
        super.mapping(map: map);
		getTempPasswordResponse <- map["GetTempPasswordResponse"]
		getTempPasswordFault <- map["GetTempPasswordFault"]
	}

}
