//
//  BlackBodyLabel.swift
//  MiClaro
//
//  Created by Mauricio Javier Perez Flores on 8/3/17.
//  Copyright © 2017 am. All rights reserved.
//

import UIKit

/// Esta clase especializa un UILabel para tener L&F de texto de contenido en color negro con fuente fija y tamaño fijo
public class BlackBodyLabel: UILabel {

    init() {
        super.init(frame: CGRect.zero)
        self.textAlignment = .center
        self.numberOfLines = 0
        self.font = UIFont(name: RobotoFontName.RobotoRegular.rawValue, size: CGFloat(12))
        self.textColor = institutionalColors.claroBlackColor
        self.backgroundColor = UIColor.clear
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
