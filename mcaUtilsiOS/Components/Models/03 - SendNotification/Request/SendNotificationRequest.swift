//
//	SendNotificationRequest.swift
//	Model file Generated using: 
//	Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport 
//	(forked from Ahmed-Ali's JSONExport)
//

import Foundation
import ObjectMapper

/// Clase que representa el Request utilizado para consumir el servicio SendNotification. Evalúa Operación que envía una notificación (correo electrónico | SMS) al usuario final
/// Forma parte del adaptador MC_CustomerManagementAdapter
class SendNotificationRequest : NSObject,Mappable{

	var sendNotification : SendNotification?

    override init() {
        sendNotification = SendNotification()
    }

    required init?(map: Map) {
        
    }

	func mapping(map: Map)
	{
		sendNotification <- map["SendNotification"]
		
	}

}
