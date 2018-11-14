//
//	RetrieveConsumptionDetailInformationResponse.swift
//	Model file Generated using: 
//	Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport 
//	(forked from Ahmed-Ali's JSONExport)
//

import Foundation
import ObjectMapper

/// Clase que representa los datos del Response utilizado para consumir el servicio RetrieveConsumptionDetailInformation. Regresa el detalle de uso de los servicios de una cuenta para un periodo en especifico
/// Forma parte del adaptador MC_ServiceManagementAdapter
class RetrieveConsumptionDetailInformationResponse : BaseResponse{

    var serviceUsage : [ServiceUsage]?
    var serviceBusinessType : String?

    override init() {
        super.init()
    }

    required init?(map: Map) {
        super.init(map: map);
    }

    override func mapping(map: Map)
    {
        super.mapping(map: map);
		serviceUsage <- map["ServiceUsage"]
        serviceBusinessType <- map["ServiceBusinessType"]		
	}

}
