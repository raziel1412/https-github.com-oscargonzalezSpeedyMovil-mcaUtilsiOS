//
//	ValidatePersonalVerificationQuestionRequest.swift
//	Model file Generated using: 
//	Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport 
//	(forked from Ahmed-Ali's JSONExport)
//

import Foundation
import ObjectMapper

/// Clase que representa el Request utilizado para consumir el servicio ValidatePersonalVerificationQuestion. Evalúa los valores de los campos regresados por el método RetrievePersonalVerificationQuestions
/// Forma parte del adaptador MC_CustomerManagementAdapter
class ValidatePersonalVerificationQuestionRequest : NSObject,Mappable{

	var validatePersonalVerificationQuestions : ValidatePersonalVerificationQuestion?

    override init() {
        validatePersonalVerificationQuestions = ValidatePersonalVerificationQuestion()
    }

    required init?(map: Map) {
        
    }

	func mapping(map: Map)
	{
		validatePersonalVerificationQuestions <- map["ValidatePersonalVerificationQuestions"]
		
	}


}
