//
//	BillItem.swift
//	Model file Generated using: 
//	Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport 
//	(forked from Ahmed-Ali's JSONExport)
//

import Foundation
import ObjectMapper

/// Clase que representa los datos del Response utilizado para consumir el servicio RetrieveBillDetails. Esta operación regresa los detalles de las facturas
/// Forma parte del adaptador MC_BillingManagementAdapter
class BillItem : NSObject,Mappable{

    var amount : Int?
    var amountFormat : String?
    var descriptionType : String?
    var iACAmount : Int?
    var reference : String?
    var subTotalAmount : Int?
    var tax : Int?

    override init() {

    }

    required init?(map: Map) {

    }

	func mapping(map: Map)
	{
        amount <- map["Amount"]
        amountFormat <- map["AmountFormat"]
        descriptionType <- map["DescriptionType"]
        iACAmount <- map["IACAmount"]
        reference <- map["Reference"]
        subTotalAmount <- map["SubTotalAmount"]
        tax <- map["Tax"]
	}

}
