//
//	Node.swift
//	Model file Generated using:
//	Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport
//	(forked from Ahmed-Ali's JSONExport)
//

import Foundation
import ObjectMapper

/// Clase relacionada con la definición del archivo de configuración
class Node : NSObject, Mappable{
    
    var code : String?
    var id : String?
    var image : String?
    var order : String?
    var status : String?
    var text : String?
    var group : String?
    var childs : [Childs]?
    
    var isExpanded = false

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
        code <- map["code"]
        id <- map["id"]
        image <- map["image"]
        order <- map["order"]
        status <- map["status"]
        text <- map["text"]
        group <- map["group"]
        childs <- map["childs"]
    }
}
