//
//	AssociateAccountResult.swift
//	Model file Generated using: 
//	Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport 
//	(forked from Ahmed-Ali's JSONExport)
//

import Foundation
import ObjectMapper

/// Clase que representa el Response utilizado para consumir el servicio AssociateAccount
class AssociateAccountResult : BaseResult {

    var associateAccountResponse : AssociateAccountResponse?
    var associateAccountFault : BaseFault?

    override init() {
        super.init();
    }

    required init?(map: Map) {
        super.init();
    }

    override func mapping(map: Map)
    {
        super.mapping(map: map);
		associateAccountResponse <- map["AssociateAccountResponse"]
        associateAccountFault <- map["AssociateAccountFault"]
	}

}
