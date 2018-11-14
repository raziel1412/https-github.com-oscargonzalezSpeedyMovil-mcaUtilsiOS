//
//	GetTempPasswordRequest.swift
//	Model file Generated using: 
//	Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport 
//	(forked from Ahmed-Ali's JSONExport)
//

import Foundation
import ObjectMapper

/// Clase que representa el Request utilizado para consumir el servicio GetTempPassword. Cuando el usuario olvida su contraseña, el sistema la restablece y se la envía
/// Forma parte del adaptador MC_IdentityManagementAdapter
class GetTempPasswordRequest : NSObject,Mappable{

	var getTempPassword : GetTempPassword?

    override init() {
        getTempPassword = GetTempPassword();
    }

    required init?(map: Map) {

    }

	func mapping(map: Map)
	{
		getTempPassword <- map["GetTempPassword"]
		
	}

}
