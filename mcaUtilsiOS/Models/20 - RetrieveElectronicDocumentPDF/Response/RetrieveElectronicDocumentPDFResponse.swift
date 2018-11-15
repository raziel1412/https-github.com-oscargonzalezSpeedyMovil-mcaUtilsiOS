//
//	RetrieveElectronicDocumentPDFResponse.swift
//	Model file Generated using: 
//	Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport 
//	(forked from Ahmed-Ali's JSONExport)
//

import Foundation
import ObjectMapper

/// Clase que representa los datos del Response utilizado para consumir el servicio RetrieveElectronicDocumentPDF. Esta operación recuperará la factura o pago  para descarga en formato PDF
/// Forma parte del adaptador MC_BillingManagementAdapter
class RetrieveElectronicDocumentPDFResponse : BaseResponse{

    var pDFStream : String?
    var pdfDocument : String?

    override init() {
        super.init()
    }

    required init?(map: Map) {
        super.init(map: map);
    }

    override func mapping(map: Map)
    {
        super.mapping(map: map);
		pDFStream <- map["PDFStream"]
		pdfDocument <- map["PdfDocument"]
		
	}

}
