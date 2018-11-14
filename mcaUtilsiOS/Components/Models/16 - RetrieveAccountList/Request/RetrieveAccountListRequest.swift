//
//	RetrieveAccountListRequest.swift
//	Model file Generated using: 
//	Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport 
//	(forked from Ahmed-Ali's JSONExport)
//

import Foundation
import ObjectMapper

/// Clase que representa el Request utilizado para consumir el servicio RetrieveAccountList. Regresa la lista de cuentas asociadas a un ID de perfil
/// Forma parte del adaptador MC_AccountManagementAdapter
class RetrieveAccountListRequest : NSObject,Mappable{

	var retrieveAccountList : RetrieveAccountList?

    override init() {
        retrieveAccountList = RetrieveAccountList();
    }

    required init?(map: Map) {
        
    }

	func mapping(map: Map)
	{
		retrieveAccountList <- map["RetrieveAccountList"]
		
	}


}
