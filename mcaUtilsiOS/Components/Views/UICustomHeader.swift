//
//  UIHeaderForm3.swift
//  mcaUtilsiOS
//
//  Created by Ricardo Rodriguez De Los Santos on 2/21/19.
//  Copyright © 2019 Roberto. All rights reserved.
//

import UIKit
import Cartography

/**
 View para visualizar el encabezado con un titulo en la parte de arriba y centrado, imagen debajo del titulo y
 subtitulo bajo la imagen.
            viewTitle
            imageView
            subTitle
 */
public class UICustomHeader: UIView {

    public var viewTitle : UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont(name: RobotoFontName.RobotoRegular.rawValue, size: CGFloat(14))
        label.textAlignment = .center
        label.textColor = institutionalColors.claroTextColor
        return label
    }()
    
    public var imageView : UIImageView = {
        let iView = UIImageView(frame: .zero)
        iView.contentMode = .scaleAspectFit
        iView.clipsToBounds = true
        return iView
    }()
    
    public var subTitle : UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont(name: RobotoFontName.RobotoRegular.rawValue, size: CGFloat(14))
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.textColor = institutionalColors.claroTextColor
        return label
    }()
    
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setupElements()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setupElements() {
        self.addSubview(imageView)
        self.addSubview(viewTitle)
        self.addSubview(subTitle)
        addConstraints()
    }
    
    public func addConstraints() {
        constrain(self, imageView, viewTitle, subTitle) { (view, image, title, sTitle) in
            
            image.centerY == view.centerY
            image.width == view.height * 0.5//0.8
            image.height == view.height * 0.5//0.8
            image.centerX == view.centerX
            
            title.bottom == image.top - 10
            title.leading == view.leading + 40
            title.trailing == view.trailing - 40
            title.height == 22.0
            
            sTitle.top == image.bottom //+ 2.0
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
