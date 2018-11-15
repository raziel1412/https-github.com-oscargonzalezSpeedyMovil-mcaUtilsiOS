//
//	RetrievePersonalVerificationQuestionsResponse.swift
//	Model file Generated using: 
//	Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport 
//	(forked from Ahmed-Ali's JSONExport)
//

import Foundation
import ObjectMapper

/// Clase que representa los datos del Resposne utilizado para consumir el servicio RetrievePersonalVerificationQuestions. Regresa los campos necesarios para registrar una cuenta de usuario
/// Forma parte del adaptador MC_CustomerManagementAdapter
class RetrievePersonalVerificationQuestionsResponse : BaseResponse{

    var imageURL : String?
    var securityQuestions : [SecurityQuestionResponse]?

    override init() {
        super.init()
    }

    required init?(map: Map) {
        super.init(map: map);
    }

    override func mapping(map: Map)
    {
        super.mapping(map: map);
        securityQuestions <- map["SecurityQuestions"]
		imageURL <- map["ImageURL"]

	}

}
