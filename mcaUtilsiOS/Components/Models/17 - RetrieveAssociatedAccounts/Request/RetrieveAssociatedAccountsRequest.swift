//
//	RetrieveAssociatedAccountsRequest.swift
//	Model file Generated using: 
//	Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport 
//	(forked from Ahmed-Ali's JSONExport)
//

import Foundation
import ObjectMapper

/// Clase que representa el Request utilizado para consumir el servicio RetrieveAssociatedAccounts. Regresa la lista de cuentas asociadas a un perfil de usuario y para un tipo de cuenta en particular
/// Forma parte del adaptador MC_AccountManagementAdapter
class RetrieveAssociatedAccountsRequest : NSObject,Mappable{

	var retrieveAssociatedAccounts : RetrieveAssociatedAccount?

    override init() {
        retrieveAssociatedAccounts = RetrieveAssociatedAccount();

    }

    required init?(map: Map) {
        
    }

	func mapping(map: Map)
	{
		retrieveAssociatedAccounts <- map["RetrieveAssociatedAccounts"]
		
	}

}
