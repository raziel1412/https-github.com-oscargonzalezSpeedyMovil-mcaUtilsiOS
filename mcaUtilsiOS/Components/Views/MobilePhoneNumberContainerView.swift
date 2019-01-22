//
//  MobilePhoneNumberContainerView.swift
//  MiClaro
//
//  Created by Mauricio Javier Perez Flores on 8/1/17.
//  Copyright © 2017 am. All rights reserved.
//

import UIKit
import Cartography
//import mcaManageriOS

/// Este protocolo permite enviar texto
public protocol MobilePhoneNumberOnChangeDelegate {
    func MobilePhoneChangeData(texto: String);
}

/// Esta clase especializa un UIView para permitirle tener apariencia de ventana especial para la captura de números telefónicos.
public class MobilePhoneNumberContainerView: UIView, UITextFieldDelegate {

    public var mobileTextfield: SimpleGrayTextField!
    public var phoneLabel: PhoneLabel!
    private var iconImage : UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.image = mcaUtilsHelper.getImage(image: "icon_telefono_input")
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        return imageView
    }()
    private var mandatory : MandatoryInformation = {
        let view = MandatoryInformation(frame: .zero)
        return view
    }()
    public var delegate : MobilePhoneNumberOnChangeDelegate?;
    
    /// Params
    /// addPrepaidNumber (conf?.translations?.data?.addService?.addPrepaidNumber) ?? "")
    /// phoneCountryCode (SessionSingleton.sharedInstance.getGeneralConfig()?.country?.phoneCountryCode)
    public init(addPrepaidNumber: String, phoneCountryCode: String?) {
        super.init(frame: CGRect.zero)
        
        let mobileNum = addPrepaidNumber
        mobileTextfield = SimpleGrayTextField(text: mobileNum, placeholder: mobileNum)
        mobileTextfield.delegate = self
        mobileTextfield.textAlignment = .left
        mobileTextfield.keyboardType = .numberPad
        
        if let phone = phoneCountryCode {
            phoneLabel = PhoneLabel(text: phone)
            phoneLabel.textAlignment = .center
        }
        
        //TEST
        self.setPosition()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setMandatory(title: String) {
        mandatory.displayView(customString: title)
    }
    
    public func removeMandatory() {
        mandatory.hideView()
    }
    
    public func setPosition() {
        self.addSubview(mobileTextfield)
        self.addSubview(phoneLabel)
        self.addSubview(iconImage)
        self.addSubview(mandatory)
        
        
        constrain(self, iconImage, phoneLabel, mobileTextfield, mandatory) { (view, icon, label, field, box) in
            icon.leading == view.leading
            icon.bottom == view.bottom - 23.0
            icon.height == 16.0
            icon.width == 16.0
            
            label.bottom == view.bottom - 23.0
            label.leading == view.leading + 23.0 //+ 13.0
            label.height == 16.0
            label.width == 50.0
            
            field.top == view.top
            field.leading == label.trailing + 10.0
            field.trailing == view.trailing 
            field.height == 50.0
            
            //label.centerY == field.centerY
            icon.centerY == label.centerY
            
            box.leading == field.leading
            box.trailing == field.trailing
            box.height == 10.0
            box.top == field.bottom + 6.0
        }
        
    }

    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 11
        guard let text = textField.text else { return true }
        let newLength = text.count + string.count - range.length
        if (newLength <= maxLength) {
            delegate?.MobilePhoneChangeData(texto: textField.text!);
        }

        return newLength <= maxLength
    }
}
