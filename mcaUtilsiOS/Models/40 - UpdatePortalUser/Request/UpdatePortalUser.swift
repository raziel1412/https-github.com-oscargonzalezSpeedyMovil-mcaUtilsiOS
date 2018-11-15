//
//    UpdatePortalUser.swift
//    Model file Generated using:
//    Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport
//    (forked from Ahmed-Ali's JSONExport)
//

import Foundation
import ObjectMapper

class UpdatePortalUser : BaseRequest{

    var lineOfBusiness : String?
    var portalUser : PortalUser?

    override init() {
        super.init()
    }

    required init?(map: Map) {
        super.init(map: map);
    }

    override func mapping(map: Map)
    {
        lineOfBusiness <- map["LineOfBusiness"]
        portalUser <- map["PortalUser"]
    }
}
