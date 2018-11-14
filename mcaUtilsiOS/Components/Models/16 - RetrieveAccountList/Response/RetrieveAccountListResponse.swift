//
//	RetrieveAccountListResponse.swift
//	Model file Generated using: 
//	Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport 
//	(forked from Ahmed-Ali's JSONExport)
//

import Foundation
import ObjectMapper

/// Clase que representa los datos del Response utilizado para consumir el servicio RetrieveAccountList. Regresa la lista de cuentas asociadas a un ID de perfil
/// Forma parte del adaptador MC_AccountManagementAdapter
class RetrieveAccountListResponse : BaseResponse{

    var accountDetailsList : [AccountDetailsList]?

    override init() {
        super.init()
    }

    required init?(map: Map) {
        super.init(map: map);
    }

    override func mapping(map: Map)
    {
        super.mapping(map: map);
		accountDetailsList <- map["AccountDetailsList"]
		
	}

}
