//
//	GetPaperles.swift
//	Model file Generated using: 
//	Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport 
//	(forked from Ahmed-Ali's JSONExport)
//

import Foundation
import ObjectMapper

/// Clase que representa los datos del Request utilizado para consumir el servicio GetPaperless. Despliega si la opción de paperless ha sido seleccionada o no
/// Forma parte del adaptador MC_BillingManagementAdapter
class GetPaperles : BaseRequest{

    var accountId : String?
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
		accountId <- map["AccountId"]
		lineOfBusiness <- map["LineOfBusiness"]
		
	}

}
