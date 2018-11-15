//
//	RetrieveBillHistoryListRequest.swift
//	Model file Generated using: 
//	Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport 
//	(forked from Ahmed-Ali's JSONExport)
//

import Foundation
import ObjectMapper

/// Clase que representa el Request utilizado para consumir el servicio RetrieveBillHistoryList. Esta operación recuperará una lista de facturas históricas
/// Forma parte del adaptador MC_BillingManagementAdapter
class RetrieveBillHistoryListRequest : NSObject,Mappable{

	var retrieveBillHistoryList : RetrieveBillHistoryList?

    override init() {
        retrieveBillHistoryList = RetrieveBillHistoryList();
    }

    required init?(map: Map) {
        
    }

	func mapping(map: Map)
	{
		retrieveBillHistoryList <- map["RetrieveBillHistoryList"]
		
	}

}
