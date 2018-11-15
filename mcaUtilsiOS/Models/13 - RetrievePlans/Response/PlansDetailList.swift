//
//	PlansDetailList.swift
//	Model file Generated using: 
//	Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport 
//	(forked from Ahmed-Ali's JSONExport)
//

import Foundation
import ObjectMapper

/// Clase que representa los datos del Response utilizado para consumir el servicio RetrievePlans. Esta operación podría regresar los planes sugeridos disponibles para la cuenta, basados en las características del plan actual
/// Forma parte del adaptador MC_BusinessAnalyticsManagementAdapter
class PlansDetailList : NSObject,Mappable{

    var planAmount : Int?
    var planBannerURL : String?
    var planCategories : [AnyObject]?
    var planCurrency : AnyObject?
    var planDescription : AnyObject?
    var planHomeAddress : AnyObject?
    var planID : String?
    var planLines : [AnyObject]?
    var planName : String?
    var planTargetURL : AnyObject?
    var planType : AnyObject?
    var serviceIdAssociated : AnyObject?
    
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
