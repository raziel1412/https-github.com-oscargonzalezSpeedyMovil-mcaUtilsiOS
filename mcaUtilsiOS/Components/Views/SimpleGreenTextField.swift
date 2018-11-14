//
//  SimpleGreenTextField.swift
//  MiClaro
//
//  Created by Mauricio Javier Perez Flores on 7/27/17.
//  Copyright © 2017 am. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

/// Esta clase especializa un UITextField para tener la funcionalidad de placeholder deslizable hacia arriba, gracias a que hereda del pod SkyFloatingLabelTextField
class SimpleGreenTextField: SkyFloatingLabelTextField {
    
    init(text: String, placeholder: String) {
        super.init(frame: UIScreen.main.bounds)

        self.placeholder = placeholder
        self.titleLabel?.font = UIFont(name: RobotoFontName.RobotoRegular.rawValue, size: 14.0)
        self.lineColor = institutionalColors.claroLightGrayColor
        self.placeholderColor = institutionalColors.claroBlackColor//claroLightGrayColor
        self.tintColor = institutionalColors.claroBlueColor
        self.selectedLineColor = institutionalColors.claroBlueColor
        self.selectedTitleColor = institutionalColors.claroLightGrayColor
        self.lineHeight = 1
        self.selectedLineHeight = 2
        self.title = text
        self.titleColor = institutionalColors.claroTextColor
        self.font = UIFont(name: RobotoFontName.RobotoRegular.rawValue, size: 14.0);
        self.titleFont = UIFont(name: RobotoFontName.RobotoRegular.rawValue, size: 14.0)!;
        self.delegate = self as? UITextFieldDelegate
        
        self.titleFormatter = { (text: String) -> String in
            return text
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
