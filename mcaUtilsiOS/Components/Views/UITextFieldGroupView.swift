//
//  UITextFieldGroupView.swift
//  mcaUtilsiOS
//
//  Created by Ricardo Rodriguez De Los Santos on 2/25/19.
//  Copyright © 2019 Roberto. All rights reserved.
//

import UIKit
import Cartography

public class UITextFieldGroupView: UIView {

    public var labelTitle: UILabel = UILabel(frame: .zero)
    public var viewBorder: UIView = UIView(frame: .zero)
    public var textField : UITextField = UITextField(frame: .zero)
    public var image   : UIImageView = UIImageView(frame: .zero)
    public var mandatoryInformation : MandatoryInformation = MandatoryInformation(frame: .zero)
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupElements()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupElements() {
        
        labelTitle.font = UIFont(name: RobotoFontName.RobotoMedium.rawValue, size: CGFloat(12.0))
        labelTitle.textColor = institutionalColors.claroLightGrayColor
        
        textField.keyboardType = .numberPad
        
        viewBorder.borderColor = institutionalColors.claroButtonDetailGraphicSelect
        viewBorder.shadowRadius = 1
        viewBorder.shadowOpacity = 1
        viewBorder.shadowOffset.width = 0
        viewBorder.shadowOffset.height = 1
        viewBorder.borderWidth = 1
        viewBorder.shadowColor = institutionalColors.claroButtonDetailGraphicSelect
        
        self.addSubview(labelTitle)
        self.viewBorder.addSubview(textField)
        self.viewBorder.addSubview(image)
        self.viewBorder.addSubview(mandatoryInformation)
        self.addSubview(viewBorder)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        constrain(self, self.labelTitle, self.viewBorder) { (view, labelTitle, viewBorder) in
            
            labelTitle.top == view.top + 5
            labelTitle.leading == view.leading + 20
            labelTitle.trailing == view.trailing - 20
            labelTitle.height == 25
            
            viewBorder.top == labelTitle.bottom
            viewBorder.leading == view.leading + 20
            viewBorder.trailing == view.trailing - 20
            viewBorder.bottom == view.bottom - 5
            
        }
        
        constrain(self.viewBorder, self.labelTitle, self.image, textField, mandatoryInformation) { (view, labelTitle, img, text, mandatory) in
            
            
            text.leading == view.leading + 10
            text.trailing == view.trailing - 60
            text.centerY == view.centerY
            text.height == 40.0
            
            img.trailing == view.trailing - 10
            img.centerY == view.centerY
            img.width == 40.0
            img.height == 25.0
            
            mandatory.top == text.bottom + 4.0
            mandatory.height == 16.0
            mandatory.leading == text.leading
            mandatory.trailing == view.trailing
        }
    }
    
    public func setupContent(imageName: String?, titleTex: String? , text: String?, placeHolder : String?){
        image.image = mcaUtilsHelper.getImage(image: imageName!)
        textField.placeholder = placeHolder != nil ? placeHolder! : ""
        labelTitle.text = titleTex != nil ? titleTex! : ""
    }
    
}
