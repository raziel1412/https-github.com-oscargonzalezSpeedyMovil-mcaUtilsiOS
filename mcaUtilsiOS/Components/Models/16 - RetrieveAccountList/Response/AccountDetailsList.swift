//
//	AccountDetailsList.swift
//	Model file Generated using: 
//	Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport 
//	(forked from Ahmed-Ali's JSONExport)
//

import Foundation
import ObjectMapper

/// Clase que representa los datos del Response utilizado para consumir el servicio RetrieveAccountList. Regresa la lista de cuentas asociadas a un ID de perfil
/// Forma parte del adaptador MC_AccountManagementAdapter
class AccountDetailsList : NSObject,Mappable{

    var accountId : String?
    var accountStatus : AccountStatu?
    var associatedServices : [AssociatedService]?
    var authAccUsers : [AuthAccUser]?
    var plan : Plan?
    
    override init() {

    }

    required init?(map: Map) {

    }

	func mapping(map: Map)
	{
		accountId <- map["AccountId"]
		accountStatus <- map["AccountStatus"]
		associatedServices <- map["AssociatedServices"]
		authAccUsers <- map["AuthAccUsers"]
		plan <- map["Plan"]
		
	}

}
