//
//	Plan.swift
//	Model file Generated using:
//	Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport
//	(forked from Ahmed-Ali's JSONExport)
//

import Foundation
import ObjectMapper

// Esta clase almacena la información necesaria para representar un card y un plan.
class PlanCard : NSObject, Mappable {
    var retrieveBillDetailsResponse : RetrieveBillDetailsResponse?
    var plan : Plan?
    var tabName : String?
    var lineOfBusiness: String?
    var accountId: String?
    var serviceId: String?
    var serviceType: String?
    var featureUsage : FeatureUsage?
    var accountDetail : AccountDetail?
    var serviceFeatureUsage : ServiceFeatureUsage?
    
    var billDetails : [BillDetail]? = nil
    var tempBillSelectedIndex = 0
    var currentBillSelectedIndex = 0

    
    override init() {
        retrieveBillDetailsResponse = RetrieveBillDetailsResponse();
    }

    required init?(map: Map) {
        retrieveBillDetailsResponse = RetrieveBillDetailsResponse();
    }

    func mapping(map: Map)
    {
        plan <- map["Plan"];
        tabName <- map["TabName"];
        lineOfBusiness <- map["LineOfBusiness"];
        accountId <- map["AccountId"];
        serviceId <- map["ServiceId"];
        serviceType <- map["ServiceType"];
        retrieveBillDetailsResponse <- map["RetrieveBillDetailsResponse"];
        featureUsage <- map["FeatureUsage"];
        accountDetail <- map["AccountDetail"];
        serviceFeatureUsage <- map["ServiceFeatureUsage"];
    }
}


