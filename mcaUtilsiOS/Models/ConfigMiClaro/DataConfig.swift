//
//  DataConfig.swift
//  MiClaro
//
//  Created by Roberto Gutierrez Resendiz on 08/08/17.
//  Copyright © 2017 am. All rights reserved.
//

import UIKit
import ObjectMapper

/// Clase relacionada con la definición del archivo de configuración
class DataConfig: NSObject, Mappable {

    var mensajeVigencia : [MensajeVigencia]?
    var acknowledgementCodes : [AcknowledgementCode]?
    var addService : AddService?
    var billing : BillingConfig?
    var billingPayment : BillingPayment?
    var click2BuyTexts : Click2BuyText?
    var digitalBirthTexts : DigitalBirthText?
    var generales : Generale?
    var help : HelpConfig?
    var home : Home?
    var landing : Landing?
    var login : LoginConfig?
    var mobile : Mobile?
    var newRegisterTexts : NewRegisterText?
    var newUpdateAvailableTexts : NewUpdateAvailableText?
    var paperless : Paperles?
    var passwordRecovery : PasswordRecovery?
    var profile : Profile?
    var registro : Registro?
    var tooltips : [Tooltip]?
    var topUpMobile : BillingPayment?
    var updatePlan : UpdatePlan?
    var usagePermissionsTexts : UsagePermissionsText?

    var cacDatesTexts : CacDatesTexts?

    var subscriptions : Subscriptions?
    var buyBagsTexts: BuyBagTexts?

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
        mensajeVigencia <- map["MensajeVigencia"]
        acknowledgementCodes <- map["acknowledgementCodes"]
        addService <- map["addService"]
        billing <- map["billing"]
        billingPayment <- map["billingPayment"]
        click2BuyTexts <- map["click2BuyTexts"]
        digitalBirthTexts <- map["digitalBirthTexts"]
        generales <- map["generales"]
        help <- map["help"]
        home <- map["home"]
        landing <- map["landing"]
        login <- map["login"]
        mobile <- map["mobile"]
        newRegisterTexts <- map["newRegisterTexts"]
        newUpdateAvailableTexts <- map["newUpdateAvailableTexts"]
        newRegisterTexts <- map["newRegisterTexts"]
        paperless <- map["paperless"]
        passwordRecovery <- map["passwordRecovery"]
        profile <- map["profile"]
        registro <- map["registro"]
        tooltips <- map["tooltips"]
        topUpMobile <- map["topUpMobile"]
        updatePlan <- map["updatePlan"]
        usagePermissionsTexts <- map["usagePermissionsTexts"]
        cacDatesTexts <- map["cacDatesTexts"]

        subscriptions <- map["subscriptions"]
        buyBagsTexts <- map["buyBagsTexts"]
    }
}
