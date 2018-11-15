//
//  DigitalBirthText.swift
//  MiClaro
//
//  Created by Roberto Gutierrez Resendiz on 22/08/18.
//  Copyright © 2018 am. All rights reserved.
//

import UIKit
import ObjectMapper

class DigitalBirthText: NSObject, Mappable {

    var digitalBirthConfirmPassword : String?
    var digitalBirthDescription : String?
    var digitalBirthGoToAdd : String?
    var digitalBirthGoToAddDescription : String?
    var digitalBirthGoToProfile : String?
    var digitalBirthGoToProfileDescription : String?
    var digitalBirthGoToRecharge : String?
    var digitalBirthGoToRechargeDescription : String?
    var digitalBirthLogout : String?
    var digitalBirthName : String?
    var digitalBirthPassword : String?
    var digitalBirthSuccess : String?
    var digitalBirthSuccessDescription : String?
    var digitalBirthTitle : String?
    var digitalBirthTyC1 : String?
    var digitalBirthTyC2 : String?
    var digitalBirthWelcome : String?

    override init() {

    }

    /// Función encargada de mapear el JSON correspondiente
    /// - parameter Map: Objeto de tipo Map
    required init?(map: Map) {
        super.init();
    }

    /// Función encargada de mapear el JSON correspondiente
    /// - parameter Map: Objeto de tipo Map
    func mapping(map: Map)
    {
        digitalBirthConfirmPassword <- map["digitalBirthConfirmPassword"]
        digitalBirthDescription <- map["digitalBirthDescription"]
        digitalBirthGoToAdd <- map["digitalBirthGoToAdd"]
        digitalBirthGoToAddDescription <- map["digitalBirthGoToAddDescription"]
        digitalBirthGoToProfile <- map["digitalBirthGoToProfile"]
        digitalBirthGoToProfileDescription <- map["digitalBirthGoToProfileDescription"]
        digitalBirthGoToRecharge <- map["digitalBirthGoToRecharge"]
        digitalBirthGoToRechargeDescription <- map["digitalBirthGoToRechargeDescription"]
        digitalBirthLogout <- map["digitalBirthLogout"]
        digitalBirthName <- map["digitalBirthName"]
        digitalBirthPassword <- map["digitalBirthPassword"]
        digitalBirthSuccess <- map["digitalBirthSuccess"]
        digitalBirthSuccessDescription <- map["digitalBirthSuccessDescription"]
        digitalBirthTitle <- map["digitalBirthTitle"]
        digitalBirthTyC1 <- map["digitalBirthTyC1"]
        digitalBirthTyC2 <- map["digitalBirthTyC2"]
        digitalBirthWelcome <- map["digitalBirthWelcome"]
    }
}
