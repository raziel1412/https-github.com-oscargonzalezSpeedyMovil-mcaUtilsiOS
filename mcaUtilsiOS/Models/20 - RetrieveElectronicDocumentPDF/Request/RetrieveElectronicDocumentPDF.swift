//
//	RetrieveElectronicDocumentPDF.swift
//	Model file Generated using: 
//	Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport 
//	(forked from Ahmed-Ali's JSONExport)
//

import Foundation
import ObjectMapper

/// Clase que representa los datos del Request utilizado para consumir el servicio RetrieveElectronicDocumentPDF. Esta operación recuperará la factura o pago  para descarga en formato PDF
/// Forma parte del adaptador MC_BillingManagementAdapter
class RetrieveElectronicDocumentPDF : BaseRequest{

    var accountId : String?
    var billReference : String?
    var documentPeriod : DocumentPeriod?
    var lineOfBusiness : String?
    var pDFDocumentType : String?
    var pDFType : String?

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
		billReference <- map["BillReference"]
		documentPeriod <- map["DocumentPeriod"]
		lineOfBusiness <- map["LineOfBusiness"]
		pDFDocumentType <- map["PDFDocumentType"]
		pDFType <- map["PDFType"]
	}

}
