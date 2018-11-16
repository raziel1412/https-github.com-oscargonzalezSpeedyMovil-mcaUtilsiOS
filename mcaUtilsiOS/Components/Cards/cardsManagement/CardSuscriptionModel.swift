//
//  CardSuscriptionModel.swift
//  MiClaro
//
//  Created by Jonathan Abimael Cruz Orozco on 14/09/18.
//  Copyright © 2018 am. All rights reserved.
//

import Foundation

class CardSuscriptionModel {
    var accountID: String = ""
    var typeAccount: TypeAccountService = .None
    
    var arrayServices: [AssociatedServicesCard] = []
    
    var serviceName: String = ""
    var origin: String = ""
    var shortNumber: String = ""
    var subscriptionDate: String = ""
    var password: String = ""
    var Provider: String = ""
    var status: Int = 0
    var MSISDN: String = ""
    var lob: String = ""
    
//    "SubscriptionDate": "2017-10-29T01:08:19.000-03:00",
//    "ShortNumber": "10380",
//    "Service": "LIVESCREEN",
//    "Password": "1001524",
//    "Origin": "SmsPremium",
//    "Provider": "CELLTICK",
//    "MSISDN": "56959149848"
    
    init() {
        
    }
    
    /// Settear la informacion
    func setAccountID(accountID: String) {
        self.accountID = accountID
    }
    func appendService(service: AssociatedServicesCard) {
        self.arrayServices.append(service)
    }
    func setTypeAccount(lob: String) {
        switch lob {
        case "2":
            self.typeAccount = .MovilPrepago
            break
        case "3":
            self.typeAccount = .MovilPospago
            break
        default:
            break
        }
    }
}
