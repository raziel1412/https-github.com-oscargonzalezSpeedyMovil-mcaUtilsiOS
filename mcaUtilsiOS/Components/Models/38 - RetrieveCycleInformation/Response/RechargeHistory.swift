//
//    RechargeHistory.swift
//    Model file Generated using:
//    Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport
//    (forked from Ahmed-Ali's JSONExport)
//

import Foundation
import ObjectMapper

class RechargeHistory : NSObject,Mappable{

    var endDate : String?
    var remainingDays : Int?
    var startDate : String?

    override init() {
        super.init()
    }

    required init?(map: Map) {
    }

    func mapping(map: Map)
    {
        endDate <- map["EndDate"]
        remainingDays <- map["RemainingDays"]
        startDate <- map["StartDate"]
    }
}
