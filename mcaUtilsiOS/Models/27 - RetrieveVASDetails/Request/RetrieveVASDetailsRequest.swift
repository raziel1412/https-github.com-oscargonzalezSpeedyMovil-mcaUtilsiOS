//
//	RetrieveVASDetailsRequest.swift
//	Model file Generated using: 
//	Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport 
//	(forked from Ahmed-Ali's JSONExport)
//

import Foundation
import ObjectMapper

/// Clase que representa el Request utilizado para consumir el servicio RetrieveVASDetails. Regresa el listado a detalle de los servicios de valor agregado
/// Forma parte del adaptador MC_ServiceManagementAdapter
class RetrieveVASDetailsRequest : NSObject,Mappable{

	var retrieveVASDetails : RetrieveVASDetail?

    override init() {
        retrieveVASDetails = RetrieveVASDetail();
    }

    required init?(map: Map) {
        
    }

	func mapping(map: Map)
	{
		retrieveVASDetails <- map["RetrieveVASDetails"]
		
	}

}
