//
//	PaymentTypeOtherDetail.swift
//	Model file Generated using: 
//	Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport 
//	(forked from Ahmed-Ali's JSONExport)
//

import Foundation
import ObjectMapper

/// Clase que representa los datos del Response utilizado para consumir el servicio RetrieveBillHistoryList. Esta operación recuperará una lista de facturas históricas
/// Forma parte del adaptador MC_BillingManagementAdapter
class PaymentTypeOtherDetail : NSObject,Mappable{

    var bank : Int?
    var branch : Int?
    var otherHolderName : String?
    var otherNumber : String?
    var paymentMethodId : String?
    var isPreferedpaymentMethod : Bool?
    
    override init() {

    }

    required init?(map: Map) {

    }

	func mapping(map: Map)
	{
		bank <- map["Bank"]
		branch <- map["Branch"]
		otherHolderName <- map["OtherHolderName"]
		otherNumber <- map["OtherNumber"]
		paymentMethodId <- map["PaymentMethodId"]
		isPreferedpaymentMethod <- map["isPreferedpaymentMethod"]
		
	}

}
