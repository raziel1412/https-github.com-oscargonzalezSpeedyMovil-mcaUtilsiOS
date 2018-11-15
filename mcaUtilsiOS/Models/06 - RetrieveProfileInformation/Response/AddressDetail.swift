//
//	AddressDetail.swift
//	Model file Generated using: 
//	Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport 
//	(forked from Ahmed-Ali's JSONExport)
//

import Foundation
import ObjectMapper

/// Clase que representa los datos del Response utilizado para consumir el servicio RetrieveProfileInformation. Despliega la información del perfil de la cuenta de usuario
/// Forma parte del adaptador MC_IdentityManagementAdapter
class AddressDetail : NSObject,Mappable{

    var addressLine1 : String?
    var city : String?
    var country : String?
    var provinceorDepartment : String?
    var state : String?
    var telephoneHome : String?

    override init() {

    }

    required init?(map: Map) {

    }

	func mapping(map: Map)
	{
        addressLine1 <- map["AddressLine1"]
        city <- map["City"]
        country <- map["Country"]
        provinceorDepartment <- map["ProvinceorDepartment"]
        state <- map["State"]
        telephoneHome <- map["TelephoneHome"]
		
	}

}
