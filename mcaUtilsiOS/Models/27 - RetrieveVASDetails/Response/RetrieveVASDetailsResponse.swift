//
//	RetrieveVASDetailsResponse.swift
//	Model file Generated using: 
//	Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport 
//	(forked from Ahmed-Ali's JSONExport)
//

import Foundation
import ObjectMapper

/// Clase que representa los datos del Response utilizado para consumir el servicio RetrieveVASDetails. Regresa el listado a detalle de los servicios de valor agregado
/// Forma parte del adaptador MC_ServiceManagementAdapter
class RetrieveVASDetailsResponse : BaseResponse {

    var vASDetails : [VASDetail]?

    override init() {
        super.init()
    }

    required init?(map: Map) {
        super.init(map: map);
    }

    override func mapping(map: Map)
    {
        super.mapping(map: map);
		vASDetails <- map["VASDetails"]
		
	}

}
