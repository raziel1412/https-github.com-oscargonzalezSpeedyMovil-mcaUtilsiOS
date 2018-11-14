//
//	RetrieveBillDetailsResponse.swift
//	Model file Generated using: 
//	Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport 
//	(forked from Ahmed-Ali's JSONExport)
//

import Foundation
import ObjectMapper

/// Clase que representa los datos del Response utilizado para consumir el servicio RetrieveBillDetails. Esta operación regresa los detalles de las facturas
/// Forma parte del adaptador MC_BillingManagementAdapter
class RetrieveBillDetailsResponse : BaseResponse{

    var billItem : [BillItem]?
    var billingPeriod : AnyObject?
    var contractNumber : AnyObject?
    var devolutionBase : AnyObject?
    var dueDate : String?
    var prepaidStatusInfo : PrepaidStatusInfo?
    var statementDate : AnyObject?

    override init() {
        super.init()
    }

    required init?(map: Map) {
        super.init(map: map);
    }

    override func mapping(map: Map)
    {
        super.mapping(map: map);
        acknowledgementCode <- map["AcknowledgementCode"]
        acknowledgementDescription <- map["AcknowledgementDescription"]
        acknowledgementIndicator <- map["AcknowledgementIndicator"]
        billItem <- map["BillItem"]
        billingPeriod <- map["BillingPeriod"]
        contractNumber <- map["ContractNumber"]
        devolutionBase <- map["DevolutionBase"]
        dueDate <- map["DueDate"]
        prepaidStatusInfo <- map["PrepaidStatusInfo"]
        statementDate <- map["StatementDate"]
	}

}
