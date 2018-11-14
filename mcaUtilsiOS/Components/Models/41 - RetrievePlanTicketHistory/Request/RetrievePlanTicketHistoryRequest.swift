//
//    RetrievePlanTicketHistoryRequest.swift
//    Model file Generated using:
//    Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport
//    (forked from Ahmed-Ali's JSONExport)
//

import Foundation
import ObjectMapper

class RetrievePlanTicketHistoryRequest : NSObject, Mappable{

    var retrievePlanTicketHistory : RetrievePlanTicketHistory?
    var retrievePlanTicketHistoryFault : BaseFault?

    override init() {
        super.init()
        retrievePlanTicketHistory = RetrievePlanTicketHistory();
    }

    required init?(map: Map) {
    }

    func mapping(map: Map)
    {
        retrievePlanTicketHistory <- map["RetrievePlanTicketHistory"]
        retrievePlanTicketHistoryFault <- map["RetrievePlanTicketHistoryFault"]
    }
}
