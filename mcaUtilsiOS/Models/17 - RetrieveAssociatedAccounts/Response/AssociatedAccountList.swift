//
//	AssociatedAccountList.swift
//	Model file Generated using: 
//	Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport 
//	(forked from Ahmed-Ali's JSONExport)
//

import Foundation
import ObjectMapper

/// Clase que representa los datos del Response utilizado para consumir el servicio RetrieveAssociatedAccounts. Regresa la lista de cuentas asociadas a un perfil de usuario y para un tipo de cuenta en particular
/// Forma parte del adaptador MC_AccountManagementAdapter
class AssociatedAccountList : NSObject,Mappable{

    var accountId : String?
    var associatedAccountStatus : Int?
    var associationRoleType : Int?
    var lineOfBusiness : String?
    var isRechargeAvailable : Bool?

    override init() {

    }

    required init?(map: Map) {

    }

	func mapping(map: Map)
	{
		accountId <- map["AccountId"]
		associatedAccountStatus <- map["AssociatedAccountStatus"]
		associationRoleType <- map["AssociationRoleType"]
        lineOfBusiness <- (map["LineOfBusiness"], JSONStringToIntTransform());
//		lineOfBusiness <- map["LineOfBusiness"]
		isRechargeAvailable <- map["isRechargeAvailable"]
		
	}

}
