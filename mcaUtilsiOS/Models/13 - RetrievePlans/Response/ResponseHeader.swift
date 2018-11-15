//
//	ResponseHeader.swift
//	Model file Generated using: 
//	Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport 
//	(forked from Ahmed-Ali's JSONExport)
//

import Foundation
import ObjectMapper

/// Clase que representa los datos del Response utilizado para consumir el servicio RetrievePlans. Esta operación podría regresar los planes sugeridos disponibles para la cuenta, basados en las características del plan actual
/// Forma parte del adaptador MC_BusinessAnalyticsManagementAdapter
class ResponseHeader : NSObject,Mappable{

    var contentLength : String?
    var contentType : String?
    var date : String?
    var server : String?
    var xArchivedClientIP : String?
    var xBacksideTransport : String?
    var xClientIP : String?
    var xGlobalTransactionID : String?
    var xORACLEDMSECID : String?
    var xORACLEDMSRID : String?
    var xOriginalHTTPStatusCode : String?

    override init() {

    }

    required init?(map: Map) {
        
    }

	func mapping(map: Map)
	{
        contentLength <- map["Content-Length"]
        contentType <- map["Content-Type"]
        date <- map["Date"]
        server <- map["Server"]
        xArchivedClientIP <- map["X-Archived-Client-IP"]
        xBacksideTransport <- map["X-Backside-Transport"]
        xClientIP <- map["X-Client-IP"]
        xGlobalTransactionID <- map["X-Global-Transaction-ID"]
        xORACLEDMSECID <- map["X-ORACLE-DMS-ECID"]
        xORACLEDMSRID <- map["X-ORACLE-DMS-RID"]
        xOriginalHTTPStatusCode <- map["X-Original-HTTP-Status-Code"]
	}


}
