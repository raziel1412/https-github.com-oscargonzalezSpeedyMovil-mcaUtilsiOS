//
//  BaseRequest.swift
//  MiClaro
//
//  Created by Roberto Gutierrez Resendiz on 14/08/17.
//  Copyright © 2017 am. All rights reserved.
//

import UIKit
import ObjectMapper

// Esta clase almacena la estructura básica de todos los llamados de tipo Request definiendo sus propiedades comunes para el consumo de los servicios. Se utiliza junto con los servicios enumerados del 1 - 37
class BaseRequest: NSObject, Mappable {
    var requestingUserId : String?
    var originatingIPAddress : String?
    var uUID : String?
    var countryCode : String?
    var channel : String?
    var isDelegate : String?
    var ownerProfileId : String?
    var consumerPreferredLanguage : String?
    var userProfileId : String?

    override init() {
        super.init();
    }

    required init?(map: Map) {
        super.init();
    }

    func mapping(map: Map)
    {
        channel <- map["Channel"]
        consumerPreferredLanguage <- map["ConsumerPreferredLanguage"]
        countryCode <- map["CountryCode"]
        isDelegate <- map["IsDelegate"]
        originatingIPAddress <- map["OriginatingIPAddress"]
        ownerProfileId <- map["OwnerProfileId"]
        requestingUserId <- map["RequestingUserId"]
        uUID <- map["UUID"]
        userProfileId <- map["UserProfileID"]
    }
}
