//
//	PaidService.swift
//	Model file Generated using:
//	Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport
//	(forked from Ahmed-Ali's JSONExport)
//

import Foundation
import ObjectMapper

/// Clase relacionada con la definición del archivo de configuración
class PaidService : NSObject, Mappable{
    
    var pago : Pago?
    var recarga : Pago?
    
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
        pago <- map["pago"]
        recarga <- map["recarga"]
    }
}
