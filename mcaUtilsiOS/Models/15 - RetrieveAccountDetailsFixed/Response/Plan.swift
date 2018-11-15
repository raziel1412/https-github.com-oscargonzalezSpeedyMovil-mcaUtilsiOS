//
//	Plan.swift
//	Model file Generated using: 
//	Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport 
//	(forked from Ahmed-Ali's JSONExport)
//

import Foundation
import ObjectMapper

/// Clase que representa los datos del Response utilizado para consumir el servicio RetrieveAccountDetails. Obtiene el detalle de una cuenta, basado en la respuesta de RetrieveAccountList
/// Forma parte del adaptador MC_AccountManagementAdapter
class Plan : NSObject, Mappable{

    var planAmount : Int?
    var planBannerURL : String?
    var planCategories : [PlanCategory]?
    var planCurrency : String?
    var planDescription : AnyObject?
    var planHomeAddress : String?
    var planID : String?
    var planLines : [PlanLine]?
    var planName : String?
    var planTargetURL : String?
    var planType : String?
    var serviceIdAssociated : String?
    
    override init() {

    }

    required init?(map: Map) {

    }

	func mapping(map: Map)
	{
        planAmount <- map["PlanAmount"]
        planBannerURL <- map["PlanBannerURL"]
        planCategories <- map["PlanCategories"]
        planCurrency <- map["PlanCurrency"]
        planDescription <- map["PlanDescription"]
        planHomeAddress <- map["PlanHomeAddress"]
        planID <- map["PlanID"]
        planLines <- map["PlanLines"]
        planName <- map["PlanName"]
        planTargetURL <- map["PlanTargetURL"]
        planType <- map["PlanType"]
        serviceIdAssociated <- map["ServiceIdAssociated"]
	}
}
