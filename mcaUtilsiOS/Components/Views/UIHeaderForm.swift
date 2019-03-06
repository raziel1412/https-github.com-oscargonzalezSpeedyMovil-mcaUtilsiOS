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
            label.font = UIFont(name: RobotoFontName.RobotoRegular.rawValue, size: CGFloat(20))
        }else{
            label.font = UIFont(name: RobotoFontName.RobotoRegular.rawValue, size: CGFloat(25))
        }
        label.textAlignment = .center
        label.textColor = institutionalColors.claroBlackColor
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        
        return label
    }()
    private var subTitle : UILabel = {
        let label = UILabel(frame: .zero)
        
        if UIScreen.main.bounds.width == 320{
            label.font = UIFont(name: RobotoFontName.RobotoRegular.rawValue, size: CGFloat(12))
        }else{
            label.font = UIFont(name: RobotoFontName.RobotoRegular.rawValue, size: CGFloat(20))
        }
        
        
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = institutionalColors.claroTextColor
        return label
    }()
    private var divisorView : UIImageView = {
        let dView = UIImageView(frame: .zero)
        dView.contentMode = .scaleAspectFit
        dView.clipsToBounds = true
        return dView
    }()
    
    public var titleFont : UIFont {
        get {
            return self.viewTitle.font
        }
        set(font) {
            self.viewTitle.font = font
        }
    }
    
    public var subtitleFont : UIFont {
        get {
            return self.subTitle.font
        }
        set(font) {
            self.subTitle.font = font
        }
    }
    
    public var hideDivisorView: Bool {
        
        get {
            return self.divisorView.isHidden
        }
        set(hide) {
            self.divisorView.isHidden = hide
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
        self.addSubview(divisorView)
        self.divisorView.backgroundColor = .lightGray
        self.divisorView.isHidden = true
        addConstraints()
    }
    
    private func addConstraints() {
        constrain(self, imageView, viewTitle, subTitle, divisorView) { (view, image, title, sTitle, divisor) in
            image.top == view.top
            image.centerX == view.centerX
            image.width == view.width * 0.32
            image.height == view.width * 0.32
            title.top == image.bottom + 8.0
            title.leading == view.leading +  22.0
            title.trailing == view.trailing - 21.0
            title.height == 30.0
            sTitle.top == title.bottom + 8.0
            sTitle.leading == view.leading + 32.0
            sTitle.trailing == view.trailing - 31.0
            sTitle.height == 44.0
            divisor.top == sTitle.bottom //+ 2.0
            divisor.centerX == title.centerX
            divisor.width == title.width * 0.45
            divisor.height == 1.0
        }
    }
    
    public func setupElements(imageName: String?, title: String?, subTitle: String?) {
        self.imageView.image = mcaUtilsHelper.getImage(image:imageName != nil ? imageName! : "" )
        self.viewTitle.text = title != nil ? title! : ""
        self.subTitle.text = subTitle != nil ? subTitle! : ""
        if subTitle == "" {
            constrain(viewTitle, self.subTitle) { (title, sTitle) in
                sTitle.top == title.bottom + 8.0
                sTitle.height == 0
            }
        }
    }
    
    
}
