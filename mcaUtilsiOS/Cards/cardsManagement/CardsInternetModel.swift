//
//  CardsInternetModel.swift
//  MiClaro
//
//  Created by Jonathan Abimael Cruz Orozco on 12/07/18.
//  Copyright © 2018 am. All rights reserved.
//

import Foundation

class CardsInternetModel {
    var accountID: String = ""
    var addressHome: String = ""
    var planDetail: PlanDetailCard = PlanDetailCard()
    var typeAccount: TypeAccountService = .None
    var serviceID: String = ""
    
    func setAddressHome(address: String) {
        self.addressHome = address
    }
    
    func setAccountID(accountID: String) {
        self.accountID = accountID
    }
    
    func setTypeAccount(lob: String) {
        switch lob {
        case "1":
            self.typeAccount = .Internet
            break
        default:
            break
        }
    }
    
    func setServiceID(serviceID: String) {
        self.serviceID = serviceID
    }
}
