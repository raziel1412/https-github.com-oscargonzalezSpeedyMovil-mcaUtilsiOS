//
//    RetrieveCycleInformationResponse.swift
//    Model file Generated using:
//    Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport
//    (forked from Ahmed-Ali's JSONExport)
//

import Foundation
import ObjectMapper

class RetrieveCycleInformationResponse : BaseResponse{

    var rechargeHistory : [RechargeHistory]?

    override init() {
        super.init()
    }

    required init?(map: Map) {
        super.init(map: map);
    }

    override func mapping(map: Map)
    {
        super.mapping(map: map);
        rechargeHistory <- map["RechargeHistory"]

    }
}
