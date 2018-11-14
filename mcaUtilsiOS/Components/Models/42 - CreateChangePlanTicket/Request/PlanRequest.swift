//
//    PlanRequest.swift
//    Model file Generated using:
//    Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport
//    (forked from Ahmed-Ali's JSONExport)
//

import Foundation
import ObjectMapper

class PlanRequest : NSObject, Mappable{

    var emailContactAddress : String?
    var mobileContactNumber : String?
    var name : String?
    var originalPlan : String?
    var requestedPlan : String?
    var rut : String?
    var selectedLine : String?

    override init() {
        super.init()
    }

    required init?(map: Map) {
    }

    func mapping(map: Map)
    {
        emailContactAddress <- map["EmailContactAddress"]
        mobileContactNumber <- map["MobileContactNumber"]
        name <- map["Name"]
        originalPlan <- map["OriginalPlan"]
        requestedPlan <- map["RequestedPlan"]
        rut <- map["Rut"]
        selectedLine <- map["SelectedLine"]
    }
}
