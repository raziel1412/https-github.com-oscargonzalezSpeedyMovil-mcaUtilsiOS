//
//	ValidatePersonalVerificationQuestion.swift
//	Model file Generated using: 
//	Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport 
//	(forked from Ahmed-Ali's JSONExport)
//

import Foundation
import ObjectMapper

/// Clase que representa los datos del Request utilizado para consumir el servicio ValidatePersonalVerificationQuestion. Evalúa los valores de los campos regresados por el método RetrievePersonalVerificationQuestions
/// Forma parte del adaptador MC_CustomerManagementAdapter
class ValidatePersonalVerificationQuestion : BaseRequest{

    var lineOfBusiness : String?
    var securityQuestions : [SecurityQuestionRequest]?

    override init() {
        super.init()
    }

    required init?(map: Map) {
        super.init(map: map);
    }

	override func mapping(map: Map)
	{
        super.mapping(map: map);
		lineOfBusiness <- map["LineOfBusiness"]
		securityQuestions <- map["SecurityQuestions"]

	}

}
