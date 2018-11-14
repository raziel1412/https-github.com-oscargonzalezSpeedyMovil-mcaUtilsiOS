//
//	IdentityLogin.swift
//	Model file Generated using: 
//	Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport 
//	(forked from Ahmed-Ali's JSONExport)
//

import Foundation
import ObjectMapper

/// Clase que representa los datos del Request utilizado para consumir el servicio IdentityLogin. Validación de usuario y contraseña
/// Forma parte del adaptador MC_IdentityLoginAdapter
class IdentityLogin : BaseRequest{

    var authorization : String?
    var lineOfBusiness : String?
    var oauthClientProfileDesa : String?
    var password : String?

    override init() {
        super.init()
    }

    required init?(map: Map) {
        super.init(map: map);
    }

    override func mapping(map: Map)
    {
        super.mapping(map: map);
        authorization <- map["Authorization"]
        lineOfBusiness <- map["LineOfBusiness"]
        oauthClientProfileDesa <- map["oauth_client_profile_desa"]
        password <- map["password"]
		
	}

}
