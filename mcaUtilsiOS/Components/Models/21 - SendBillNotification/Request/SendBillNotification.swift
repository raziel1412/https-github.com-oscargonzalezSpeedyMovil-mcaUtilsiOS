//
//	SendBillNotification.swift
//	Model file Generated using: 
//	Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport 
//	(forked from Ahmed-Ali's JSONExport)
//

import Foundation
import ObjectMapper

/// Clase que representa los datos del Request utilizado para consumir el servicio SendBillNotification. Esta operación solicitará el envío de correo electrónico al usuario con su información de factura en archivos adjuntos
/// Forma parte del adaptador MC_BillingManagementAdapter
class SendBillNotification : BaseRequest{

    var accountId : String?
    var billPeriod : BillPeriod?
    var billReference : String?
    var emailAddress : String?
    var lineOfBusiness : String?
    var pDFDocumentType : String?

    override init() {
        super.init()
    }

    required init?(map: Map) {
        super.init(map: map);
    }

    override func mapping(map: Map)
    {
        super.mapping(map: map);
		accountId <- map["AccountId"]
		billPeriod <- map["BillPeriod"]
		billReference <- map["BillReference"]
		emailAddress <- map["EmailAddress"]
		lineOfBusiness <- map["LineOfBusiness"]
		pDFDocumentType <- map["PDFDocumentType"]
		
	}

}
