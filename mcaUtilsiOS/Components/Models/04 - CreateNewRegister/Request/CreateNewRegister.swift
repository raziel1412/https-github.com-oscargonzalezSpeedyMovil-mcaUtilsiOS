//
//	CreateNewRegister.swift
//	Model file Generated using: 
//	Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport 
//	(forked from Ahmed-Ali's JSONExport)
//

import Foundation
import ObjectMapper

/// Clase que representa los datos del Request utilizado para consumir el servicio CreateNewRegister. Crea un nuevo registro de cuenta  en los sistemas de backend permitiendo la administración de los servicios
/// Forma parte del adaptador MC_IdentityManagementAdapter
class CreateNewRegister : BaseRequest{

    var accountId : String?
    var email : String?
    var isClaroPromotionsAccepted : String?
    var isTermsAndConditionsAccepted : String?
    var lineOfBusiness : String?
    var password : String?
    var personalDetailsInformation : PersonalDetailsInformation?
    var userProfileID : String?

    override init() {
        super.init()
    }

    required init?(map: Map) {
        super.init(map: map);
    }

    override func mapping(map: Map)
    {
        super.mapping(map: map);
        accountId <- map["AccountId"]
        email <- map["Email"]
        isClaroPromotionsAccepted <- map["IsClaroPromotionsAccepted"]
        isTermsAndConditionsAccepted <- map["IsTermsAndConditionsAccepted"]
        lineOfBusiness <- map["LineOfBusiness"]
        password <- map["Password"]
        personalDetailsInformation <- map["PersonalDetailsInformation"]
        userProfileID <- map["UserProfileID"]
	}

}
