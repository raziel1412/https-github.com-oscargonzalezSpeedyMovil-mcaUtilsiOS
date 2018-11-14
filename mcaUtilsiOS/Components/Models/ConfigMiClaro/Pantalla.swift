//
//  Pantallas.swift
//  MiClaro
//
//  Created by Fernando Rodriguez Minguet on 07/03/18.
//  Copyright © 2018 am. All rights reserved.
//

import Foundation
import ObjectMapper

/// Clase creada para mapear el elemento de Pantalla del JSON de las pantallas de bienvenida, obtenidas desde el archivo de configuración.
class Pantalla : Mappable {
    
    /// Título para el botón
    var boton : String = ""
    /// Contenido del pié de página
    var footer : String = ""
    /// Subtitulo de la pantalla de bienvenida
    var subtitulo : String = ""
    /// Titulo de la pantalla de bienvenida
    var titulo : String = ""
    /// URL del fondo de pantalla
    var wallpaper : String = ""
    /// Índice de la pantalla
    var index : Int = 0
    
    /// Inicializador de la clase
    required init?(map: Map) {
        
    }
    /// Función encargada de mapear el JSON correspondiente
    /// - parameter Map: Objeto de tipo Map
    func mapping(map: Map) {
        boton <- map["Boton"]
        footer <- map["Footer"]
        subtitulo <- map["Subtitulo"]
        titulo <- map["Titulo"]
        wallpaper <- map["Wallpaper"]
    }
}
