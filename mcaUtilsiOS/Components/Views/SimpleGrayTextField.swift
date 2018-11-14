//
//  SimpleGrayTextField.swift
//  MiClaro
//
//  Created by Fernando Rodriguez Minguet on 31/05/18.
//  Copyright © 2018 am. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class SimpleGrayTextField: SkyFloatingLabelTextField {
    
    var customFont : UIFont {
        get {
            return self.customFont
        }
        set(font) {
            self.font = font
        }
    }

    init(text: String, placeholder: String) {
        super.init(frame: UIScreen.main.bounds)
        setup(text: text, placeholder: placeholder)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup(text: "", placeholder: "");
    }

    override init(frame: CGRect) {
        super.init(frame: frame);
        setup(text: "", placeholder: "")
    }
    
    func setup(text: String, placeholder: String) {
        self.placeholder = placeholder
        self.placeholderFont = UIFont(name: RobotoFontName.RobotoRegular.rawValue, size: 14.0);
        self.titleFont = UIFont(name: RobotoFontName.RobotoRegular.rawValue, size: 10.0) ?? .systemFont(ofSize: 10);

        self.titleLabel?.font = UIFont(name: RobotoFontName.RobotoRegular.rawValue, size: 14.0)
        self.font = UIFont(name: RobotoFontName.RobotoRegular.rawValue, size: 14.0);


        self.lineColor = institutionalColors.claroLightGrayColor
        self.placeholderColor = institutionalColors.claroBlackColor//claroLightGrayColor
        self.tintColor = institutionalColors.claroLightGrayColor
        self.selectedLineColor = institutionalColors.claroLightGrayColor
        self.selectedTitleColor = institutionalColors.claroBlackColor
        self.titleColor = institutionalColors.claroBlackColor
        self.placeholderColor = institutionalColors.claroBlackColor
        self.lineHeight = 1
        self.selectedLineHeight = 2
        self.title = text

        self.delegate = self as? UITextFieldDelegate

        self.titleFormatter = { (text: String) -> String in
            return text
        }
    }

    func setupSecurityEye() {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        button.setImage(UIImage(named: "icon_vercontra_inac_input"), for: .normal)
        button.setImage(UIImage(named: "icon_vercontra_input"), for: .selected)
        button.addTarget(self, action: #selector(protectUnprotect(_:)), for: .touchUpInside)
        self.isSecureTextEntry = true
        self.rightView = button
        self.rightViewMode = .always
    }
    
    func protectUnprotect(_ sender: Any) {
        self.isSecureTextEntry = !self.isSecureTextEntry
        if let selected = (sender as? UIButton)?.isSelected {
            (sender as? UIButton)?.isSelected = !selected
        }
    }
    
}

