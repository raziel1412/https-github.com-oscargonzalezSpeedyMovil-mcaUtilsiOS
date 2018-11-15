//
//	SetPaperlessResult.swift
//	Model file Generated using: 
//	Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport 
//	(forked from Ahmed-Ali's JSONExport)
//

import Foundation
import ObjectMapper

/// Clase que representa el Response utilizado para consumir el servicio SetPaperless. Aplica la selección del usuario en correspondencia a la opción de paperless
/// Forma parte del adaptador MC_BillingManagementAdapter
class SetPaperlessResult : BaseResult {

	var setPaperlessResponse : SetPaperlessResponse?
    var setPaperlessFault : BaseFault?

    override init() {
        super.init();
    }

    required init?(map: Map) {
        super.init();
    }

    override func mapping(map: Map)
    {
        super.mapping(map: map);
		setPaperlessResponse <- map["SetPaperlessResponse"]
        setPaperlessFault <- map["SetPaperlessFault"]
	}

}
