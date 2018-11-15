//
//  HelpConfig.swift
//  MiClaro
//
//  Created by Roberto Gutierrez Resendiz on 08/08/17.
//  Copyright © 2017 am. All rights reserved.
//

import UIKit
import ObjectMapper

/// Clase relacionada con la definición del archivo de configuración
class HelpConfig: NSObject, Mappable {

    var aboutUrl : String?
    var cacInfo : [CacInfo]?
    var contactEmail : String?
    var contactPhone : String?
    var reportBugCategories : [ReportBugCategory]?
    var about : String?
    var aboutDescription : String?
    var cacHeader : String?
    var emailDescription1 : String?
    var emailDescription2 : String?
    var emailHeader : String?
    var emailSendUs : String?
    var header : String?
    var helpApp : String?
    var helpCenters : String?
    var helpCentersDescription : String?
    var helpChat : String?
    var helpDescription : String?
    var helpMail : String?
    var helpOnline : String?
    var helpPhone : String?
    var maxLenghtInputText : String?
    var reportBug : String?
    var reportBugDescription : String?
    var reportBugHeader : String?
    var reportBugSubHeader : String?
    var reportBugSuccess : String?
    var reportBugSuccess2 : String?
    var reportBugSuccess3 : String?
    var suggestions : String?
    var suggestionsDescription : String?
    var suggestionsHeader : String?
    var suggestionsInput : String?
    var suggestionsMail : String?
    var suggestionsSuccess : String?
    var title : String?

    override init() {

    }

    /// Función encargada de mapear el JSON correspondiente
    /// - parameter Map: Objeto de tipo Map
    required init?(map: Map) {

    }

    /// Función encargada de mapear el JSON correspondiente
    /// - parameter Map: Objeto de tipo Map
    func mapping(map: Map)
    {
        aboutUrl <- map["aboutUrl"]
        cacInfo <- map["cacInfo"]
        contactEmail <- map["contactEmail"]
        contactPhone <- map["contactPhone"]
        reportBugCategories <- map["reportBugCategories"]
        about <- map["about"]
        aboutDescription <- map["aboutDescription"]
        cacHeader <- map["cacHeader"]
        emailDescription1 <- map["emailDescription1"]
        emailDescription2 <- map["emailDescription2"]
        emailHeader <- map["emailHeader"]
        emailSendUs <- map["emailSendUs"]
        header <- map["header"]
        helpApp <- map["helpApp"]
        helpCenters <- map["helpCenters"]
        helpCentersDescription <- map["helpCentersDescription"]
        helpChat <- map["helpChat"]
        helpDescription <- map["helpDescription"]
        helpMail <- map["helpMail"]
        helpOnline <- map["helpOnline"]
        helpPhone <- map["helpPhone"]
        maxLenghtInputText <- map["maxLenghtInputText"]
        reportBug <- map["reportBug"]
        reportBugDescription <- map["reportBugDescription"]
        reportBugHeader <- map["reportBugHeader"]
        reportBugSubHeader <- map["reportBugSubHeader"]
        reportBugSuccess <- map["reportBugSuccess"]
        reportBugSuccess2 <- map["reportBugSuccess2"]
        reportBugSuccess3 <- map["reportBugSuccess3"]
        suggestions <- map["suggestions"]
        suggestionsDescription <- map["suggestionsDescription"]
        suggestionsHeader <- map["suggestionsHeader"]
        suggestionsInput <- map["suggestionsInput"]
        suggestionsMail <- map["suggestionsMail"]
        suggestionsSuccess <- map["suggestionsSuccess"]
        title <- map["title"]
    }
}
