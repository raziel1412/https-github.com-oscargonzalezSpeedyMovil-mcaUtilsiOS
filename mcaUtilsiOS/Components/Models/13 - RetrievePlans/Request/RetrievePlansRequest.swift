//
//	RetrievePlansRequest.swift
//	Model file Generated using: 
//	Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport 
//	(forked from Ahmed-Ali's JSONExport)
//

import Foundation
import ObjectMapper

/// Clase que representa el Request utilizado para consumir el servicio RetrievePlans. Esta operación podría regresar los planes sugeridos disponibles para la cuenta, basados en las características del plan actual
/// Forma parte del adaptador MC_BusinessAnalyticsManagementAdapter
class RetrievePlansRequest : NSObject, Mappable{

    var retrievePlans : RetrievePlans?

    override init() {
        retrievePlans = RetrievePlans();
    }

    required init?(map: Map) {
    }

    func mapping(map: Map)
    {
        retrievePlans <- map["RetrievePlans"]
    }
}
