//
//	UsageLimit.swift
//	Model file Generated using: 
//	Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport 
//	(forked from Ahmed-Ali's JSONExport)
//

import Foundation
import ObjectMapper

/// Clase que representa los datos del Response utilizado para consumir el servicio RetrievePromotions. Esta operación permite obtener promociones que aplicables  a la cuenta de usuario,  promociones genéricas,  planes recomendados y servicios de valor agregado (Claro Ideas)
/// Forma parte del adaptador MC_BusinessAnalyticsManagementAdapter
class UsageLimit : NSObject,Mappable{

    var quantity : String?
    var unit : String?
    
    override init() {

    }

    required init?(map: Map) {
        
    }

	func mapping(map: Map)
	{
		quantity <- map["Quantity"]
		unit <- map["Unit"]
		
	}

}
