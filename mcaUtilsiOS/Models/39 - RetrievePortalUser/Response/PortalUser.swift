//
//    PortalUser.swift
//    Model file Generated using:
//    Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport
//    (forked from Ahmed-Ali's JSONExport)
//

import Foundation
import ObjectMapper

class PortalUser : NSObject,Mappable{

    var company : Int?
    var contactNumber : String?
    var email : String?
    var id : String?
    var passwordStatus : Int?
    var rut : String?
    var isDigitalBirth : Bool?

    override init() {
        super.init()
    }

    required init?(map: Map) {
    }

    func mapping(map: Map)
    {
        company <- map["Company"]
        contactNumber <- map["ContactNumber"]
        email <- map["Email"]
        id <- map["Id"]
        passwordStatus <- map["PasswordStatus"]
        rut <- map["Rut"]
        isDigitalBirth <- map["isDigitalBirth"]
    }
}
