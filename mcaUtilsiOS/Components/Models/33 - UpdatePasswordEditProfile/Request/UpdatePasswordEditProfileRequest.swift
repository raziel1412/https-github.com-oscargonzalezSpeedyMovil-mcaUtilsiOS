//
//	UpdatePasswordEditProfileRequest.swift
//	Model file Generated using: 
//	Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport 
//	(forked from Ahmed-Ali's JSONExport)
//

import Foundation
import ObjectMapper

/// Clase que representa el Request utilizado para consumir el servicio UpdatePasswordEditProfile
class UpdatePasswordEditProfileRequest : NSObject, Mappable{

	var updatePasswordEditProfile : UpdatePasswordEditProfile?

    override init() {
        updatePasswordEditProfile = UpdatePasswordEditProfile();
    }

    required init?(map: Map) {

    }

    func mapping(map: Map)
    {
//        updatePasswordEditProfile <- map["UpdatePasswordEditProfile"]
		updatePasswordEditProfile <- map["UpdatePassword"]
	}

}
