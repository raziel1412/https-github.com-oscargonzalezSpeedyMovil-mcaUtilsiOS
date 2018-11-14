//
//	SendNotificationResult.swift
//	Model file Generated using: 
//	Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport 
//	(forked from Ahmed-Ali's JSONExport)
//

import Foundation
import ObjectMapper

/// Clase que representa el Response utilizado para consumir el servicio SendNotification. Evalúa Operación que envía una notificación (correo electrónico | SMS) al usuario final
/// Forma parte del adaptador MC_CustomerManagementAdapter
class SendNotificationResult : BaseResult {

	var sendNotificationResponse : SendNotificationResponse?
    var sendNotificationFault : BaseFault?

    override init() {
        super.init();
    }

    required init?(map: Map) {
        super.init();
    }

    override func mapping(map: Map)
    {
        super.mapping(map: map);
		sendNotificationResponse <- map["SendNotificationResponse"]
        sendNotificationFault <- map["SendNotificationFault"]
	}

}
