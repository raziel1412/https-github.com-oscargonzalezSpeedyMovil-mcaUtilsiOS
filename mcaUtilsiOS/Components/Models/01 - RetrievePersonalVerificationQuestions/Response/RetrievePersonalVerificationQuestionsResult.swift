//
//	RetrievePersonalVerificationQuestionsResult.swift
//	Model file Generated using: 
//	Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport 
//	(forked from Ahmed-Ali's JSONExport)
//

import Foundation
import ObjectMapper

/// Clase que representa el Response utilizado para consumir el servicio RetrievePersonalVerificationQuestions. Regresa los campos necesarios para registrar una cuenta de usuario
/// Forma parte del adaptador MC_CustomerManagementAdapter
class RetrievePersonalVerificationQuestionsResult : BaseResult{

	var retrievePersonalVerificationQuestionsResponse : RetrievePersonalVerificationQuestionsResponse?
    var retrievePersonalVerificationQuestionsFault : BaseFault?

    override init() {
        super.init();
    }

    required init?(map: Map) {
        super.init();
    }

    override func mapping(map: Map)
    {
        super.mapping(map: map);
		retrievePersonalVerificationQuestionsResponse <- map["RetrievePersonalVerificationQuestionsResponse"]
		retrievePersonalVerificationQuestionsFault <- map["RetrievePersonalVerificationQuestionsFault"]
	}

}
