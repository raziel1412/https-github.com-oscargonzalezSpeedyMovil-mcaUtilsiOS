
//
//  CodeContainerView.swift
//  MiClaro
//
//  Created by Mauricio Javier Perez Flores on 8/2/17.
//  Copyright © 2017 am. All rights reserved.
//

import UIKit
import Cartography

/// Esta clase especializa un UIView para permitirle tener apariencia de ventana especial para la captura de tokens o códigos enviados por SMS.
public class CodeContainerView: UIView, UITextFieldDelegate {

    
    private var arrayTextField = [SimpleGreenTextField]()
    
    public var numberCode = 0
    
    public init() {
        super.init(frame: CGRect.zero)
    }

    public func setKeyboardType(tipoTeclado : UIKeyboardType) {
        for textField in self.arrayTextField {
            textField.keyboardType = tipoTeclado
        }
    }
    
    public func setPosition() {
        let tipoTeclado : UIKeyboardType = .namePhonePad;
        let capitalizacion : UITextAutocapitalizationType = .none;
        
        let kSpacing = self.frame.size.width * 0.05
        var maxXText: CGFloat = 0
        let width: CGFloat = self.frame.width - (CGFloat(numberCode - 1) * kSpacing)

        for i in 0 ... numberCode - 1 {
            
            let textField = SimpleGreenTextField(text: "", placeholder: "")
            textField.frame = CGRect(x: maxXText, y: 0, width: width / CGFloat(numberCode), height: self.frame.height)
            textField.delegate = self
            textField.textAlignment = .center
            textField.keyboardType = tipoTeclado
            textField.autocapitalizationType = capitalizacion;
            textField.font = UIFont(name: RobotoFontName.RobotoRegular.rawValue, size: CGFloat(14))
            textField.tag = i
            
            maxXText = textField.frame.maxX + kSpacing
            self.addSubview(textField)
            self.arrayTextField.append(textField)
            
        }

    }
    
    public func resignResponder() {
        for textField in self.arrayTextField{
            if textField.canResignFirstResponder {
                textField.resignFirstResponder()
            }
        }
    }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if ((textField.text?.count)! < 1  && string.count > 0){
            if textField.tag != numberCode - 1{
                self.arrayTextField[textField.tag + 1].becomeFirstResponder()
            }
            textField.text = string
            return false
        }else if ((textField.text?.count)! >= 1  && string.count == 0){
            if textField.tag != 0 {
                self.arrayTextField[textField.tag - 1].becomeFirstResponder()
            }
            textField.text = ""
            return false
        }else if ((textField.text?.count)! >= 1  ){
            if textField.tag != numberCode - 1{
                self.arrayTextField[textField.tag + 1].becomeFirstResponder()
            }
            textField.text = string
            return false
        }
        
        return true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func getCode() -> String {
        var formatText = ""
        for textField in self.arrayTextField {
            formatText += textField.text!
        }
        
        let code = formatText

        return code
    }
    
    public func cleanCode() {
        for textField in self.arrayTextField {
            textField.text = ""
        }
    }
    
}
