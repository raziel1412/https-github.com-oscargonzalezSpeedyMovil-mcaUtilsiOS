//
//	SendBillNotificationRequest.swift
//	Model file Generated using: 
//	Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport 
//	(forked from Ahmed-Ali's JSONExport)
//

import Foundation
import ObjectMapper

/// Clase que representa el Request utilizado para consumir el servicio SendBillNotification. Esta operación solicitará el envío de correo electrónico al usuario con su información de factura en archivos adjuntos
/// Forma parte del adaptador MC_BillingManagementAdapter
class SendBillNotificationRequest : NSObject,Mappable{

	var sendBillNotification : SendBillNotification?

    override init() {
        sendBillNotification = SendBillNotification()
    }

    required init?(map: Map) {
        
    }

	func mapping(map: Map)
	{
		sendBillNotification <- map["SendBillNotification"]
		
	}

}
