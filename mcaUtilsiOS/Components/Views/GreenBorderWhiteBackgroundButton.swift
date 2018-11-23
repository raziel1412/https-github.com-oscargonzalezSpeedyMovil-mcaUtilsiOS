//
//  GreenBorderWhiteBackgroundButton.swift
//  MiClaro
//
//  Created by Mauricio Javier Perez Flores on 8/1/17.
//  Copyright © 2017 am. All rights reserved.
//

import UIKit

/// Esta clase especializa un UIButton para permitirle que tenga el L&F de Mi Claro constante. Borde de color azul, fuente RobotoRegular 16pt y bordes redondeados
public class GreenBorderWhiteBackgroundButton: UIButton {

    init(textButton: String) {
        super.init(frame: UIScreen.main.bounds)
        
        self.backgroundColor = institutionalColors.claroWhiteColor
        self.setTitle(textButton, for: UIControlState.normal)
        self.titleLabel?.font = UIFont(name: RobotoFontName.RobotoBold.rawValue, size: 16.0)
        self.frame.size.height = 40;
        self.layer.cornerRadius = 0
        self.layer.borderWidth = 1
        self.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowRadius = 0
        self.layer.shadowOpacity = 1
        self.layer.masksToBounds = false
        self.layer.borderColor = institutionalColors.claroBlueColor.cgColor
        self.setTitleColor(institutionalColors.claroBlueColor, for: UIControlState.normal)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
