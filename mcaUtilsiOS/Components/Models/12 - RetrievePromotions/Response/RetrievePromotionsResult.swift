//
//	RetrievePromotionsResult.swift
//	Model file Generated using: 
//	Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport 
//	(forked from Ahmed-Ali's JSONExport)
//

import Foundation
import ObjectMapper

/// Clase que representa el Response utilizado para consumir el servicio RetrievePromotions. Esta operación permite obtener promociones que aplicables  a la cuenta de usuario,  promociones genéricas,  planes recomendados y servicios de valor agregado (Claro Ideas)
/// Forma parte del adaptador MC_BusinessAnalyticsManagementAdapter
class RetrievePromotionsResult : BaseResult {

	var retrievePromotionsResponse : RetrievePromotionsResponse?
    var retrievePromotionsFault : BaseFault?

    override init() {
        super.init();
    }

    required init?(map: Map) {
        super.init();
    }

    override func mapping(map: Map)
    {
        super.mapping(map: map);
		retrievePromotionsResponse <- map["RetrievePromotionsResponse"]
		retrievePromotionsFault <- map["RetrievePromotionsFault"]
	}

}
