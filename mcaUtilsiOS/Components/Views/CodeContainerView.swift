
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
    
    private var firstCodeTextfield: SimpleGreenTextField!
    private var secondCodeTextfield: SimpleGreenTextField!
    private var thirdCodeTextfield: SimpleGreenTextField!
    private var fourthCodeTextfield: SimpleGreenTextField!
    //private var codeLabel: PhoneLabel!
    
    public init() {
        super.init(frame: CGRect.zero)
        
        //let conf = SessionSingleton.sharedInstance.getGeneralConfig();
        //let code = (conf?.translations?.data?.generales?.pin)!
        
        let tipoTeclado : UIKeyboardType = .namePhonePad;
        let capitalizacion : UITextAutocapitalizationType = .none;
        firstCodeTextfield = SimpleGreenTextField(text: "", placeholder: "")
        firstCodeTextfield.delegate = self
        firstCodeTextfield.textAlignment = .center
        firstCodeTextfield.keyboardType = tipoTeclado
        firstCodeTextfield.autocapitalizationType = capitalizacion;
        firstCodeTextfield.font = UIFont(name: RobotoFontName.RobotoRegular.rawValue, size: CGFloat(14))
        
        secondCodeTextfield = SimpleGreenTextField(text: "", placeholder: "")
        secondCodeTextfield.textAlignment = .center
        secondCodeTextfield.keyboardType = tipoTeclado
        secondCodeTextfield.delegate = self
        secondCodeTextfield.autocapitalizationType = capitalizacion;
        secondCodeTextfield.font = UIFont(name: RobotoFontName.RobotoRegular.rawValue, size: CGFloat(14))
        
        thirdCodeTextfield = SimpleGreenTextField(text: "", placeholder: "")
        thirdCodeTextfield.textAlignment = .center
        thirdCodeTextfield.keyboardType = tipoTeclado
        thirdCodeTextfield.delegate = self
        thirdCodeTextfield.autocapitalizationType = capitalizacion;
        thirdCodeTextfield.font = UIFont(name: RobotoFontName.RobotoRegular.rawValue, size: CGFloat(14))
        
        fourthCodeTextfield = SimpleGreenTextField(text: "", placeholder: "")
        fourthCodeTextfield.textAlignment = .center
        fourthCodeTextfield.keyboardType = tipoTeclado
        fourthCodeTextfield.delegate = self
        fourthCodeTextfield.autocapitalizationType = capitalizacion;
        fourthCodeTextfield.font = UIFont(name: RobotoFontName.RobotoRegular.rawValue, size: CGFloat(14))
        
        /*codeLabel = PhoneLabel(text: code)
        codeLabel.textColor = institutionalColors.claroLightGrayColor
        codeLabel.font = UIFont(name: RobotoFontName.RobotoRegular.rawValue, size: CGFloat(16))*/
    }

    public func setKeyboardType(tipoTeclado : UIKeyboardType) {
        firstCodeTextfield.keyboardType = tipoTeclado
        secondCodeTextfield.keyboardType = tipoTeclado
        thirdCodeTextfield.keyboardType = tipoTeclado
        fourthCodeTextfield.keyboardType = tipoTeclado
    }
    
    public func setPosition() {
        self.addSubview(firstCodeTextfield)
        self.addSubview(secondCodeTextfield)
        self.addSubview(thirdCodeTextfield)
        self.addSubview(fourthCodeTextfield)
        //self.addSubview(codeLabel)
        
        /*constrain(self, codeLabel) { (view1, view2) in
            view2.top == view1.top
            view2.leading == view1.leading
        }
        
        constrain(self, firstCodeTextfield, codeLabel) { (view1, view2, view3) in
            view2.top == view3.bottomMargin
            view2.leading == view3.leading
            view2.width == view1.width * 0.20
        }*/
        let kSpacing = self.frame.size.width * 0.05
        constrain(self, firstCodeTextfield) { (view, code) in
            code.top == view.top
            code.bottom == view.bottom
            code.leading == view.leading
            code.width == view.width * 0.20
            
        }
        
        constrain(self, secondCodeTextfield, firstCodeTextfield) { (view1, view2, view3) in
            view2.leading == view3.trailing + kSpacing
            view2.width == view1.width * 0.20
            view2.top == view1.top
            view2.bottom == view1.bottom
            
        }
        
        constrain(self, thirdCodeTextfield, secondCodeTextfield) { (view1, view2, view3) in
            view2.leading == view3.trailing + kSpacing
            view2.width == view1.width * 0.20
            view2.top == view1.top
            view2.bottom == view1.bottom
        }
        
        constrain(self, fourthCodeTextfield, thirdCodeTextfield) { (view1, view2, view3) in
            view2.leading == view3.trailing + kSpacing
            view2.width == view1.width * 0.20
            view2.top == view1.top
            view2.bottom == view1.bottom
        }
        
    }
    
    public func resignResponder() {
        if firstCodeTextfield.canResignFirstResponder {
            firstCodeTextfield.resignFirstResponder();
        }
        
        if secondCodeTextfield.canResignFirstResponder {
            secondCodeTextfield.resignFirstResponder();
        }
        
        if thirdCodeTextfield.canResignFirstResponder {
            thirdCodeTextfield.resignFirstResponder();
        }
        
        if fourthCodeTextfield.canResignFirstResponder {
            fourthCodeTextfield.resignFirstResponder();
        }
    }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if ((textField.text?.count)! < 1  && string.count > 0){
            if(textField == firstCodeTextfield){
                secondCodeTextfield.becomeFirstResponder()
            }
            if(textField == secondCodeTextfield){
                thirdCodeTextfield.becomeFirstResponder()
            }
            if(textField == thirdCodeTextfield){
                fourthCodeTextfield.becomeFirstResponder()
            }
            textField.text = string
            return false
        }else if ((textField.text?.count)! >= 1  && string.count == 0){
            if(textField == secondCodeTextfield){
                firstCodeTextfield.becomeFirstResponder()
            }
            if(textField == thirdCodeTextfield){
                secondCodeTextfield.becomeFirstResponder()
            }
            if(textField == fourthCodeTextfield) {
                thirdCodeTextfield.becomeFirstResponder()
            }
            textField.text = ""
            return false
        }else if ((textField.text?.count)! >= 1  ){
            if(textField == firstCodeTextfield){
                secondCodeTextfield.becomeFirstResponder()
            }
            if(textField == secondCodeTextfield){
                thirdCodeTextfield.becomeFirstResponder()
            }
            if(textField == thirdCodeTextfield){
                fourthCodeTextfield.becomeFirstResponder()
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
        let code = String.init(format: "%@%@%@%@", firstCodeTextfield.text!,
                               secondCodeTextfield.text!,
                               thirdCodeTextfield.text!,
                               fourthCodeTextfield.text!);
        
        return code
    }
    
    public func cleanCode() {
        firstCodeTextfield.text = "";
        secondCodeTextfield.text = "";
        thirdCodeTextfield.text = "";
        fourthCodeTextfield.text = "";
    }
}
