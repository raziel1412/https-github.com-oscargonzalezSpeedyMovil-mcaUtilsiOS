//
//	RechargeList.swift
//	Model file Generated using: 
//	Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport 
//	(forked from Ahmed-Ali's JSONExport)
//

import Foundation
import ObjectMapper

/// Clase que representa los datos del Response utilizado para consumir el servicio RetrieveRechargeOptions. Para definir valores posibles de cada característica (voz | datos | texto) [BAM.RetrievePromotions  | BAM.RetrievePlans]
/// Forma parte del adaptador MC_ServiceManagementAdapter
class RechargeList : NSObject,Mappable{

    var optionDescription : String?
    var optionType : Int?
    var rechargeValues : [RechargeValue]?
    
    override init() {

    }

    required init?(map: Map) {
        
    }

	func mapping(map: Map)
	{
		optionDescription <- map["OptionDescription"]
		optionType <- map["OptionType"]
		rechargeValues <- map["RechargeValues"]
		
	}

}
