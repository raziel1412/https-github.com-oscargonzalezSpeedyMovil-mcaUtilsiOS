//
//  InstructionLabel.swift
//  MiClaro
//
//  Created by Mauricio Javier Perez Flores on 8/1/17.
//  Copyright © 2017 am. All rights reserved.
//

import UIKit
import Cartography

/// Esta clase especializa un UILabel para permitirle tener apariencia visual de titulo centrado.
public class InstructionLabel: UILabel {

    var contextVC: UIView!

    init(context: UIView, text: String) {
        super.init(frame: UIScreen.main.bounds)
        self.contextVC = context
        self.text = text
        self.textAlignment = .center
        self.font = UIFont(name: RobotoFontName.RobotoRegular.rawValue, size: CGFloat(16));
        self.numberOfLines = 0
        self.textColor = institutionalColors.claroTextColor
        self.sizeToFit()
    }
    
    //For init with the small text
    init(text: String, fontSize: CGFloat, alignText: NSTextAlignment) {
        super.init(frame: UIScreen.main.bounds)
        self.text = text
        self.textAlignment = alignText
        self.font = UIFont(name: RobotoFontName.RobotoRegular.rawValue, size: fontSize);
        self.numberOfLines = 0
        self.textColor = institutionalColors.claroTextColor
        self.sizeToFit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func setPosition() {
     contextVC.addSubview(self)
        constrain(contextVC, self) { (view1, view2) in
            view2.width   == (view1.width) * 0.80
            view2.centerX == view1.centerX
            view2.top ==  view1.top + 20//104
            view2.height == view1.height * 0.15
        }
    }

}
