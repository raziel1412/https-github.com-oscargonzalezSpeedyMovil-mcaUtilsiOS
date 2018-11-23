//
//  BlackTitleLabel.swift
//  MiClaro
//
//  Created by Mauricio Javier Perez Flores on 8/9/17.
//  Copyright © 2017 am. All rights reserved.
//

import Foundation
import UIKit

/// Esta clase especializa un UILabel para tener L&F de titulo en color negro con fuente fija y tamaño fijo
public class BlackTitleLabel: UILabel {
    
    init() {
        
        super.init(frame: CGRect.zero)
        self.textColor = institutionalColors.claroTitleColor
        self.font = UIFont(name: RobotoFontName.RobotoRegular.rawValue, size: CGFloat(20));//16
        self.numberOfLines = 0
        self.textAlignment = .center
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
}
