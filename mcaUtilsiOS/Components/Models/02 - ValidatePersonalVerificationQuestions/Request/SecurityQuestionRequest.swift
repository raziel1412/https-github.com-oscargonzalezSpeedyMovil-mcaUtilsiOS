//
//	SecurityQuestionRequest.swift
//	Model file Generated using: 
//	Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport 
//	(forked from Ahmed-Ali's JSONExport)
//

import Foundation
import ObjectMapper

/// Clase que representa los datos del Request utilizado para consumir el servicio ValidatePersonalVerificationQuestion. Evalúa los valores de los campos regresados por el método RetrievePersonalVerificationQuestions
/// Forma parte del adaptador MC_CustomerManagementAdapter
class SecurityQuestionRequest : NSObject,Mappable{

    var answer : String?
    var idOption : [AnyObject]?
    var idQuestion : String?

    override init() {

    }

    required init?(map: Map) {
        
    }

	func mapping(map: Map)
	{
		answer <- map["Answer"]
		idOption <- map["IdOption"]
		idQuestion <- map["idQuestion"]
		
	}

}
