//
//  EmailView.swift
//  MiClaro
//
//  Created by Jonathan Abimael Cruz Orozco on 21/08/17.
//  Copyright © 2017 am. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import Cartography
//import mcaManageriOS

protocol EmailViewDelegate {
    func emailViewChangeHeight(newHeight: CGFloat)
    func sendEmail()
}

public class EmailView: UIView {

    /********************************* Visual elements *********************************/
//    var lblTitle: BlackTitleLabel!
//    var viewContenedor: UIView!
    var imgEmail: UIImageView!
    var txtEmail: SimpleGreenTextField!
    var lblComment: UILabel!
    var txtDescription: UITextView!
    var lblCharacters: UILabel!
    var bottomBorderLine: UIView!
    var btnSendMail: GreenBorderWhiteBackgroundButton!
    
    /********************************* Variables *********************************/
    var delegate: EmailViewDelegate!
    var placeHolderDescription: String = "Place Holder"
//    var conf = mcaManagerSession.getGeneralConfig()
    
    /// Constructor del componente de Email, el cual incluye un textfield para ingresar el correo eléctronico y un textView para el comentario
    /// - Parameter titleCard: Titulo del componente de *emailView*
    /// - Parameter placeHolderEmail: Place holder del componente de *Correo eléctronico*
    /// - Parameter placeHolderDescription: Place holder del componente de *Comentario*
    /// - Parameter size: Tamaño del componente *emailView*
    init(titleCard: String,placeHolderEmail:String, placeHolderDescription: String, size: CGSize) {
        super.init(frame: CGRect(origin: CGPoint(x:0.0, y:0.0), size: size))
        
//        viewContenedor = UIView(frame: self.frame)
        /*lblTitle = BlackTitleLabel()
        lblTitle.text = titleCard
        lblTitle.font = UIFont(name: RobotoFontName.RobotoLight.rawValue, size: 18)
        lblTitle.textColor = institutionalColors.claroTitleColor
        lblTitle.textAlignment = .left*/
        imgEmail = UIImageView()
        imgEmail.image = UIImage(named: "icon_correo_input")
        
        txtEmail = SimpleGreenTextField(text: placeHolderEmail, placeholder: placeHolderEmail)
        txtEmail.font = UIFont(name: RobotoFontName.RobotoRegular.rawValue, size: 16)
        txtEmail.autocorrectionType = .no;
        txtEmail.autocapitalizationType = .none;
        txtEmail.keyboardType = .emailAddress
        
        bottomBorderLine = UIView()
        bottomBorderLine.backgroundColor = institutionalColors.claroLightGrayColor
        
        lblComment = BlackBodyLabel()
        lblComment.text = "" //FIXME: self.conf?.translations?.data?.help?.suggestionsInput ?? "Ingresa tu comentario"
        lblComment.font = UIFont(name: RobotoFontName.RobotoBold.rawValue, size: 14)
        lblComment.textColor = institutionalColors.claroBlackColor
        lblComment.textAlignment = .left
        
        txtDescription = UITextView()
        txtDescription.font = UIFont(name: RobotoFontName.RobotoRegular.rawValue, size: 16)
        txtDescription.delegate = self
        self.placeHolderDescription = placeHolderDescription
        txtDescription.text = self.placeHolderDescription
        txtDescription.textColor = institutionalColors.claroLightGrayColor
//        txtDescription.textContainerInset = .zero
//        txtDescription.textContainer.lineFragmentPadding = 0
        txtDescription.keyboardType = .asciiCapable
        
        lblCharacters = BlackBodyLabel()
        lblCharacters.text = "0/160"
        lblCharacters.font = UIFont(name: RobotoFontName.RobotoLight.rawValue, size: 14)
        lblCharacters.textColor = institutionalColors.claroBlackColor
        lblCharacters.textAlignment = .right
        
        btnSendMail = GreenBorderWhiteBackgroundButton(textButton: "Enviar")
        btnSendMail.addTarget(self, action: #selector(sendMailAction), for: UIControlEvents.touchUpInside)
//        registreButton.frame = CGRect(x: marginX, y: btnForgot.frame.maxY + buttonYOffset, width: viewWidth - (marginX*2), height: buttonHeight)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setBorderTextView() {
        txtDescription.layer.borderWidth = 0.5
        txtDescription.layer.borderColor = institutionalColors.claroLightGrayColor.cgColor
    }
    
    func sendMailAction() {
        self.delegate.sendEmail()
    }
    /// Agregar linea en la parte inferior del componente *viewEmail*
    /// - Parameter color: Color de la linea inferior
    /// - Parameter width: Ancho de la linea inferior
    func addBottomBorderWithColor(color: UIColor, width: CGFloat) {
        let bottomBorder = CALayer()
        bottomBorder.frame = CGRect(x:0.0, y: bottomBorderLine.frame.height-1, width: bottomBorderLine.frame.width, height: width)
        bottomBorder.backgroundColor = color.cgColor
        bottomBorderLine.layer.addSublayer(bottomBorder)
    }
    
    //MARK: Public functions
    /// Para posicionar los componentes visuales dentro de "viewEmail"
    public func setPosition() {
//        self.addSubview(viewContenedor)
        /*self.addSubview(lblTitle)
        
        constrain(self, lblTitle) { (view1, view2) in
            view2.top == view1.top + 10
            view2.width == view1.width
            view2.centerX == view1.centerX
        }*/
        
        self.addSubview(imgEmail)
        constrain(self, imgEmail) { (view, email) in
            email.top == view.top + 20
            email.width == 20
            email.height == 20
            email.leading == view.leading + 20.0
        }
        
        self.addSubview(txtEmail)
        constrain(self, imgEmail, txtEmail) { (view1, email, view2) in
//            view2.top == email.top
            view2.leading == email.trailing + 5
            view2.centerY == email.centerY
            view2.trailing == view1.trailing - 20
            view2.height == email.height * 2
        }
        
        self.addSubview(lblComment)
        constrain(self, txtEmail, lblComment) { (view, mail, comment) in
            comment.top == mail.bottom + 30
            comment.width == mail.width
            comment.centerX == mail.centerX
            comment.height == 20
        }
        
        self.addSubview(txtDescription)
        constrain(self, lblComment, txtDescription) { (view, view1, view2) in
            view2.top == view1.bottom + 10
            view2.width == view1.width
            view2.centerX == view.centerX
            view2.height == view.height * 0.4
//            view2.height == view1.height
        }
        
        self.addSubview(lblCharacters)
        constrain(txtDescription, lblCharacters) { (description, character) in
            character.top == description.bottom + 10
            character.width == description.width
            character.centerX == description.centerX
            character.height == 20
        }
        
        self.addSubview(btnSendMail)
        constrain(lblCharacters, btnSendMail) { (character, button) in
            button.top == character.bottom + 10
            button.width == character.width
            button.centerX == character.centerX
            button.height == 40
        }
        
        /*self.addSubview(bottomBorderLine)
        constrain(txtDescription, bottomBorderLine) { (view1, view2) in
            view2.top == view1.bottom - 10.0// + 1.0
            view2.width == view1.width
            view2.centerX == view1.centerX
            view2.height == 1.0
        }*/
        
//        self.addBottomBorderWithColor(color: institutionalColors.claroLightGrayColor, width: 1)
    }
    
    /// Para actualizar la posición de la linea inferior
    func updateBottomLinePosition() {
//        bottomBorderLine.frame.origin = CGPoint(x: txtDescription.frame.origin.x, y: txtDescription.frame.origin.y + txtDescription.frame.height + 1.0)
        UIView.animate(withDuration: 1.0, animations: {
            self.bottomBorderLine.frame.origin = CGPoint(x: self.txtDescription.frame.origin.x, y: self.txtDescription.frame.origin.y + self.txtDescription.frame.height - 5.0)
        })
    }
    
    private func updateHeightContent(height: CGFloat) {
        let frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: self.frame.width, height: height)
        self.frame = frame
    }
    
    public func adjustPositionButton(isMailVisible: Bool) {
        if isMailVisible {
            btnSendMail.removeFromSuperview()
            self.setPosition()
        }else {
            lblComment.removeFromSuperview()
            txtDescription.removeFromSuperview()
            lblCharacters.removeFromSuperview()
            
            constrain(txtEmail, btnSendMail) { (mail, button) in
                button.top == mail.bottom + 20.0
                button.width == mail.width
                button.centerX == mail.centerX
                button.height == 40
            }
        }
    }
    
}
