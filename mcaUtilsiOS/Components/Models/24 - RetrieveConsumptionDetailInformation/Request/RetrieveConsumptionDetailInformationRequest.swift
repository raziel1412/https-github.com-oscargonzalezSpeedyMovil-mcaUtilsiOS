//
//	RetrieveConsumptionDetailInformationRequest.swift
//	Model file Generated using: 
//	Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport 
//	(forked from Ahmed-Ali's JSONExport)
//

import Foundation
import ObjectMapper

/// Clase que representa el Request utilizado para consumir el servicio RetrieveConsumptionDetailInformation. Regresa el detalle de uso de los servicios de una cuenta para un periodo en especifico
/// Forma parte del adaptador MC_ServiceManagementAdapter
class RetrieveConsumptionDetailInformationRequest : NSObject, Mappable {

	var retrieveConsumptionDetailInformation : RetrieveConsumptionDetailInformation?

    override init() {
        retrieveConsumptionDetailInformation = RetrieveConsumptionDetailInformation()
    }

    required init?(map: Map) {
        
    }

    func mapping(map: Map)
	{
		retrieveConsumptionDetailInformation <- map["RetrieveConsumptionDetailInformation"]
	}

}
