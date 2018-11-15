//
//	RetrieveBillDetailsRequest.swift
//	Model file Generated using: 
//	Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport 
//	(forked from Ahmed-Ali's JSONExport)
//

import Foundation
import ObjectMapper

/// Clase que representa el Request utilizado para consumir el servicio RetrieveBillDetails. Esta operación regresa los detalles de las facturas
/// Forma parte del adaptador MC_BillingManagementAdapter
class RetrieveBillDetailsRequest : NSObject,Mappable{

	var retrieveBillDetails : RetrieveBillDetail?

    override init() {
        retrieveBillDetails = RetrieveBillDetail();
    }

    required init?(map: Map) {
        
    }

	func mapping(map: Map)
	{
		retrieveBillDetails <- map["RetrieveBillDetails"]
		
	}

}
