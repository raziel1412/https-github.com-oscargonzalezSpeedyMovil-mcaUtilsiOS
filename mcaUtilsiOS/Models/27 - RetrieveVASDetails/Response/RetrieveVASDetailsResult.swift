//
//	RetrieveVASDetailsResult.swift
//	Model file Generated using: 
//	Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport 
//	(forked from Ahmed-Ali's JSONExport)
//

import Foundation
import ObjectMapper

/// Clase que representa el Response utilizado para consumir el servicio RetrieveVASDetails. Regresa el listado a detalle de los servicios de valor agregado
/// Forma parte del adaptador MC_ServiceManagementAdapter
class RetrieveVASDetailsResult : BaseResult {

	var retrieveVASDetailsResponse : RetrieveVASDetailsResponse?
    var retrieveVASDetailsFault : BaseFault?

    override init() {
        super.init();
    }

    required init?(map: Map) {
        super.init();
    }

    override func mapping(map: Map)
    {
        super.mapping(map: map);
		retrieveVASDetailsResponse <- map["RetrieveVASDetailsResponse"]
        retrieveVASDetailsFault <- map["RetrieveVASDetailsFault"]
	}

}
