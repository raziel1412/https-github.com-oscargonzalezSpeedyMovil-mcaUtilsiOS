//
//    CreateChangePlanTicketRequest.swift
//    Model file Generated using:
//    Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport
//    (forked from Ahmed-Ali's JSONExport)
//

import Foundation
import ObjectMapper

class CreateChangePlanTicketRequest : NSObject, Mappable{

    var createChangePlanTicket : CreateChangePlanTicket?
    var createChangePlanTicketFault : BaseFault?

    override init() {
        super.init()
        createChangePlanTicket = CreateChangePlanTicket();
    }

    required init?(map: Map) {
    }

    func mapping(map: Map)
    {
        createChangePlanTicket <- map["CreateChangePlanTicket"]
        createChangePlanTicketFault <- map["CreateChangePlanTicketFault"]
    }
}
