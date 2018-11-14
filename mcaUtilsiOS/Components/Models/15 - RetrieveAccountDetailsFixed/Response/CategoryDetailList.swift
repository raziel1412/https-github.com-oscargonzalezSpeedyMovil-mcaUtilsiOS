//
//  CategoryDetailList.swift
//  MiClaro
//
//  Created by Roberto Gutierrez Resendiz on 29/01/18.
//  Copyright © 2018 am. All rights reserved.
//

import UIKit
import ObjectMapper

/// Clase que representa los datos del Response utilizado para consumir el servicio RetrieveAccountDetails. Obtiene el detalle de una cuenta, basado en la respuesta de RetrieveAccountList
/// Forma parte del adaptador MC_AccountManagementAdapter
class CategoryDetailList: NSObject, Mappable {

    var cost : Int?
    var descriptionField : String?
    var unit : String?

    override init() {

    }

    required init?(map: Map) {

    }

    func mapping(map: Map)
    {
        cost <- map["Cost"]
        descriptionField <- map["Description"]
        unit <- map["Unit"]
    }
}
