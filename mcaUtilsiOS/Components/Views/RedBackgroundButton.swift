//
//  RedBackgroundButton.swift
//  MiClaro
//
//  Created by Mauricio Javier Perez Flores on 7/31/17.
//  Copyright © 2017 am. All rights reserved.
//

import UIKit

/// Esta clase especializa un UIButton para permitirle que tenga el L&F de Mi Claro constante. Background Rojo, fuente RobotoRegular 18pt y bordes redondeados
public class RedBackgroundButton: UIButton {
    
    public init(textButton: String) {
        super.init(frame: UIScreen.main.bounds)
        
        self.backgroundColor = institutionalColors.claroRedColor
        self.setTitle(textButton, for: UIControlState.normal)
        self.layer.cornerRadius = 0
        self.titleLabel?.font = UIFont(name: RobotoFontName.RobotoRegular.rawValue, size: 18.0)
        self.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.15).cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowRadius = 0
        self.layer.shadowOpacity = 0.6
        self.layer.masksToBounds = false
        self.setTitleColor(institutionalColors.claroNavTitleColor, for: UIControlState.normal)
        self.frame.size.height = 40;
    }
    
    public init(textButton: String, colorBorder: UIColor, thickness: CGFloat, radiusBorder: CGFloat) {
        super.init(frame: UIScreen.main.bounds)
        self.layer.cornerRadius = radiusBorder
        self.layer.borderWidth = thickness
        self.layer.borderColor = colorBorder.cgColor
        self.backgroundColor = UIColor.clear//institutionalColors.claroRedColor
        self.setTitle(textButton, for: UIControlState.normal)
        self.layer.cornerRadius = 5
        self.titleLabel?.font = UIFont(name: RobotoFontName.RobotoRegular.rawValue, size: 18.0)
        self.setTitleColor(institutionalColors.claroRedColor, for: UIControlState.normal)
        self.frame.size.height = 40;
    }
    
    public func addDecorationButton(nameImage: String, color: UIColor) {
        let imgIcon = UIImageView()
        imgIcon.frame = CGRect(x: 0, y: 0, width: 20.0, height: self.frame.height)
        imgIcon.image = UIImage(named: nameImage)
        imgIcon.contentMode = .scaleAspectFit
        imgIcon.center = CGPoint(x: self.frame.width - 20.0, y: self.frame.height / 2)
        self.addSubview(imgIcon)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
