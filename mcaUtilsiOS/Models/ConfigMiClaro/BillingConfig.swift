//
//  BillingConfig.swift
//  MiClaro
//
//  Created by Roberto Gutierrez Resendiz on 22/02/18.
//  Copyright © 2018 am. All rights reserved.
//

import UIKit
import ObjectMapper

/// Clase relacionada con la definición del archivo de configuración
class BillingConfig: NSObject, Mappable {
    var accountId : String?
    var activatePaperless : String?
    var address : String?
    var billingDescription : String?
    var billingDescription2 : String?
    var continuePaperLess : String?
    var downloadBill : String?
    var expiration : String?
    var header : String?
    var lastPeriod : String?
    var paymentStatus : String?
    var period : String?
    var sendBill : String?
    var title : String?
    var totalIssued : String?
    var successDownload : String?
    var successDownloadDescription : String?
    var viewBill : String?
    
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
        accountId <- map["accountId"]
        activatePaperless <- map["activatePaperless"]
        address <- map["address"]
        billingDescription <- map["billingDescription"]
        billingDescription2 <- map["billingDescription2"]
        continuePaperLess <- map["continuePaperLess"]
        downloadBill <- map["downloadBill"]
        expiration <- map["expiration"]
        header <- map["header"]
        lastPeriod <- map["lastPeriod"]
        paymentStatus <- map["paymentStatus"]
        period <- map["period"]
        sendBill <- map["sendBill"]
        title <- map["title"]
        totalIssued <- map["totalIssued"]
        successDownload <- map["successDownload"]
        successDownloadDescription <- map["successDownloadDescription"]
        viewBill <- map["viewBill"]
    }
}
