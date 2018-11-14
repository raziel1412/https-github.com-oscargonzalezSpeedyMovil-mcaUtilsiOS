//
//	SendNotificationResponse.swift
//	Model file Generated using: 
//	Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport 
//	(forked from Ahmed-Ali's JSONExport)
//

import Foundation
import ObjectMapper

/// Clase que representa los datos del Response utilizado para consumir el servicio SendNotification. Evalúa Operación que envía una notificación (correo electrónico | SMS) al usuario final
/// Forma parte del adaptador MC_CustomerManagementAdapter
class SendNotificationResponse : BaseResponse{

    override init() {
        super.init()
    }

    required init?(map: Map) {
        super.init(map: map);
    }

    override func mapping(map: Map)
    {
        super.mapping(map: map);
		
	}

}
