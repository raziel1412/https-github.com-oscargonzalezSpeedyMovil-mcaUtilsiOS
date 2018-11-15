//
//	RetrievePersonalVerificationQuestionRequest.swift
//	Model file Generated using: 
//	Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport 
//	(forked from Ahmed-Ali's JSONExport)
//

import Foundation
import ObjectMapper

/// Clase que representa el Request utilizado para consumir el servicio RetrievePersonalVerificationQuestions. Regresa los campos necesarios para registrar una cuenta de usuario
/// Forma parte del adaptador MC_CustomerManagementAdapter
class RetrievePersonalVerificationQuestionRequest : NSObject,Mappable{

	var retrievePersonalVerificationQuestions : RetrievePersonalVerificationQuestion?

    override init() {
        retrievePersonalVerificationQuestions = RetrievePersonalVerificationQuestion();
    }

    required init?(map: Map) {
        
    }

	func mapping(map: Map)
	{
		retrievePersonalVerificationQuestions <- map["RetrievePersonalVerificationQuestions"]
		
	}

}
