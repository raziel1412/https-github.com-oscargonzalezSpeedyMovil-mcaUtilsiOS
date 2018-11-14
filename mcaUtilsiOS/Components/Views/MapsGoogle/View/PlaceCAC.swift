//
//  MapsGoogle.swift
//  MiClaro
//
//  Created by Jonathan Abimael Cruz Orozco on 23/08/17.
//  Copyright © 2017 am. All rights reserved.
//

import UIKit
import GoogleMaps

/// Clase que representa un marcador de google maps listo para ser desplegado en pantalla
class PlaceCAC: GMSMarker {
    var urlImage: String = ""
    var imageCAC: UIImage!
    
    /// Constructor del marcador para un centro de atención
    /// - Parameter cacInfo: Objeto con los datos para la creación de un marcador
    init(cacInfo: CacInfo) {
        super.init()
        self.title = cacInfo.name
        self.position = CLLocationCoordinate2D(latitude: Double(cacInfo.coordX!)!,longitude: Double(cacInfo.coordY!)!)
        let addressAndHour: String! = "\(cacInfo.address!)\n\n\(cacInfo.openingHours!)"
        self.snippet = addressAndHour
        self.urlImage = (cacInfo.urlImage ?? "")!
    }
    
    /// Constructor del marcador para un centro de atención
    /// - Parameter cacInfo: Objeto con los datos para la creación de un marcador
    /// - Parameter image: Imagen a mostrar en la ventana de detalle de un marcador
    init(cacInfo: CacInfo, image: UIImage) {
        super.init()
        self.title = cacInfo.name
        self.position = CLLocationCoordinate2D(latitude: Double(cacInfo.coordX!)!,longitude: Double(cacInfo.coordY!)!)
        let addressAndHour: String! = "\(cacInfo.address!)\n\n\(cacInfo.openingHours!)"
        self.snippet = addressAndHour
        self.urlImage = cacInfo.urlImage!
        self.imageCAC = image
    }
}
