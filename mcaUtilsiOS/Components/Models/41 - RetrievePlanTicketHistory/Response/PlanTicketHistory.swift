//
//    PlanTicketHistory.swift
//    Model file Generated using:
//    Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport
//    (forked from Ahmed-Ali's JSONExport)
//

import Foundation
import ObjectMapper

class PlanTicketHistory : NSObject, Mappable{

    var currentPlan : String?
    var requestDate : String?
    var requestedLine : String?
    var requestedPlan : String?
    var state : String?
    var ticketNumber : Int?

    override init() {
        super.init()
    }

    required init?(map: Map) {
    }

    func mapping(map: Map)
    {
        currentPlan <- map["CurrentPlan"]
        requestDate <- map["RequestDate"]
        requestedLine <- map["RequestedLine"]
        requestedPlan <- map["RequestedPlan"]
        state <- map["State"]
        ticketNumber <- map["TicketNumber"]
    }
}
