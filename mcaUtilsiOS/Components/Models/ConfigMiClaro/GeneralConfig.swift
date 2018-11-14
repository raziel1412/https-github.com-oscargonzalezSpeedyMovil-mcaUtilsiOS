//
//	GeneralConfig.swift
//	Model file Generated using:
//	Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport
//	(forked from Ahmed-Ali's JSONExport)
//

import Foundation
import ObjectMapper

/// Clase relacionada con la definición del archivo de configuración
class GeneralConfig : NSObject, Mappable{
    
    var pantallaBienvenida : PantallaBienvenida?
    var rRSS : RRSS?
    var assetsBase : AssetsBase?
    var bottomMenu : BottomMenu?
    var cachedServices : CachedService?
    var click2BuyConfig : Click2BuyConfig?
    var config : Config?
    var country : Country?
    var help : HelpConfig?
    var helpSDK : HelpSDK?
    var homePromo : HomePromo?
    var modulesConfiguration : ModulesConfiguration?
    var newUpdateAvailable : NewUpdateAvailable?
    var paidServices : [PaidService]?
    var permissions : PermissionConfig?
    var pinMessageRules : PinMessageRule?
    var rules : Rule?
    var sdk : [SDK]?
    var sideNavigationMenu : BottomMenu?
    var termsAndConditions : AssetsBase?
    var translations : Translation?
    var consumptionInternationalFlags: ConsumptionInternationalFlags?
    var helpOnlineDynamicOptions: HelpOnlineDynamicOptions?
    var webViews : [WebViews]?

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
        pantallaBienvenida <- map["PantallaBienvenida"]
        rRSS <- map["RRSS"]
        assetsBase <- map["assetsBase"]
        bottomMenu <- map["bottomMenu"]
        cachedServices <- map["cachedServices"]
        click2BuyConfig <- map["click2BuyConfig"]
        config <- map["config"]
        country <- map["country"]
        help <- map["help"]
        helpSDK <- map["helpSDK"]
        homePromo <- map["homePromo"]
        modulesConfiguration <- map["modulesConfiguration"]
        newUpdateAvailable <- map["newUpdateAvailable"]
        paidServices <- map["paidServices"]
        permissions <- map["permissions"]
        pinMessageRules <- map["pinMessageRules"]
        rules <- map["rules"]
        sdk <- map["sdk"]
        sideNavigationMenu <- map["sideNavigationMenu"]
        termsAndConditions <- map["termsAndConditions"]
        translations <- map["translations"]
        consumptionInternationalFlags <- map["consumptionInternationalFlags"]
        helpOnlineDynamicOptions <- map["helpOnlineDynamicOptions"]
        webViews <- map["webViews"]
    }
}
