//
//	PersonalId.swift
//	Model file Generated using: 
//	Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport 
//	(forked from Ahmed-Ali's JSONExport)
//

import Foundation
import ObjectMapper

/// Clase que representa los datos del Request utilizado para consumir el servicio CreateNewRegister. Crea un nuevo registro de cuenta  en los sistemas de backend permitiendo la administración de los servicios
/// Forma parte del adaptador MC_IdentityManagementAdapter
class PersonalId : NSObject,Mappable{

    var identificationNumber : String?
    var identificationType : String?

    override init() {

    }

    required init?(map: Map) {

    }

	func mapping(map: Map)
	{
		identificationNumber <- map["IdentificationNumber"]
		identificationType <- map["IdentificationType"]
	}

}
