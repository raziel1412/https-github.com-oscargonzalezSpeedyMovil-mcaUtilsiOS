//
//	UpdateProfileInformation.swift
//	Model file Generated using: 
//	Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport 
//	(forked from Ahmed-Ali's JSONExport)
//

import Foundation
import ObjectMapper

/// Clase que representa los datos del Request utilizado para consumir el servicio UpdateProfileInformation. Actualiza la información de perfil de la cuenta de usuario
/// Forma parte del adaptador MC_IdentityManagementAdapter
class UpdateProfileInformation : BaseRequest{

    var contactMethods : ContactMethod?
    var lineOfBusiness : String?
    var newUserProfileID : String?
    var personalDetailsInformation : PersonalDetailsInformation?
    var isClaroPromotionsAccepted : Bool?
    var isTermsAndConditionsAccepted : Bool?

    override init() {
        super.init()
    }

    required init?(map: Map) {
        super.init(map: map);
    }

    override func mapping(map: Map)
    {
        super.mapping(map: map);
		contactMethods <- map["ContactMethods"]
		lineOfBusiness <- map["LineOfBusiness"]
		newUserProfileID <- map["NewUserProfileId"]
		personalDetailsInformation <- map["PersonalDetailsInformation"]
		isClaroPromotionsAccepted <- map["isClaroPromotionsAccepted"]
		isTermsAndConditionsAccepted <- map["isTermsAndConditionsAccepted"]
		
	}

}
