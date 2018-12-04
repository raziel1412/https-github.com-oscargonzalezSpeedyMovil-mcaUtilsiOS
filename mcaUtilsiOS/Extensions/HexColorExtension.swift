//
//  HexColorExtension.swift
//  MiClaro
//
//  Created by Mauricio Javier Perez Flores on 7/27/17.
//  Copyright © 2017 am. All rights reserved.
//

import Foundation
import UIKit

/// Extension UIColor
public extension UIColor{
    
    /// Inicialización
    /// - parameter rgb : UInt
    /// - parameter alphaVal : CGFloat
    convenience init(rgb: UInt, alphaVal: CGFloat) {
        self.init(
            red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgb & 0x0000FF) / 255.0,
            alpha: alphaVal
        )
    }
}
