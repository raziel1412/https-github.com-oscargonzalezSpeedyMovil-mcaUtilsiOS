//
//    UpdatePortalUserRequest.swift
//    Model file Generated using:
//    Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport
//    (forked from Ahmed-Ali's JSONExport)
//

import Foundation
import ObjectMapper

class UpdatePortalUserRequest : NSObject,Mappable{

    var updatePortalUser : UpdatePortalUser?
    var updatePortalUserFault : BaseFault?

    override init() {
        super.init()
        updatePortalUser = UpdatePortalUser();
    }

    required init?(map: Map) {
    }

    func mapping(map: Map)
    {
        updatePortalUser <- map["UpdatePortalUser"]
        updatePortalUserFault <- map["UpdatePortalUserFault"]
    }
}
