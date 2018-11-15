//
//  StatusChangeEvent.swift
//  MiClaro
//
//  Created by Roberto Gutierrez Resendiz on 29/01/18.
//  Copyright © 2018 am. All rights reserved.
//

import UIKit
import ObjectMapper

/// Clase que representa los datos del Response utilizado para consumir el servicio RetrieveAccountDetails. Obtiene el detalle de una cuenta, basado en la respuesta de RetrieveAccountList
/// Forma parte del adaptador MC_AccountManagementAdapter
class StatusChangeEvent: NSObject, Mappable {

    var eventDateTime : String?
    var eventDescription : String?
    var eventLocation : Int?
    var eventType : String?

    override init() {

    }

    required init?(map: Map) {

    }

    func mapping(map: Map)
    {
        eventDateTime <- map["eventDateTime"]
        eventDescription <- map["eventDescription"]
        eventLocation <- map["eventLocation"]
        eventType <- map["eventType"]
    }
}
