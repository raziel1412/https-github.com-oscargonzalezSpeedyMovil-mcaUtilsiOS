//
//	MobileContactMethodDetail.swift
//	Model file Generated using: 
//	Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport 
//	(forked from Ahmed-Ali's JSONExport)
//

import Foundation
import ObjectMapper

/// Clase que representa los datos del Response utilizado para consumir el servicio RetrieveProfileInformation. Despliega la información del perfil de la cuenta de usuario
/// Forma parte del adaptador MC_IdentityManagementAdapter
class MobileContactMethodDetail : NSObject,Mappable{

    var ispreferedContactMethod : Bool?
    var contactMethodId: String?
    var mobileNumber : String?
    
    override init() {

    }

    required init?(map: Map) {

    }

	func mapping(map: Map)
	{
        ispreferedContactMethod <- map["IspreferedContactMethod"]
        mobileNumber <- map["MobileNumber"]
		//TEST
        contactMethodId <- map["ContactMethodId"]
	}

}

