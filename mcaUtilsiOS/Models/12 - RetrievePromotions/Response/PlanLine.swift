//
//	PlanLine.swift
//	Model file Generated using: 
//	Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport 
//	(forked from Ahmed-Ali's JSONExport)
//

import Foundation
import ObjectMapper

/// Clase que representa los datos del Response utilizado para consumir el servicio RetrievePromotions. Esta operación permite obtener promociones que aplicables  a la cuenta de usuario,  promociones genéricas,  planes recomendados y servicios de valor agregado (Claro Ideas)
/// Forma parte del adaptador MC_BusinessAnalyticsManagementAdapter
class PlanLine : NSObject,Mappable{

    var cost : Int?
    var featureCategory : String?
    var featureID : String?
    var featureType : Int?
    var packages : [AnyObject]?
    var usageLimit : UsageLimit?
    var isFeatureActivable : Bool?
    var isFeatureActivated : Bool?

    override init() {

    }

    required init?(map: Map) {

    }

	func mapping(map: Map)
	{
        cost <- map["Cost"]
        featureCategory <- map["FeatureCategory"]
        featureID <- map["FeatureID"]
        featureType <- map["FeatureType"]
        packages <- map["Packages"]
        usageLimit <- map["UsageLimit"]
        isFeatureActivable <- map["isFeatureActivable"]
        isFeatureActivated <- map["isFeatureActivated"]
		
	}

}
