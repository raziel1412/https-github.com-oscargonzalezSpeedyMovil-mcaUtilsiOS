//
//	AssociateAccount.swift
//	Model file Generated using: 
//	Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport 
//	(forked from Ahmed-Ali's JSONExport)
//

import Foundation
import ObjectMapper

/// Clase que representa los datos del Request utilizado para consumir el servicio AssociateAccount
class AssociateAccount : BaseRequest{

    var accountAssociationStatus : String?
    var accountId : String?
    var associationRoleType : String?
    var lineOfBusiness : String?
    var notifyMeAboutChanges : Bool?

    override init() {
        super.init()
    }

    required init?(map: Map) {
        super.init(map: map);
    }

    override func mapping(map: Map)
    {
        super.mapping(map: map);
        accountAssociationStatus <- map["AccountAssociationStatus"]
        accountId <- map["AccountId"]
        associationRoleType <- map["AssociationRoleType"]
        lineOfBusiness <- map["LineOfBusiness"]
        notifyMeAboutChanges <- map["NotifyMeAboutChanges"]
	}

}
