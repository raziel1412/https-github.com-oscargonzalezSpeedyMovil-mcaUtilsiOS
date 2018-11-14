//
//    RetrievePlanTicketHistoryResult.swift
//    Model file Generated using:
//    Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport
//    (forked from Ahmed-Ali's JSONExport)
//

import Foundation
import ObjectMapper

class RetrievePlanTicketHistoryResult : BaseResult{

    var retrievePlanTicketHistoryResponse : RetrievePlanTicketHistoryResponse?
    var retrievePlanTicketHistoryFault : BaseFault?

    override init() {
        super.init();
    }

    required init?(map: Map) {
        super.init();
    }

    override func mapping(map: Map)
    {
        super.mapping(map: map);
        retrievePlanTicketHistoryResponse <- map["RetrievePlanTicketHistoryResponse"]
        retrievePlanTicketHistoryFault <- map["RetrievePlanTicketHistoryFault"];
    }
}
