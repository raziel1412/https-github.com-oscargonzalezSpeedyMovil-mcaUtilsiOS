//
//	AddressContactMethodDetail.swift
//	Model file Generated using: 
//	Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport 
//	(forked from Ahmed-Ali's JSONExport)
//

import Foundation
import ObjectMapper

/// Clase que representa los datos del Request utilizado para consumir el servicio UpdateProfileInformation. Actualiza la información de perfil de la cuenta de usuario
/// Forma parte del adaptador MC_IdentityManagementAdapter
class AddressContactMethodDetail : NSObject,Mappable{

    var addressDetail : AddressDetail?
    var ispreferedContactMethod : Bool?

    override init() {

    }

    required init?(map: Map) {

    }

	func mapping(map: Map)
	{
		addressDetail <- map["AddressDetail"]
		ispreferedContactMethod <- map["IspreferedContactMethod"]
		
	}

}
