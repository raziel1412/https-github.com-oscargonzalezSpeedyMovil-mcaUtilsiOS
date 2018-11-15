//
//    RetrievePlanTicketHistoryResponse.swift
//    Model file Generated using:
//    Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport
//    (forked from Ahmed-Ali's JSONExport)
//

import Foundation
import ObjectMapper

class RetrievePlanTicketHistoryResponse : BaseResponse{

    var planTicketHistory : [PlanTicketHistory]?

    override init() {
        super.init();
    }

    required init?(map: Map) {
        super.init();
    }

    override func mapping(map: Map)
    {
        super.mapping(map: map);
        planTicketHistory <- map["PlanTicketHistory"]
    }
}
