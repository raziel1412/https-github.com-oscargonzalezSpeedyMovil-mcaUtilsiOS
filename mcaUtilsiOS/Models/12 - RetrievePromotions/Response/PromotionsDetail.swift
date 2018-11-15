//
//	PromotionsDetail.swift
//	Model file Generated using: 
//	Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport 
//	(forked from Ahmed-Ali's JSONExport)
//

import Foundation
import ObjectMapper

/// Clase que representa los datos del Response utilizado para consumir el servicio RetrievePromotions. Esta operación permite obtener promociones que aplicables  a la cuenta de usuario,  promociones genéricas,  planes recomendados y servicios de valor agregado (Claro Ideas)
/// Forma parte del adaptador MC_BusinessAnalyticsManagementAdapter
class PromotionsDetail : NSObject,Mappable{

    var accountId : String?
    var lineOfBusiness : Int?
    var planType : PlanType?
    var promotionDescription : String?
    var promotionDescriptions : PromotionDescription?
    var promotionId : String?
    var promotionName : String?
    var promotionRanking : Int?
    var promotionType : Int?
    
    override init() {

    }

    required init?(map: Map) {

    }

	func mapping(map: Map)
	{
		accountId <- map["AccountId"]
		lineOfBusiness <- map["LineOfBusiness"]
		planType <- map["PlanType"]
		promotionDescription <- map["PromotionDescription"]
		promotionDescriptions <- map["PromotionDescriptions"]
		promotionId <- map["PromotionId"]
		promotionName <- map["PromotionName"]
		promotionRanking <- map["PromotionRanking"]
		promotionType <- map["PromotionType"]
		
	}

}
