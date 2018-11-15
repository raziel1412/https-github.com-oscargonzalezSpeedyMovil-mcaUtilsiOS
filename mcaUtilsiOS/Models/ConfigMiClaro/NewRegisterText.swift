//
//  NewRegisterText.swift
//  MiClaro
//
//  Created by Roberto Gutierrez Resendiz on 22/08/18.
//  Copyright © 2018 am. All rights reserved.
//

import UIKit
import ObjectMapper

class NewRegisterText: NSObject, Mappable {

    var newRegister : String?
    var newRegisterCellphone : String?
    var newRegisterConfirmPassword : String?
    var newRegisterDescriptionStep1 : String?
    var newRegisterFixedStep1 : String?
    var newRegisterFixedSuccess : String?
    var newRegisterHeader : String?
    var newRegisterLastStepDescription : String?
    var newRegisterLastStepTitle : String?
    var newRegisterName : String?
    var newRegisterPassword : String?
    var newRegisterPrepaidStep1 : String?
    var newRegisterPrepaidSuccess : String?
    var newRegisterPrepaidWarning1 : String?
    var newRegisterPrepaidWarning2 : String?
    var newRegisterPrepaidWarning3 : String?
    var newRegisterPrepaidWarning4 : String?
    var newRegisterSaveChanges : String?
    var newRegisterSerialNumber : String?
    var newRegisterSubStep1 : String?
    var newRegisterSuccessText : String?
    var newRegisterSuccessWithData : String?
    var newRegisterTitle : String?
    var newRegisterTyCFinal : String?
    var newRegisterTyCFirst : String?
    var newRegisterUserProfileId : String?
    var newRegisterpinValidation : String?
    var newRegisterpinValidationResendText : String?
    var newRegistertooltipDescription : String?
    var newRegistertooltipNew : String?
    var newRegistertooltipNewText : String?
    var newRegistertooltipOld : String?
    var newRegistertooltipOldText : String?
    var newRegistertooltipTitle : String?
    var newRegisterFailVerify : String?

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
        newRegister <- map["newRegister"]
        newRegisterCellphone <- map["newRegisterCellphone"]
        newRegisterConfirmPassword <- map["newRegisterConfirmPassword"]
        newRegisterDescriptionStep1 <- map["newRegisterDescriptionStep1"]
        newRegisterFixedStep1 <- map["newRegisterFixedStep1"]
        newRegisterFixedSuccess <- map["newRegisterFixedSuccess"]
        newRegisterHeader <- map["newRegisterHeader"]
        newRegisterLastStepDescription <- map["newRegisterLastStepDescription"]
        newRegisterLastStepTitle <- map["newRegisterLastStepTitle"]
        newRegisterName <- map["newRegisterName"]
        newRegisterPassword <- map["newRegisterPassword"]
        newRegisterPrepaidStep1 <- map["newRegisterPrepaidStep1"]
        newRegisterPrepaidSuccess <- map["newRegisterPrepaidSuccess"]
        newRegisterPrepaidWarning1 <- map["newRegisterPrepaidWarning1"]
        newRegisterPrepaidWarning2 <- map["newRegisterPrepaidWarning2"]
        newRegisterPrepaidWarning3 <- map["newRegisterPrepaidWarning3"]
        newRegisterPrepaidWarning4 <- map["newRegisterPrepaidWarning4"]
        newRegisterSaveChanges <- map["newRegisterSaveChanges"]
        newRegisterSerialNumber <- map["newRegisterSerialNumber"]
        newRegisterSubStep1 <- map["newRegisterSubStep1"]
        newRegisterSuccessText <- map["newRegisterSuccessText"]
        newRegisterSuccessWithData <- map["newRegisterSuccessWithData"]
        newRegisterTitle <- map["newRegisterTitle"]
        newRegisterTyCFinal <- map["newRegisterTyC_Final"]
        newRegisterTyCFirst <- map["newRegisterTyC_First"]
        newRegisterUserProfileId <- map["newRegisterUserProfileId"]
        newRegisterpinValidation <- map["newRegisterpinValidation"]
        newRegisterpinValidationResendText <- map["newRegisterpinValidationResendText"]
        newRegistertooltipDescription <- map["newRegistertooltipDescription"]
        newRegistertooltipNew <- map["newRegistertooltipNew"]
        newRegistertooltipNewText <- map["newRegistertooltipNewText"]
        newRegistertooltipOld <- map["newRegistertooltipOld"]
        newRegistertooltipOldText <- map["newRegistertooltipOldText"]
        newRegistertooltipTitle <- map["newRegistertooltipTitle"]
        newRegisterFailVerify <- map["newRegisterFailVerify"]
    }
}
