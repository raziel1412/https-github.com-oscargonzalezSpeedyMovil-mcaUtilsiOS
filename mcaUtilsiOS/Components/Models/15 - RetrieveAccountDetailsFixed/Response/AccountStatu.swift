//
//	AccountStatu.swift
//	Model file Generated using: 
//	Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport 
//	(forked from Ahmed-Ali's JSONExport)
//

import Foundation
import ObjectMapper

/// Clase que representa los datos del Response utilizado para consumir el servicio RetrieveAccountDetails. Obtiene el detalle de una cuenta, basado en la respuesta de RetrieveAccountList
/// Forma parte del adaptador MC_AccountManagementAdapter
class AccountStatu : NSObject,Mappable{
    var status : String?
    var statusChangeEffectivePeriod : StatusChangeEffectivePeriod?
    var statusChangeReason : StatusChangeReason?
    var statusChangeRequestedDate : String?

    override init() {

    }

    required init?(map: Map) {

    }

	func mapping(map: Map)
	{
        status <- map["status"]
        statusChangeEffectivePeriod <- map["statusChangeEffectivePeriod"]
        statusChangeReason <- map["statusChangeReason"]
        statusChangeRequestedDate <- (map["statusChangeRequestedDate"], JSONStringToIntTransform());
	}


}
