//
//  UIHeaderForm.swift
//  MiClaro
//
//  Created by Fernando Rodriguez Minguet on 31/05/18.
//  Copyright © 2018 am. All rights reserved.
//

import UIKit
import Cartography

public class UIHeaderForm: UIView {

    private var imageView : UIImageView = {
        let iView = UIImageView(frame: .zero)
        iView.contentMode = .scaleAspectFit
        iView.clipsToBounds = true
        return iView
    }()
    private var viewTitle : UILabel = {
        let label = UILabel(frame: .zero)
        
        if UIScreen.main.bounds.width == 320{
            label.font = UIFont(name: RobotoFontName.RobotoRegular.rawValue, size: CGFloat(16))
        }else{
            label.font = UIFont(name: RobotoFontName.RobotoRegular.rawValue, size: CGFloat(20))
        }
        label.textAlignment = .center
        label.textColor = institutionalColors.claroBlackColor
        return label
    }()
    private var subTitle : UILabel = {
        let label = UILabel(frame: .zero)
        
        if UIScreen.main.bounds.width == 320{
            label.font = UIFont(name: RobotoFontName.RobotoRegular.rawValue, size: CGFloat(12))
        }else{
            label.font = UIFont(name: RobotoFontName.RobotoRegular.rawValue, size: CGFloat(15))
        }
        
        
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = institutionalColors.claroTextColor
        return label
    }()
    
    var subtitleFont : UIFont {
        get {
            return self.subtitleFont
        }
        set(font) {
            self.subTitle.font = font
        }
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupElements()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupElements() {
        self.addSubview(imageView)
        self.addSubview(viewTitle)
        self.addSubview(subTitle)
        addConstraints()
    }
    
    private func addConstraints() {
        constrain(self, imageView, viewTitle, subTitle) { (view, image, title, sTitle) in
            image.top == view.top
            image.centerX == view.centerX
            image.width == view.width * 0.32
            image.height == view.width * 0.32
            title.top == image.bottom + 8.0
            title.leading == view.leading +  22.0
            title.trailing == view.trailing - 21.0
            title.height == 24.0
            sTitle.top == title.bottom + 8.0
            sTitle.leading == view.leading + 32.0
            sTitle.trailing == view.trailing - 31.0
            sTitle.height == 44.0
        }
    }
    
    public func setupElements(imageName: String?, title: String?, subTitle: String?) {
        self.imageView.image = UIImage(named: imageName != nil ? imageName! : "" )
        self.viewTitle.text = title != nil ? title! : ""
        self.subTitle.text = subTitle != nil ? subTitle! : ""
    }
    
    
}
