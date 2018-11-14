//
//	AssociateAccountRequest.swift
//	Model file Generated using: 
//	Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport 
//	(forked from Ahmed-Ali's JSONExport)
//

import Foundation
import ObjectMapper

/// Clase que representa el Request utilizado para consumir el servicio AssociateAccount
class AssociateAccountRequest : NSObject, Mappable{

    var associateAccount : AssociateAccount?

    override init() {
        associateAccount = AssociateAccount();
    }

    required init?(map: Map) {

    }

    func mapping(map: Map)
    {
		associateAccount <- map["AssociateAccount"]
	}

}
