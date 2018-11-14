//
//	GetTempPasswordResponse.swift
//	Model file Generated using: 
//	Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport 
//	(forked from Ahmed-Ali's JSONExport)
//

import Foundation
import ObjectMapper

/// Clase que representa los datos del Response utilizado para consumir el servicio GetTempPassword. Cuando el usuario olvida su contraseña, el sistema la restablece y se la envía
/// Forma parte del adaptador MC_IdentityManagementAdapter
class GetTempPasswordResponse : BaseResponse {

    var temporaryPassword : String?

    override init() {
        super.init()
    }

    required init?(map: Map) {
        super.init(map: map);
    }

	override func mapping(map: Map)
	{
        super.mapping(map: map);
		temporaryPassword <- map["TemporaryPassword"]
		
	}

}
