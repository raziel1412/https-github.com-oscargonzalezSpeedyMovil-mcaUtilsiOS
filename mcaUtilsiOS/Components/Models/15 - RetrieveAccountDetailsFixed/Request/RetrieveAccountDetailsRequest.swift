//
//	RetrieveAccountDetailsRequest.swift
//	Model file Generated using: 
//	Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport 
//	(forked from Ahmed-Ali's JSONExport)
//

import Foundation
import ObjectMapper

/// Clase que representa el Request utilizado para consumir el servicio RetrieveAccountDetails. Obtiene el detalle de una cuenta, basado en la respuesta de RetrieveAccountList
/// Forma parte del adaptador MC_AccountManagementAdapter
class RetrieveAccountDetailsRequest : NSObject,Mappable{

    var retrieveAccountDetails : RetrieveAccountDetail?

    override init() {
        retrieveAccountDetails = RetrieveAccountDetail();
    }

    required init?(map: Map) {
        
    }

	func mapping(map: Map)
	{
        retrieveAccountDetails <- map["RetrieveAccountDetails"]
	}


}
