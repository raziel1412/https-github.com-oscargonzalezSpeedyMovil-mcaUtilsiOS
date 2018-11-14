//
//  ToolTipElement.swift
//  MiClaro
//
//  Created by Fernando Rodriguez Minguet on 06/06/18.
//  Copyright © 2018 am. All rights reserved.
//


import UIKit
import Cartography

class ToolTipElement : UIView {
    
    private var titleLabel : UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont(name: RobotoFontName.RobotoBold.rawValue, size: 14.0)
        label.textAlignment = .center
        return label
    }()
    
    private var descriptionLabel : UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont(name: RobotoFontName.RobotoRegular.rawValue, size: 14.0)
        label.textAlignment = .center
        return label
    }()
    
    private var imageView : UIImageView =  {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    var descriptionFont : UIFont {
        get {
            return self.descriptionFont
        }
        set(font) {
            self.descriptionLabel.font = font
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupElements()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupElements() {
        [titleLabel, descriptionLabel, imageView].forEach({
            self.addSubview($0)
        })
        setupConstraints()
    }
    private func setupConstraints() {
        constrain(self, titleLabel, descriptionLabel, imageView) { (view, title, description, image) in
            title.top == view.top
            title.leading == view.leading + 8.0
            title.trailing == view.trailing - 8.0
            title.height == 16.0
            
            description.top == title.bottom + 8.0
            description.leading == view.leading + 8.0
            description.trailing == view.trailing - 8.0
            description.height == 16.0
            
            image.top == description.bottom + 16.0
            image.leading == view.leading + 8.0
            image.trailing == view.trailing - 8.0
            image.height == (view.width / 1.5)
            image.centerX == view.centerX
        }
        
    }
    
    func setupContent(title: String?, description: String?, image: String?) {
        titleLabel.text = title
        descriptionLabel.text = description
        if image != nil {
            imageView.image = UIImage(named: image!)
        }
    }
    
}

