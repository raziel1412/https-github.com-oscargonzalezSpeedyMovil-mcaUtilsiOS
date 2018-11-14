//
//	RechargeValue.swift
//	Model file Generated using: 
//	Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport 
//	(forked from Ahmed-Ali's JSONExport)
//

import Foundation
import ObjectMapper

/// Clase que representa los datos del Response utilizado para consumir el servicio RetrieveRechargeOptions. Para definir valores posibles de cada característica (voz | datos | texto) [BAM.RetrievePromotions  | BAM.RetrievePlans]
/// Forma parte del adaptador MC_ServiceManagementAdapter
class RechargeValue : NSObject,Mappable{

    var optionAmount : Int?
    var optionCost : Int?
    
    override init() {

    }

    required init?(map: Map) {
        
    }

	func mapping(map: Map)
	{
		optionAmount <- map["OptionAmount"]
		optionCost <- map["OptionCost"]
		
	}

}
