//
//	NotificationDetail.swift
//	Model file Generated using: 
//	Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport 
//	(forked from Ahmed-Ali's JSONExport)
//

import Foundation
import ObjectMapper

/// Clase que representa los datos del Request utilizado para consumir el servicio SendNotification. Evalúa Operación que envía una notificación (correo electrónico | SMS) al usuario final
/// Forma parte del adaptador MC_CustomerManagementAdapter
class NotificationDetail : NSObject,Mappable{

    var key : String?
    var value : String?
    
    override init() {

    }

    required init?(map: Map) {

    }

	func mapping(map: Map)
	{
		key <- map["key"]
		value <- map["value"]
		
	}

}
