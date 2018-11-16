//
//  File.swift
//  MiClaro
//
//  Created by Jonathan Abimael Cruz Orozco on 09/07/18.
//  Copyright © 2018 am. All rights reserved.
//

import Foundation

class CardsSummaryModel {
    var typeAccount: TypeAccountService = .None
    var nameService: String = ""
    var dateVigency: String = ""
    var amount: Float = 0.0
    
    func setTypeAccount(typeAccount: TypeAccountService) {
        self.typeAccount = typeAccount
    }
    
    func setNameService(nameService: String){
        self.nameService = nameService
    }
    
    func setDateVigency(date: String) {
        self.dateVigency = date
    }
    
    func setAmount(amount: Float) {
        self.amount = amount
    }
    
}
