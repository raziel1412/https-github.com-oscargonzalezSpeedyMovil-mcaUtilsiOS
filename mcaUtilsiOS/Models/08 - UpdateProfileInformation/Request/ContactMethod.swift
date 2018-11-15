//
//	ContactMethod.swift
//	Model file Generated using: 
//	Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport 
//	(forked from Ahmed-Ali's JSONExport)
//

import Foundation
import ObjectMapper

/// Clase que representa los datos del Request utilizado para consumir el servicio UpdateProfileInformation. Actualiza la información de perfil de la cuenta de usuario
/// Forma parte del adaptador MC_IdentityManagementAdapter
class ContactMethod : NSObject,Mappable{

    var addressContactMethodDetail : [AddressContactMethodDetail]?
    var emailContactMethodDetail : EmailContactMethodDetail?
    var mobileContactMethodDetail : MobileContactMethodDetail?
    
    override init() {

    }

    required init?(map: Map) {

    }

	func mapping(map: Map)
	{
        addressContactMethodDetail <- map["AddressContactMethodDetail"]
        emailContactMethodDetail <- map["EmailContactMethodDetail"]
        mobileContactMethodDetail <- map["MobileContactMethodDetail"]
		
	}

}
