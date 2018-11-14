//
//	RetrieveElectronicDocumentPDFRequest.swift
//	Model file Generated using: 
//	Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport 
//	(forked from Ahmed-Ali's JSONExport)
//

import Foundation
import ObjectMapper

/// Clase que representa el Request utilizado para consumir el servicio RetrieveElectronicDocumentPDF. Esta operación recuperará la factura o pago  para descarga en formato PDF
/// Forma parte del adaptador MC_BillingManagementAdapter
class RetrieveElectronicDocumentPDFRequest : NSObject,Mappable{

	var retrieveElectronicDocumentPDF : RetrieveElectronicDocumentPDF?

    override init() {
        retrieveElectronicDocumentPDF = RetrieveElectronicDocumentPDF()
    }

    required init?(map: Map) {
        
    }

	func mapping(map: Map)
	{
		retrieveElectronicDocumentPDF <- map["RetrieveElectronicDocumentPDF"]
		
	}

}
