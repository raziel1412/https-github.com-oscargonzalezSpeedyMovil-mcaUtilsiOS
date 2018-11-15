//
//	AssociatedService.swift
//	Model file Generated using: 
//	Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport 
//	(forked from Ahmed-Ali's JSONExport)
//

import Foundation
import ObjectMapper

/// Clase que representa los datos del Response utilizado para consumir el servicio RetrieveAccountDetails. Obtiene el detalle de una cuenta, basado en la respuesta de RetrieveAccountList
/// Forma parte del adaptador MC_AccountManagementAdapter
class AssociatedService : NSObject,Mappable{

    var serviceDescription : String?
    var serviceID : String?
    var serviceType : String?
    var servicecost : Int?
    
    override init() {

    }

    required init?(map: Map) {

    }

	func mapping(map: Map)
	{
		serviceDescription <- map["ServiceDescription"]
		serviceID <- map["ServiceID"]
		serviceType <- map["ServiceType"]
		servicecost <- map["Servicecost"]
		
	}


}
