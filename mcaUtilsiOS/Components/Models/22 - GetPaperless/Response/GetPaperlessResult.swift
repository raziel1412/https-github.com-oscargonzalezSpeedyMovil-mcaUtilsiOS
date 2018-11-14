//
//	GetPaperlessResult.swift
//	Model file Generated using: 
//	Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport 
//	(forked from Ahmed-Ali's JSONExport)
//

import Foundation
import ObjectMapper

/// Clase que representa el Response utilizado para consumir el servicio GetPaperless. Despliega si la opción de paperless ha sido seleccionada o no
/// Forma parte del adaptador MC_BillingManagementAdapter
class GetPaperlessResult : BaseResult {

	var getPaperlessResponse : GetPaperlessResponse?
    var getPaperlessFault : BaseFault?

    override init() {
        super.init();
    }

    required init?(map: Map) {
        super.init();
    }

    override func mapping(map: Map)
    {
        super.mapping(map: map);
		getPaperlessResponse <- map["GetPaperlessResponse"]
        getPaperlessFault <- map["GetPaperlessFault"]		
	}

}
