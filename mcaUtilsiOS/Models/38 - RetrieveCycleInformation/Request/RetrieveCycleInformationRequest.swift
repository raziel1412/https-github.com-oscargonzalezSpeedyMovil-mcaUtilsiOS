//
//    RetrieveCycleInformationRequest.swift
//    Model file Generated using:
//    Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport
//    (forked from Ahmed-Ali's JSONExport)
//

import Foundation
import ObjectMapper

class RetrieveCycleInformationRequest : NSObject,Mappable{

    var retrieveCycleInformation : RetrieveCycleInformation?
    var retrieveCycleInformationFault : BaseFault?

    override init() {
        super.init()
        retrieveCycleInformation = RetrieveCycleInformation();
    }

    required init?(map: Map) {
    }

    func mapping(map: Map)
    {
        retrieveCycleInformation <- map["RetrieveCycleInformation"]
        retrieveCycleInformationFault <- map["RetrieveCycleInformationFault"]
    }
}
