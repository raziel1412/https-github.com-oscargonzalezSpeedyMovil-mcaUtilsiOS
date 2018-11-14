//
//	RetrieveElectronicDocumentPDFResult.swift
//	Model file Generated using: 
//	Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport 
//	(forked from Ahmed-Ali's JSONExport)
//

import Foundation
import ObjectMapper

/// Clase que representa el Response utilizado para consumir el servicio RetrieveElectronicDocumentPDF. Esta operación recuperará la factura o pago  para descarga en formato PDF
/// Forma parte del adaptador MC_BillingManagementAdapter
class RetrieveElectronicDocumentPDFResult : BaseResult {

	var retrieveElectronicDocumentPDFResponse : RetrieveElectronicDocumentPDFResponse?
    var retrieveElectronicDocumentPDFFault : BaseFault??

    override init() {
        super.init();
    }

    required init?(map: Map) {
        super.init();
    }

    override func mapping(map: Map)
    {
        super.mapping(map: map);
		retrieveElectronicDocumentPDFResponse <- map["RetrieveElectronicDocumentPDFResponse"]
        retrieveElectronicDocumentPDFFault <- map["RetrieveElectronicDocumentPDFFault"]
	}

}
