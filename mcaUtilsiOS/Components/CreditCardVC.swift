//
//  CreditCardVC.swift
//  mcaTopUpRefilliOS
//
//  Created by Ricardo Rodriguez De Los Santos on 2/25/19.
//  Copyright © 2019 Speedy Movil. All rights reserved.
//

import UIKit

public class CreditCardVC: UIViewController {

    
    
    lazy var containerView: UIView = {
        let posX = (self.view.frame.width - 40) / 2
        let posY = (self.view.frame.height - 100) / 2
        let view = UIView(frame: CGRect(x: (self.view.frame.width / 2) - posX, y: (self.view.frame.height / 2) - posY , width: self.view.frame.width - 40, height: self.view.frame.height - 100))
        view.backgroundColor = institutionalColors.claroWhiteColor
        
        return view
    }()
    
    lazy var headerView: UIHeaderForm = {
        let header = UIHeaderForm(frame: CGRect(x: 0, y: 0, width: self.containerView.frame.width, height: 200))
        header.setupElements(imageName: "icon_avatar", title: "Nueva tarjeta:", subTitle: "Agrega una tarjeta de Débito o Crédito:")
        
        return header
    }()
    
    lazy var numberCardView: UITextFieldGroupView = {
        let numberCardView = UITextFieldGroupView(frame: CGRect(x: 0, y: self.headerView.frame.maxY, width: self.containerView.frame.width, height: 80))
        numberCardView.setupContent(imageName: "visa", titleTex: "Número de Tarjeta:", text: "", placeHolder: "XXXX XXXX XXXX XXXX")
        
        return numberCardView
    }()
    
    lazy var nameHolderView: UITextFieldGroupView = {
        let nameHolderView = UITextFieldGroupView(frame: CGRect(x: 0, y: self.numberCardView.frame.maxY, width: self.containerView.frame.width, height: 80))
        nameHolderView.setupContent(imageName: "", titleTex: "Nombre del Titular:", text: "", placeHolder: "Nombre del Titular")
        
        return nameHolderView
    }()
    
    lazy var dateExpiryView: UITextFieldGroupView = {
        let dateExpiryView = UITextFieldGroupView(frame: CGRect(x: 0, y: self.nameHolderView.frame.maxY, width: self.containerView.frame.width / 2, height: 80))
        dateExpiryView.textField.font = UIFont(name: RobotoFontName.RobotoMedium.rawValue, size: CGFloat(13.0))
        dateExpiryView.setupContent(imageName: "", titleTex: "Fecha de expiración", text: "", placeHolder: "mm/yyyy")
        
        return dateExpiryView
    }()
    
    lazy var cvcView: UITextFieldGroupView = {
        let cvcView = UITextFieldGroupView(frame: CGRect(x: self.dateExpiryView.frame.maxX - 20, y: self.nameHolderView.frame.maxY , width: self.containerView.frame.width / 2 - 20, height: 80))
        cvcView.textField.font = UIFont(name: RobotoFontName.RobotoMedium.rawValue, size: CGFloat(13.0))
        cvcView.setupContent(imageName: "", titleTex: "Codigo cvc", text: "", placeHolder: "****")
        
        return cvcView
    }()
    
    
    lazy var helpImageView: UIImageView = {
        let positionY = self.cvcView.frame.height / 2 + 10
        let image = UIImageView(frame: CGRect(x: self.containerView.frame.width - 50, y: self.cvcView.frame.maxY - positionY, width: 40, height: 40))
        image.image = mcaUtilsHelper.getImage(image: "icon_question_input")
        image.isUserInteractionEnabled = true
        
        
        return image
    }()
    
    lazy var buttonAddCard: RedBackgroundButton = {
        let button = RedBackgroundButton(textButton: "Agregar Tarjeta")
        button.frame = CGRect(x: 40, y: self.cvcView.frame.maxY + 20, width: self.containerView.frame.width - 80, height: 40)
        
        return button
    }()
    
    lazy var buttonCancel: RedBackgroundButton = {
        let button = RedBackgroundButton(textButton: "Cancelar", colorBorder: institutionalColors.claroBlueColor, thickness: 1.1, radiusBorder: 0.0)
        button.cornerRadius = 0
        button.setTitleColor(institutionalColors.claroBlueColor, for: .normal)
        button.frame = CGRect(x: 40, y: self.buttonAddCard.frame.maxY + 20, width: self.containerView.frame.width - 80, height: 40)
        button.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(cancelAction)))
        
        return button
    }()
    
    var lastVC: UIViewController?
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.containerView.addSubview(headerView)
        self.containerView.addSubview(numberCardView)
        self.containerView.addSubview(nameHolderView)
        self.containerView.addSubview(dateExpiryView)
        self.containerView.addSubview(cvcView)
        self.containerView.addSubview(helpImageView)
        self.containerView.addSubview(buttonAddCard)
        self.containerView.addSubview(buttonCancel)
        self.view.backgroundColor = institutionalColors.claroBlackColor.withAlphaComponent(0.7)
        self.view.addSubview(self.containerView)
        self.updateFrameView()
        
    }
    
    func updateFrameView(){
        
        let height = headerView.frame.height + numberCardView.frame.height + nameHolderView.frame.height + dateExpiryView.frame.height + buttonAddCard.frame.height + buttonCancel.frame.height + 60
        
        let posX = (self.view.frame.width - 40) / 2
        let posY = height / 2
        self.containerView.frame = CGRect(x: (self.view.frame.width / 2) - posX, y: (self.view.frame.height / 2) - posY , width: self.view.frame.width - 40, height: height)
        
    }

    public static func show(inViewController: UIViewController) {
        let popupVC = CreditCardVC()
        popupVC.modalPresentationStyle = .overFullScreen
        popupVC.providesPresentationContextTransitionStyle = true;
        popupVC.definesPresentationContext = true;
        popupVC.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        popupVC.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        popupVC.lastVC = inViewController
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        let vc = UIViewController()
        vc.view.backgroundColor = .clear
        window.rootViewController = vc
        window.windowLevel = UIWindowLevelAlert + 1
        window.makeKeyAndVisible()
        vc.present(popupVC, animated: true, completion: nil)
        
    }
    
    func cancelAction(){
        self.dismiss(animated: true, completion: nil)
    }

}
