//
//	ValidateNumber.swift
//	Model file Generated using: 
//	Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport 
//	(forked from Ahmed-Ali's JSONExport)
//

import Foundation
import ObjectMapper

/// Clase que representa los datos del Request utilizado para consumir el servicio ValidateNumber. Valida si el número móvil o el número de cuenta pertenece a Claro
/// Forma parte del adaptador MC_AccountManagementAdapter
class ValidateNumber : BaseRequest{

    var lineOfBusiness : String?
    var claroNumber : String?

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
		claroNumber <- map["claroNumber"]
		
	}

}
