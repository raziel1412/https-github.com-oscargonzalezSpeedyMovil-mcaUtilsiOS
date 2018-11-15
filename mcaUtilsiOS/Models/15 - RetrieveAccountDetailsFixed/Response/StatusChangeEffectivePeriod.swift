//
//  StatusChangeEffectivePeriod.swift
//  MiClaro
//
//  Created by Roberto Gutierrez Resendiz on 29/01/18.
//  Copyright © 2018 am. All rights reserved.
//

import UIKit
import ObjectMapper

/// Clase que representa los datos del Response utilizado para consumir el servicio RetrieveAccountDetails. Obtiene el detalle de una cuenta, basado en la respuesta de RetrieveAccountList
/// Forma parte del adaptador MC_AccountManagementAdapter
class StatusChangeEffectivePeriod: NSObject, Mappable {
    var endDate : Int?
    var startDate : Int?

    override init() {

    }

    required init?(map: Map) {

    }

    func mapping(map: Map)
    {
        endDate <- (map["endDate"], JSONIntToStringTransform())
        startDate <- (map["startDate"], JSONIntToStringTransform())
    }
}
