//
//	ValidatePersonalVerificationQuestionsResult.swift
//	Model file Generated using: 
//	Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport 
//	(forked from Ahmed-Ali's JSONExport)
//

import Foundation
import ObjectMapper

/// Clase que representa el Response utilizado para consumir el servicio ValidatePersonalVerificationQuestion. Evalúa los valores de los campos regresados por el método RetrievePersonalVerificationQuestions
/// Forma parte del adaptador MC_CustomerManagementAdapter
class ValidatePersonalVerificationQuestionsResult : BaseResult{

	var validatePersonalVerificationQuestionsResponse : ValidatePersonalVerificationQuestionsResponse?
    var validatePersonalVerificationQuestionsFault : BaseFault?

    override init() {
        super.init();
    }

    required init?(map: Map) {
        super.init();
    }

    override func mapping(map: Map)
    {
        super.mapping(map: map);
		validatePersonalVerificationQuestionsResponse <- map["ValidatePersonalVerificationQuestionsResponse"]
		validatePersonalVerificationQuestionsFault <- map["ValidatePersonalVerificationQuestionsFault"]
	}

}
