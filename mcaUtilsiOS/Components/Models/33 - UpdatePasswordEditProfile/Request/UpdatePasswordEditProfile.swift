//
//	UpdatePasswordEditProfile.swift
//	Model file Generated using: 
//	Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport 
//	(forked from Ahmed-Ali's JSONExport)
//

import Foundation
import ObjectMapper

/// Clase que representa los datos del Request utilizado para consumir el servicio UpdatePasswordEditProfile
class UpdatePasswordEditProfile : BaseRequest{

    var lineOfBusiness : String?
	//var newPassword : String?
	//var oldPassword : String?
    
    //TEST
    var password: String?

    override init() {
        super.init()
    }

    required init?(map: Map) {
        super.init(map: map);
    }

    override func mapping(map: Map)
    {
        super.mapping(map: map);
        lineOfBusiness <- map["LineOfBusiness"]
		//newPassword <- map["newPassword"]
		//oldPassword <- map["oldPassword"]
		password <- map["password"]
	}

}
