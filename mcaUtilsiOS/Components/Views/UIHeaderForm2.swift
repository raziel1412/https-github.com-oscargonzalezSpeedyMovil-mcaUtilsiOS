//
//  UIHeaderForm2.swift
//  MiClaro
//
//  Created by Jonathan Abimael Cruz Orozco on 31/05/18.
//  Copyright © 2018 am. All rights reserved.
//

import UIKit
import Cartography

public class UIHeaderForm2: UIView {
    
    private var imageView : UIImageView = {
        let iView = UIImageView(frame: .zero)
        iView.contentMode = .scaleAspectFit
        iView.clipsToBounds = true
        return iView
    }()
    private var viewTitle : UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont(name: RobotoFontName.RobotoRegular.rawValue, size: CGFloat(19))
        label.textAlignment = .left
        label.textColor = institutionalColors.claroBlackColor
        return label
    }()
    private var subTitle : UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont(name: RobotoFontName.RobotoRegular.rawValue, size: CGFloat(14))
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
//        label.adjustHeighToFit()
        label.textAlignment = .left
        label.textColor = institutionalColors.claroTextColor
        return label
    }()
    
    
    override init(frame: CGRect) {
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
            image.centerY == view.centerY
            image.width == view.height * 0.5//0.8
            image.height == view.height * 0.5//0.8
            image.leading == view.leading + 10
            title.top == image.top
            title.leading == image.trailing + 8.0
            title.trailing == view.trailing - 8.0
            title.height == 22.0
            sTitle.top == title.bottom //+ 2.0
            sTitle.leading == title.leading
            sTitle.trailing == title.trailing
            sTitle.height == 40.0
        }
    }
    
    public func setupElements(imageName: String?, title: String?, subTitle: String?) {
        self.imageView.image = mcaUtilsHelper.getImage(image:imageName != nil ? imageName! : "" )
        self.viewTitle.text = title != nil ? title! : ""
        self.subTitle.text = subTitle != nil ? subTitle! : ""
    }
    
    
}

