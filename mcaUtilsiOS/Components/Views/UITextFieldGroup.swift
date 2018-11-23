//
//  UITextFieldGroup.swift
//  MiClaro
//
//  Created by Fernando Rodriguez Minguet on 04/06/18.
//  Copyright © 2018 am. All rights reserved.
//

import UIKit
import Cartography

public class UITextFieldGroup : UIView {
    
    var textField : SimpleGrayTextField = SimpleGrayTextField(text: "", placeholder: "")
    var image   : UIImageView = UIImageView(frame: .zero)
    var mandatoryInformation : MandatoryInformation = MandatoryInformation(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupElements()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupElements() {
        self.addSubview(textField)
        self.addSubview(image)
        self.addSubview(mandatoryInformation)
        setupConstraints()
    }
    
    private func setupConstraints() {
        constrain(self, self.image, textField, mandatoryInformation) { (view, img, text, mandatory) in
            img.leading == view.leading
            img.bottom == text.bottom
            img.width == 22.0
            img.height == 22.0
            
            text.leading == view.leading + 22.0 + 8.0
            text.trailing == view.trailing
            text.top == view.top
            text.height == 40.0
            
            mandatory.top == text.bottom + 4.0
            mandatory.height == 16.0
            mandatory.leading == text.leading
            mandatory.trailing == view.trailing
        }
    }
    
    func setupContent(imageName: String?, text: String?, placeHolder : String?){
        image.image = UIImage(named: imageName!)
        textField.title = text != nil ? text! : ""
        textField.placeholder = placeHolder != nil ? placeHolder! : ""
    }
    
    func changeFont(font: UIFont) {
        textField.customFont = font
    }
    
}



