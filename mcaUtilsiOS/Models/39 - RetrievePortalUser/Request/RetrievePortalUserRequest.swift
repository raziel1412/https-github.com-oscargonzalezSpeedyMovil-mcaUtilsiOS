//
//    RetrievePortalUserRequest.swift
//    Model file Generated using:
//    Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport
//    (forked from Ahmed-Ali's JSONExport)
//

import Foundation
import ObjectMapper

class RetrievePortalUserRequest : NSObject,Mappable{

    var retrievePortalUser : RetrievePortalUser?
    var retrievePortalUserFault : BaseFault?

    override init() {
        super.init()
        retrievePortalUser = RetrievePortalUser();
    }

    required init?(map: Map) {
    }

    func mapping(map: Map)
    {
        retrievePortalUser <- map["RetrievePortalUser"]
        retrievePortalUserFault <- map["RetrievePortalUserFault"]
    }
}
