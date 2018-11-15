//
//	BillDetail.swift
//	Model file Generated using: 
//	Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport 
//	(forked from Ahmed-Ali's JSONExport)
//

import Foundation
import ObjectMapper

/// Clase que representa los datos del Response utilizado para consumir el servicio RetrieveBillHistoryList. Esta operación recuperará una lista de facturas históricas
/// Forma parte del adaptador MC_BillingManagementAdapter
class BillDetail : NSObject,Mappable{

    var billReference : String?
    var billingPeriod : BillingPeriod?
    var devicePrice : String?
    var devolutionBase : String?
    var dueDate : String?
    var payUntilDate : String?
    var planCharge : String?
    var subTotal : String?
    var tax : String?
    var totalAmount : String?
    var totalAmountFormat : String?

    override init() {

    }

    required init?(map: Map) {

    }

	func mapping(map: Map)
	{
        billReference <- map["BillReference"]
        billingPeriod <- map["BillingPeriod"]
        devicePrice <- map["DevicePrice"]
        devolutionBase <- map["DevolutionBase"]
        dueDate <- map["DueDate"]
        payUntilDate <- map["PayUntilDate"]
        planCharge <- map["PlanCharge"]
        subTotal <- map["SubTotal"]
        tax <- map["Tax"]
        totalAmount <- map["TotalAmount"]
        totalAmountFormat <- map["TotalAmountFormat"]
		
	}

}
