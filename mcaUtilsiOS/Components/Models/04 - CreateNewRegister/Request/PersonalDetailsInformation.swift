//
//	PersonalDetailsInformation.swift
//	Model file Generated using: 
//	Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport 
//	(forked from Ahmed-Ali's JSONExport)
//

import Foundation
import ObjectMapper

/// Clase que representa los datos del Request utilizado para consumir el servicio CreateNewRegister. Crea un nuevo registro de cuenta  en los sistemas de backend permitiendo la administración de los servicios
/// Forma parte del adaptador MC_IdentityManagementAdapter
class PersonalDetailsInformation : NSObject,Mappable{

    var accountUserFirstName : String?
    var accountUserGender : String?
    var accountUserLastName : String?
    var accountUserSecondLastName : String?
    var accountUserTaxId : String?
    var city : String?
    var dateOfBirth : String?
    var personalId : [PersonalId]?
    var rUT : String?
    var isNotificationAuthorized : String?
    var personalIdUpdate: PersonalId?

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
        accountUserTaxId <- map["AccountUserTaxId"]
        city <- map["City"]
        dateOfBirth <- map["DateOfBirth"]
        personalId <- map["PersonalId"]
        rUT <- map["RUT"]
        isNotificationAuthorized <- map["isNotificationAuthorized"]
        personalIdUpdate <- map["PersonalId"]
	}

}
