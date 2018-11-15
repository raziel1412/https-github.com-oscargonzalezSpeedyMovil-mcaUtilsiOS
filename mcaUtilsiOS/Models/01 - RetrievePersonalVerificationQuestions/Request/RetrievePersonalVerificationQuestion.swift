//
//	RetrievePersonalVerificationQuestion.swift
//	Model file Generated using: 
//	Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport 
//	(forked from Ahmed-Ali's JSONExport)
//

import Foundation
import ObjectMapper

/// Clase que representa los datos del Request utilizado para consumir el servicio RetrievePersonalVerificationQuestions. Regresa los campos necesarios para registrar una cuenta de usuario
/// Forma parte del adaptador MC_CustomerManagementAdapter
class RetrievePersonalVerificationQuestion : BaseRequest{

    var lineOfBusiness : String?

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
		
	}

}
