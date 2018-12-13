//
//  UITextFieldGroupPhone.swift
//  MiClaro
//
//  Created by Fernando Rodriguez Minguet on 07/06/18.
//  Copyright © 2018 am. All rights reserved.
//

import UIKit
import Cartography

public class UITextFieldGroupPhone : UIView {
    
    public var textField : SimpleGrayTextField = SimpleGrayTextField(text: "", placeholder: "")
    public var countryCode : UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont(name: RobotoFontName.RobotoBold.rawValue, size: 14.0)
        label.textAlignment = .center
        return label
    }()
    var image   : UIImageView = UIImageView(frame: .zero)
    var mandatoryInformation : MandatoryInformation = MandatoryInformation(frame: .zero)
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setupElements()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupElements() {
        self.addSubview(textField)
        self.addSubview(image)
        self.addSubview(countryCode)
        self.addSubview(mandatoryInformation)
        setupConstraints()
    }
    
    private func setupConstraints() {
        constrain(self, self.image, textField, countryCode, mandatoryInformation) { (view, img, text, label, mandatory) in
            
            img.leading == view.leading
            img.bottom == label.bottom
            img.width == 22.0
            img.height == 22.0
            
            label.leading == img.trailing + 5.0
            label.bottom == text.bottom
            label.width == 50.0
            label.height == 30.0
            
            text.leading == label.trailing + 8.0
            text.trailing == view.trailing
            text.top == view.top
            text.height == 40.0
            
            mandatory.top == text.bottom + 4.0
            mandatory.height == 16.0
            mandatory.leading == text.leading
            mandatory.trailing == view.trailing
        }
    }
    
    public func setupContent(imageName: String?, text: String?, placeHolder : String?, countryCodeText : String?){
        image.image =  mcaUtilsHelper.getImage(image: imageName!)
        textField.title = text != nil ? text! : ""
        textField.placeholder = placeHolder != nil ? placeHolder! : ""
        countryCode.text = countryCodeText != nil ? countryCodeText! : ""
    }
    
    public func changeFont(font: UIFont) {
        textField.customFont = font
    }
}
