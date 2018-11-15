//
//	UpdateProfileInformationRequest.swift
//	Model file Generated using: 
//	Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport 
//	(forked from Ahmed-Ali's JSONExport)
//

import Foundation
import ObjectMapper

/// Clase que representa el Request utilizado para consumir el servicio UpdateProfileInformation. Actualiza la información de perfil de la cuenta de usuario
/// Forma parte del adaptador MC_IdentityManagementAdapter
class UpdateProfileInformationRequest : NSObject,Mappable{

	var updateProfileInformation : UpdateProfileInformation?

    override init() {
        updateProfileInformation = UpdateProfileInformation()
    }

    required init?(map: Map) {
        
    }

	func mapping(map: Map)
	{
		updateProfileInformation <- map["UpdateProfileInformation"]
		
	}

}
