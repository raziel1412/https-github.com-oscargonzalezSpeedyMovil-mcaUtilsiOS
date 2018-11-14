//
//	PaymentMethod.swift
//	Model file Generated using: 
//	Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport 
//	(forked from Ahmed-Ali's JSONExport)
//

import Foundation
import ObjectMapper

/// Clase que representa los datos del Response utilizado para consumir el servicio RetrieveBillHistoryList. Esta operación recuperará una lista de facturas históricas
/// Forma parte del adaptador MC_BillingManagementAdapter
class PaymentMethod : NSObject,Mappable{

    var paymentTypeOtherDetail : PaymentTypeOtherDetail?

    override init() {

    }

    required init?(map: Map) {

    }

	func mapping(map: Map)
	{
		paymentTypeOtherDetail <- map["PaymentTypeOtherDetail"]
		
	}

}
