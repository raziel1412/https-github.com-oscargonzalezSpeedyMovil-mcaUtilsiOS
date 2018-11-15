//
//	PersonalDetailsInformationSingle.swift
//	Model file Generated using: 
//	Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport 
//	(forked from Ahmed-Ali's JSONExport)
//

import Foundation
import ObjectMapper

/// Clase que representa los datos del Request utilizado para consumir el servicio UpdateProfileInformation. Actualiza la información de perfil de la cuenta de usuario
/// Forma parte del adaptador MC_IdentityManagementAdapter
class PersonalDetailsInformationSingle : NSObject,Mappable{

    var accountUserFirstName : String?
    var accountUserGender : String?
    var accountUserLastName : String?
    var accountUserSecondLastName : String?
    var city : String?
    var dateOfBirth : String?
    var personalId : [PersonalId]?
    var rUT : String?
    var isNotificationAuthorized : Bool?

    override init() {

    }

    required init?(map: Map) {

    }

	func mapping(map: Map)
	{
        accountUserFirstName <- map["AccountUserFirstName"]
        accountUserGender <- map["AccountUserGender"]
        accountUserLastName <- map["AccountUserLastName"]
        accountUserSecondLastName <- map["AccountUserSecondLastName"]
        city <- map["City"]
        dateOfBirth <- map["DateOfBirth"]
        personalId <- map["PersonalId"]
        rUT <- map["RUT"]
        isNotificationAuthorized <- map["isNotificationAuthorized"]
	}

}
