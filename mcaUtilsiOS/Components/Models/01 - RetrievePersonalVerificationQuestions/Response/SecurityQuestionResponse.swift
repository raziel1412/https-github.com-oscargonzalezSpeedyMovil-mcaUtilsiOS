//
//	SecurityQuestionResponse.swift
//	Model file Generated using: 
//	Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport 
//	(forked from Ahmed-Ali's JSONExport)
//

import Foundation
import ObjectMapper

/// Clase que representa los datos SecurityQuestionResponse utilizado para consumir el servicio RetrievePersonalVerificationQuestions. Regresa los campos necesarios para registrar una cuenta de usuario
/// Forma parte del adaptador MC_CustomerManagementAdapter
class SecurityQuestionResponse : Mappable{

    var contextualHelp : String?
    var descriptionField : String?
    var questionId : String?
    var questionType : String?

    init() {
    }

    required convenience init?(map: Map) {
        self.init()
    }

	func mapping(map: Map)
	{
        contextualHelp <- map["ContextualHelp"]
        descriptionField <- map["Description"]
        questionId <- map["QuestionId"]
        questionType <- map["QuestionType"]
		
	}

}
