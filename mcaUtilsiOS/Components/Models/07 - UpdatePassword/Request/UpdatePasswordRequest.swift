//
//	UpdatePasswordRequest.swift
//	Model file Generated using: 
//	Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport 
//	(forked from Ahmed-Ali's JSONExport)
//

import Foundation
import ObjectMapper

/// Clase que representa el Request utilizado para consumir el servicio UpdatePassword. Actualiza y aplica una nueva contraseña a la cuenta de usuario
/// Forma parte del adaptador MC_IdentityManagementAdapter
class UpdatePasswordRequest : NSObject,Mappable{

	var updatePassword : UpdatePassword?

    override init() {
        updatePassword = UpdatePassword()
    }

    required init?(map: Map) {
        
    }

	func mapping(map: Map)
	{
		updatePassword <- map["UpdatePassword"]
		
	}

}
