//
//	RetrieveConsumptionDetailInformationResult.swift
//	Model file Generated using: 
//	Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport 
//	(forked from Ahmed-Ali's JSONExport)
//

import Foundation
import ObjectMapper

/// Clase que representa el Response utilizado para consumir el servicio RetrieveConsumptionDetailInformation. Regresa el detalle de uso de los servicios de una cuenta para un periodo en especifico
/// Forma parte del adaptador MC_ServiceManagementAdapter
class RetrieveConsumptionDetailInformationResult : BaseResult {

	var retrieveConsumptionDetailInformationResponse : RetrieveConsumptionDetailInformationResponse?
    var retrieveConsumptionDetailInformationFault : BaseFault?

    override init() {
        super.init();
    }

    required init?(map: Map) {
        super.init();
    }

    override func mapping(map: Map)
    {
        super.mapping(map: map);
		retrieveConsumptionDetailInformationResponse <- map["RetrieveConsumptionDetailInformationResponse"]
        retrieveConsumptionDetailInformationFault <- map["RetrieveConsumptionDetailInformationFault"]
	}

}
