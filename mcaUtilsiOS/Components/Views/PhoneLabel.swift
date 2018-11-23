//
//  PhoneLabel.swift
//  MiClaro
//
//  Created by Mauricio Javier Perez Flores on 8/2/17.
//  Copyright © 2017 am. All rights reserved.
//

import UIKit
import Cartography

/// Esta clase especializa un UILabel para permitirle tener apariencia constante de etiqueta de teléfonos.
public class PhoneLabel: UILabel {
    
    init(text: String) {
        super.init(frame: CGRect.zero)
        self.text = text
        self.textAlignment = .right
        self.numberOfLines = 0
        self.textColor = institutionalColors.claroBlackColor
        self.font = UIFont(name: RobotoFontName.RobotoBold.rawValue, size: CGFloat(14))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
