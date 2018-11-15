//
//  CardsLineaFijaModel.swift
//  MiClaro
//
//  Created by Jonathan Abimael Cruz Orozco on 31/07/18.
//  Copyright © 2018 am. All rights reserved.
//

import Foundation

class CardsLineaFijaModel {
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
            self.typeAccount = .LineaFija
            break
        default:
            break
        }
    }
    
    func setServiceID(serviceID: String) {
        self.serviceID = serviceID
    }
}
