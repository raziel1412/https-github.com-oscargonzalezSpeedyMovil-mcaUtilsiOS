//
//    BuyBagsTexts.swift
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation
import ObjectMapper


class BuyBagTexts : NSObject, Mappable{
    
    var buyBagsActualBalance : String?
    var buyBagsBuyHistory : String?
    var buyBagsChoosBags : String?
    var buyBagsChooseLine : String?
    var buyBagsCommercialDetails : String?
    var buyBagsCommercialDetailsAlert : String?
    var buyBagsConfirmTitle : String?
    var buyBagsDescription : String?
    var buyBagsGenericError : String?
    var buyBagsHeader : String?
    var buyBagsInsufficientBalance : String?
    var buyBagsMaxBagsText : String?
    var buyBagsNoBags : String?
    var buyBagsNoBagsLarge : String?
    var buyBagsRemember : String?
    var buyBagsSorry : String?
    var buyBagsSuccess : String?
    var buyBagsValidity : String?
    var buyBagsWarningBalance : String?
    var buyBagsYourDescription : String?
    
    override init() {
        
    }
    
    /// Función encargada de mapear el JSON correspondiente
    /// - parameter Map: Objeto de tipo Map
    required init?(map: Map) {
        super.init()
    }
    
    func mapping(map: Map)
    {
        buyBagsActualBalance <- map["buyBagsActualBalance"]
        buyBagsBuyHistory <- map["buyBagsBuyHistory"]
        buyBagsChoosBags <- map["buyBagsChoosBags"]
        buyBagsChooseLine <- map["buyBagsChooseLine"]
        buyBagsCommercialDetails <- map["buyBagsCommercialDetails"]
        buyBagsCommercialDetailsAlert <- map["buyBagsCommercialDetailsAlert"]
        buyBagsConfirmTitle <- map["buyBagsConfirmTitle"]
        buyBagsDescription <- map["buyBagsDescription"]
        buyBagsGenericError <- map["buyBagsGenericError"]
        buyBagsHeader <- map["buyBagsHeader"]
        buyBagsInsufficientBalance <- map["buyBagsInsufficientBalance"]
        buyBagsMaxBagsText <- map["buyBagsMaxBagsText"]
        buyBagsNoBags <- map["buyBagsNoBags"]
        buyBagsNoBagsLarge <- map["buyBagsNoBagsLarge"]
        buyBagsRemember <- map["buyBagsRemember"]
        buyBagsSorry <- map["buyBagsSorry"]
        buyBagsSuccess <- map["buyBagsSuccess"]
        buyBagsValidity <- map["buyBagsValidity"]
        buyBagsWarningBalance <- map["buyBagsWarningBalance"]
        buyBagsYourDescription <- map["buyBagsYourDescription"]
        
    }
}
