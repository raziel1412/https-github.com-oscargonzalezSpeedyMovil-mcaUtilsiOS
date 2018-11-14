//
//    CreateChangePlanTicket.swift
//    Model file Generated using:
//    Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport
//    (forked from Ahmed-Ali's JSONExport)
//

import Foundation
import ObjectMapper

class CreateChangePlanTicket : BaseRequest{

    var accountId : String?
    var lineOfBusiness : String?
    var planRequest : PlanRequest?

    override init() {
        super.init()
    }

    required init?(map: Map) {
        super.init(map: map);
    }

    override func mapping(map: Map)
    {
        accountId <- map["AccountId"]
        lineOfBusiness <- map["LineOfBusiness"]
        planRequest <- map["PlanRequest"]
    }
}
