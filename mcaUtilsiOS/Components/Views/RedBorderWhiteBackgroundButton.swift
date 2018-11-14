//
//  RedBorderWhiteBackgroundButton.swift
//  MiClaro
//
//  Created by Fernando Rodriguez Minguet on 31/05/18.
//  Copyright © 2018 am. All rights reserved.
//

import UIKit

class RedBorderWhiteBackgroundButton: UIButton {

    init(textButton: String) {
        super.init(frame: UIScreen.main.bounds)
        self.backgroundColor = institutionalColors.claroWhiteColor
        self.setTitle(textButton, for: UIControlState.normal)
        self.titleLabel?.font = UIFont(name: RobotoFontName.RobotoBold.rawValue, size: 16.0)
        self.frame.size.height = 40;
        self.layer.cornerRadius = 0
        self.layer.borderWidth = 1
        self.layer.masksToBounds = false
        self.layer.borderColor = institutionalColors.claroRedColor.cgColor
        self.setTitleColor(institutionalColors.claroRedColor, for: UIControlState.normal)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.backgroundColor = institutionalColors.claroWhiteColor
        self.titleLabel?.font = UIFont(name: RobotoFontName.RobotoBold.rawValue, size: 16.0)
        self.frame.size.height = 40;
        self.layer.cornerRadius = 0
        self.layer.borderWidth = 1
        self.layer.masksToBounds = false
        self.layer.borderColor = institutionalColors.claroRedColor.cgColor
        self.setTitleColor(institutionalColors.claroRedColor, for: UIControlState.normal)
    }
    

}
