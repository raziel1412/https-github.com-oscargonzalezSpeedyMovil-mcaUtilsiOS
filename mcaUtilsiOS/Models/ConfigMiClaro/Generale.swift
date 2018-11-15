//
//  Generale.swift
//  MiClaro
//
//  Created by Roberto Gutierrez Resendiz on 08/08/17.
//  Copyright © 2017 am. All rights reserved.
//

import UIKit
import ObjectMapper

/// Clase relacionada con la definición del archivo de configuración
class Generale: NSObject, Mappable {

    var acceptBtn : String?
    var accountNumber : String?
    var actualPassword : String?
    var address : String?
    var allPackage : String?
    var amountPayable : String?
    var available : String?
    var bill : String?
    var bills : String?
    var cancelBtn : String?
    var chooseOne : String?
    var closeBtn : String?
    var comments : String?
    var commonHeader : String?
    var confirmBtn : String?
    var confirmNewPassword : String?
    var confirmPassword : String?
    var consumption : String?
    var data : String?
    var detailComment : String?
    var done : String?
    var email : String?
    var emailErrorFormat : String?
    var emptyField : String?
    var expired : String?
    var fixedLine : String?
    var free : String?
    var genericError : String?
    var internet : String?
    var lineNumber : String?
    var lineResume : String?
    var messages : String?
    var mms : String?
    var mobile : String?
    var mobileNumber : String?
    var monthUse : String?
    var myService : String?
    var newPassword : String?
    var nextBtn : String?
    var no : String?
    var noPayment : String?
    var okBtn : String?
    var paidBefore : String?
    var paidBeforePre : String?
    var password : String?
    var passwordConfirm : String?
    var passwordMustHave : String?
    var passwordRule1 : String?
    var passwordRule2 : String?
    var passwordRule3 : String?
    var passwordRuleError : String?
    var passwordSameError : String?
    var payBill : String?
    var paySuccess : String?
    var payTotal : String?
    var phone : String?
    var pin : String?
    var pinAlert : String?
    var pinAlertTitle : String?
    var planDetails : String?
    var postpaid : String?
    var prepaid : String?
    var register : String?
    var requestBtn : String?
    var resendPin : String?
    var rut : String?
    var sendBtn : String?
    var serviceNotRespond : String?
    var sesionClose : String?
    var signBtn : String?
    var sms : String?
    var smsSend : String?
    var successTitle : String?
    var termsAndConditions : String?
    var thanks : String?
    var totalToPay : String?
    var tv : String?
    var used : String?
    var validateBtn : String?
    var viewBill : String?
    var viewDetails : String?
    var viewDetailsPlan : String?
    var voice : String?
    var yes : String?
    var yourBill : String?
    var costText : String?

    override init() {
    }

    /// Función encargada de mapear el JSON correspondiente
    /// - parameter Map: Objeto de tipo Map
    required init?(map: Map) {
        super.init()
    }

    /// Función encargada de mapear el JSON correspondiente
    /// - parameter Map: Objeto de tipo Map
    func mapping(map: Map)
    {
        acceptBtn <- map["acceptBtn"]
        accountNumber <- map["accountNumber"]
        actualPassword <- map["actualPassword"]
        address <- map["address"]
        allPackage <- map["allPackage"]
        amountPayable <- map["amountPayable"]
        available <- map["available"]
        bill <- map["bill"]
        bills <- map["bills"]
        cancelBtn <- map["cancelBtn"]
        chooseOne <- map["chooseOne"]
        closeBtn <- map["closeBtn"]
        comments <- map["comments"]
        commonHeader <- map["commonHeader"]
        confirmBtn <- map["confirmBtn"]
        confirmNewPassword <- map["confirmNewPassword"]
        confirmPassword <- map["confirmPassword"]
        consumption <- map["consumption"]
        data <- map["data"]
        detailComment <- map["detailComment"]
        done <- map["done"]
        email <- map["email"]
        emailErrorFormat <- map["emailErrorFormat"]
        emptyField <- map["emptyField"]
        expired <- map["expired"]
        fixedLine <- map["fixedLine"]
        free <- map["free"]
        genericError <- map["genericError"]
        internet <- map["internet"]
        lineNumber <- map["lineNumber"]
        lineResume <- map["lineResume"]
        messages <- map["messages"]
        mms <- map["mms"]
        mobile <- map["mobile"]
        mobileNumber <- map["mobileNumber"]
        monthUse <- map["monthUse"]
        myService <- map["myService"]
        newPassword <- map["newPassword"]
        nextBtn <- map["nextBtn"]
        no <- map["no"]
        noPayment <- map["noPayment"]
        okBtn <- map["okBtn"]
        paidBefore <- map["paidBefore"]
        paidBeforePre <- map["paidBeforePre"]
        password <- map["password"]
        passwordConfirm <- map["passwordConfirm"]
        passwordMustHave <- map["passwordMustHave"]
        passwordRule1 <- map["passwordRule1"]
        passwordRule2 <- map["passwordRule2"]
        passwordRule3 <- map["passwordRule3"]
        passwordRuleError <- map["passwordRuleError"]
        passwordSameError <- map["passwordSameError"]
        payBill <- map["payBill"]
        paySuccess <- map["paySuccess"]
        payTotal <- map["payTotal"]
        phone <- map["phone"]
        pin <- map["pin"]
        pinAlert <- map["pinAlert"]
        pinAlertTitle <- map["pinAlertTitle"]
        planDetails <- map["planDetails"]
        postpaid <- map["postpaid"]
        prepaid <- map["prepaid"]
        register <- map["register"]
        requestBtn <- map["requestBtn"]
        resendPin <- map["resendPin"]
        rut <- map["rut"]
        sendBtn <- map["sendBtn"]
        serviceNotRespond <- map["serviceNotRespond"]
        sesionClose <- map["sesionClose"]
        signBtn <- map["signBtn"]
        sms <- map["sms"]
        smsSend <- map["smsSend"]
        successTitle <- map["successTitle"]
        termsAndConditions <- map["termsAndConditions"]
        thanks <- map["thanks"]
        totalToPay <- map["totalToPay"]
        tv <- map["tv"]
        used <- map["used"]
        validateBtn <- map["validateBtn"]
        viewBill <- map["viewBill"]
        viewDetails <- map["viewDetails"]
        viewDetailsPlan <- map["viewDetailsPlan"]
        voice <- map["voice"]
        yes <- map["yes"]
        yourBill <- map["yourBill"]
        costText <- map["costText"]
    }
}
