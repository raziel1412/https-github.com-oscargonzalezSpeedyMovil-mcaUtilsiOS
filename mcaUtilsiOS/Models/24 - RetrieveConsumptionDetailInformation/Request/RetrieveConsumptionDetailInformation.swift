//
//	RetrieveConsumptionDetailInformation.swift
//	Model file Generated using: 
//	Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport 
//	(forked from Ahmed-Ali's JSONExport)
//

import Foundation
import ObjectMapper

/// Clase que representa los datos del Request utilizado para consumir el servicio RetrieveConsumptionDetailInformation. Regresa el detalle de uso de los servicios de una cuenta para un periodo en especifico
/// Forma parte del adaptador MC_ServiceManagementAdapter
class RetrieveConsumptionDetailInformation : BaseRequest{

    var accountId : String?
    var isTermsAndConditionsAccepted : Bool?
    var lineOfBusiness : String?
    var userEmailforPaperless : String?
    var userMobileNumberforPaperless : String?
    var serviceId : String?

    override init() {
        super.init()
    }

    required init?(map: Map) {
        super.init(map: map);
    }

    override func mapping(map: Map)
    {
        super.mapping(map: map)
        accountId <- map["AccountId"]
        isTermsAndConditionsAccepted <- map["IsTermsAndConditionsAccepted"]
        lineOfBusiness <- map["LineOfBusiness"]
        userEmailforPaperless <- map["UserEmailforPaperless"]
        userMobileNumberforPaperless <- map["UserMobileNumberforPaperless"]
        serviceId <- map["ServiceID"]
	}

}
