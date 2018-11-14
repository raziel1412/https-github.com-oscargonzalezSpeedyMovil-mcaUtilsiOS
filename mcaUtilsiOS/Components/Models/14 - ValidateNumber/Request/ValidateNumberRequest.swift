//
//	ValidateNumberRequest.swift
//	Model file Generated using: 
//	Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport 
//	(forked from Ahmed-Ali's JSONExport)
//

import Foundation
import ObjectMapper

/// Clase que representa el Request utilizado para consumir el servicio ValidateNumber. Valida si el número móvil o el número de cuenta pertenece a Claro
/// Forma parte del adaptador MC_AccountManagementAdapter
class ValidateNumberRequest : NSObject,Mappable{

	var validateNumber : ValidateNumber?

    override init() {
        validateNumber = ValidateNumber()
    }

    required init?(map: Map) {
        
    }

	func mapping(map: Map)
	{
		validateNumber <- map["ValidateNumber"]
		
	}

}
