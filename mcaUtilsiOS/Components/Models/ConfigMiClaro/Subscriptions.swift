//
//  Subscriptions.swift
//  MiClaro
//
//  Created by Omar Israel Trujillo Osornio on 10/3/18.
//  Copyright © 2018 am. All rights reserved.
//

import Foundation
import ObjectMapper

/// Clase relacionada con la definición del archivo de configuración
class Subscriptions: NSObject, Mappable {
    
    var subscriptionsActive : String?
    var subscriptionsBlock : String?
    var subscriptionsBlockMessaging : String?
    var subscriptionsCheckStatus : String?
    var subscriptionsDate : String?
    var subscriptionsDelete : String?
    var subscriptionsDeleteTitle : String?
    var subscriptionsHistory : String?
    var subscriptionsInactive : String?
    var subscriptionsLineNumber : String?
    var subscriptionsLock : String?
    var subscriptionsNoSusciptionsTitle : String?
    var subscriptionsNotExist : String?
    var subscriptionsOn : String?
    var subscriptionsPickLine : String?
    var subscriptionsShortNumber : String?
    var subscriptionsState : String?
    var subscriptionsSubtitle : String?
    var subscriptionsSuccessBlockDescription : String?
    var subscriptionsSuccessBlockTitle : String?
    var subscriptionsSuccessDelete : String?
    var subscriptionsSuccessDeleteDescription : String?
    var subscriptionsSureBlock : String?
    var subscriptionsSureWantDelete : String?
    var subscriptionsTitle : String?
    var subscriptionsUnblocked : String?
    var subscriptionsUnlockDescription : String?
    var subscriptionsUnlockSuccessDescription : String?
    var subscriptionsUnlockSuccessTitle : String?
    var subscriptionsUnlockTitle : String?
    
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
        subscriptionsActive <- map["subscriptionsActive"]
        subscriptionsBlock <- map["subscriptionsBlock"]
        subscriptionsBlockMessaging <- map["subscriptionsBlockMessaging"]
        subscriptionsCheckStatus <- map["subscriptionsCheckStatus"]
        subscriptionsDate <- map["subscriptionsDate"]
        subscriptionsDelete <- map["subscriptionsDelete"]
        subscriptionsDeleteTitle <- map["subscriptionsDeleteTitle"]
        subscriptionsHistory <- map["subscriptionsHistory"]
        subscriptionsInactive <- map["subscriptionsInactive"]
        subscriptionsLineNumber <- map["subscriptionsLineNumber"]
        subscriptionsLock <- map["subscriptionsLock"]
        subscriptionsNoSusciptionsTitle <- map["subscriptionsNoSusciptionsTitle"]
        subscriptionsNotExist <- map["subscriptionsNotExist"]
        subscriptionsOn <- map["subscriptionsOn"]
        subscriptionsPickLine <- map["subscriptionsPickLine"]
        subscriptionsShortNumber <- map["subscriptionsShortNumber"]
        subscriptionsState <- map["subscriptionsState"]
        subscriptionsSubtitle <- map["subscriptionsSubtitle"]
        subscriptionsSuccessBlockDescription <- map["subscriptionsSuccessBlockDescription"]
        subscriptionsSuccessBlockTitle <- map["subscriptionsSuccessBlockTitle"]
        subscriptionsSuccessDelete <- map["subscriptionsSuccessDelete"]
        subscriptionsSuccessDeleteDescription <- map["subscriptionsSuccessDeleteDescription"]
        subscriptionsSureBlock <- map["subscriptionsSureBlock"]
        subscriptionsSureWantDelete <- map["subscriptionsSureWantDelete"]
        subscriptionsTitle <- map["subscriptionsTitle"]
        subscriptionsUnblocked <- map["subscriptionsUnblocked"]
        subscriptionsUnlockDescription <- map["subscriptionsUnlockDescription"]
        subscriptionsUnlockSuccessDescription <- map["subscriptionsUnlockSuccessDescription"]
        subscriptionsUnlockSuccessTitle <- map["subscriptionsUnlockSuccessTitle"]
        subscriptionsUnlockTitle <- map["subscriptionsUnlockTitle"]
    }
}

