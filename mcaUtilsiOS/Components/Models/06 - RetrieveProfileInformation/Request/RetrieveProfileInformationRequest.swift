//
//	RetrieveProfileInformationRequest.swift
//	Model file Generated using: 
//	Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport 
//	(forked from Ahmed-Ali's JSONExport)
//

import Foundation
import ObjectMapper

/// Clase que representa el Request utilizado para consumir el servicio RetrieveProfileInformation. Despliega la información del perfil de la cuenta de usuario
/// Forma parte del adaptador MC_IdentityManagementAdapter
class RetrieveProfileInformationRequest : NSObject,Mappable{

	var retrieveProfileInformation : RetrieveProfileInformation?

    override init() {
        retrieveProfileInformation = RetrieveProfileInformation();
    }

    required init?(map: Map) {
        
    }

	func mapping(map: Map)
	{
		retrieveProfileInformation <- map["RetrieveProfileInformation"]
		
	}

}
