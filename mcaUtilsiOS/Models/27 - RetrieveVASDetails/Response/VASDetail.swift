//
//	VASDetail.swift
//	Model file Generated using: 
//	Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport 
//	(forked from Ahmed-Ali's JSONExport)
//

import Foundation
import ObjectMapper

/// Clase que representa los datos del Response utilizado para consumir el servicio RetrieveVASDetails. Regresa el listado a detalle de los servicios de valor agregado
/// Forma parte del adaptador MC_ServiceManagementAdapter
class VASDetail : NSObject,Mappable{

    var category : String?
    var descriptionField : [String]?
    var isDisabled : Bool?
    var status : Bool?
    var subscriptionPeriod : SubscriptionPeriod?
    var title : String?
    var type : String?
    var vASAction : String?
    var vASId : String?
    
    override init() {

    }

    required init?(map: Map) {
        
    }

	func mapping(map: Map)
	{
		category <- map["Category"]
		descriptionField <- map["Description"]
		isDisabled <- map["IsDisabled"]
		status <- map["Status"]
		subscriptionPeriod <- map["SubscriptionPeriod"]
		title <- map["Title"]
		type <- map["Type"]
		vASAction <- map["VASAction"]
		vASId <- map["VASId"]
		
	}

}
