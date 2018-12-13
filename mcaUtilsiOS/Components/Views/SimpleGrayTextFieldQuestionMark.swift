//
//  SimpleGrayTextFieldQuestionMark.swift
//  MiClaro
//
//  Created by Fernando Rodriguez Minguet on 31/05/18.
//  Copyright © 2018 am. All rights reserved.
//

import UIKit
import Foundation

/// Esta clase es similar a SimpleGreenTextField, pero agrega la capacidad de mostrar un icono representando mas ayuda
public class SimpleGrayTextFieldQuestionMark: SimpleGrayTextField {
    private var btnView : UIButton?;
    
    public var action = {}
    
    public override init(text: String, placeholder: String) {
        super.init(text: text, placeholder: placeholder);
        
        setup();
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
        setup();
    }

    public override init(frame: CGRect) {
        super.init(frame: frame);
        setup()
    }

    private func setup() {
        self.rightViewMode = .always;
        
        let dim = 32;
        
        let imgNormal = mcaUtilsHelper.getImage(image: "icon_question_input")
        let imgActive = mcaUtilsHelper.getImage(image: "icon_question_input")
        btnView = UIButton(type: UIButtonType.custom);
        
        btnView?.setImage(imgNormal, for: UIControlState.normal);
        btnView?.setImage(imgActive, for: UIControlState.highlighted);
        btnView?.frame = CGRect(x: 0, y: 0, width: dim, height: dim);
        btnView?.addTarget(self, action: #selector(cmdButton_OnClick(sender:)), for: .touchUpInside);
        self.rightView = btnView;

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
    }
    
    public func cmdButton_OnClick(sender : UIButton) {
        action();
    }
    
    public func hideQuestionMark() {
        self.rightView = nil;
    }
    
    public func showQuestionMark() {
        setup();
    }
}
