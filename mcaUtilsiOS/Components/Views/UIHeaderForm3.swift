//
//  UIHeaderForm3.swift
//  mcaUtilsiOS
//
//  Created by Benjamin Velazquez Valtierra on 3/11/19.
//  Copyright © 2019 Roberto. All rights reserved.
//

import UIKit
import Cartography

public class UIHeaderForm3: UIView {
    
    var heightTitle: CGFloat = 44
    var heightSubTitle: CGFloat = 47

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
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = institutionalColors.claroRedColor
        return label
    }()
    private var subTitle : UILabel = {
        let label = UILabel(frame: .zero)
        
        if UIScreen.main.bounds.width == 320{
            label.font = UIFont(name: RobotoFontName.RobotoRegular.rawValue, size: CGFloat(12))
        }else{
            label.font = UIFont(name: RobotoFontName.RobotoRegular.rawValue, size: CGFloat(20))
        }
        
        label.textAlignment = .center
        label.textColor = institutionalColors.claroTextColor
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        
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
    
    }
    
    private func addConstraints() {
        constrain(self, imageView, viewTitle, subTitle, divisorView) { (view, image, title, sTitle, divisor) in
            image.top == view.top
            image.centerX == view.centerX
            image.width == view.width * 0.32
            image.height == view.width * 0.32
            title.top == image.bottom + 8.0
            title.leading == view.leading +  17.0
            title.trailing == view.trailing - 17.0
            title.height == heightTitle
            sTitle.top == title.bottom + 8.0
            sTitle.leading == view.leading + 20.0
            sTitle.trailing == view.trailing - 20.0
            sTitle.height == heightSubTitle
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
        
        heightTitle = heightForView(text: self.viewTitle.text!, font: self.viewTitle.font, width: self.frame.width - 34)
        heightSubTitle = heightForView(text: self.subTitle.text!, font: self.subTitle.font, width: self.frame.width - 40)
        
        addConstraints()
        
        
    }
    
    public func colorTextSetupElements(colorTitle: UIColor?, colorSubtitle: UIColor?){
        self.viewTitle.textColor = colorTitle != nil ? colorTitle : institutionalColors.claroRedColor
        self.subTitle.textColor = colorSubtitle != nil ? colorSubtitle : institutionalColors.claroTextColor
    }
    
    func heightForView(text:String, font:UIFont, width:CGFloat) -> CGFloat{
        
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        label.sizeToFit()
        
        return label.frame.height
    }

}
