//
//    RetrievePortalUserResponse.swift
//    Model file Generated using:
//    Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport
//    (forked from Ahmed-Ali's JSONExport)
//

import Foundation
import ObjectMapper

class RetrievePortalUserResponse : BaseResponse{

    var portalUser : PortalUser?

    override init() {
        super.init();
    }

    required init?(map: Map) {
        super.init();
    }

    override func mapping(map: Map)
    {
        super.mapping(map: map);
        portalUser <- map["PortalUser"]

    }
}
