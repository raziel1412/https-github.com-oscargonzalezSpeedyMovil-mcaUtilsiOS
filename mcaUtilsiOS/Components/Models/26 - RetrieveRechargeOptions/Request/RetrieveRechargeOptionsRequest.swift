//
//	RetrieveRechargeOptionsRequest.swift
//	Model file Generated using: 
//	Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport 
//	(forked from Ahmed-Ali's JSONExport)
//

import Foundation
import ObjectMapper

/// Clase que representa el Request utilizado para consumir el servicio RetrieveRechargeOptions. Para definir valores posibles de cada característica (voz | datos | texto) [BAM.RetrievePromotions  | BAM.RetrievePlans]
/// Forma parte del adaptador MC_ServiceManagementAdapter
class RetrieveRechargeOptionsRequest : NSObject,Mappable{

	var retrieveRechargeOptions : RetrieveRechargeOption?

    override init() {
        retrieveRechargeOptions = RetrieveRechargeOption();
    }

    required init?(map: Map) {
        
    }

	func mapping(map: Map)
	{
		retrieveRechargeOptions <- map["RetrieveRechargeOptions"]
		
	}

}
