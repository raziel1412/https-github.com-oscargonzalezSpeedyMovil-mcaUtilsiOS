//
//  CustomAlertViewController.swift
//  MiClaro
//
//  Created by Roberto Gutierrez Resendiz on 17/04/18.
//  Copyright © 2018 am. All rights reserved.
//

import UIKit

class CustomAlertView: UIViewController {
    private var bkg : UIView?
    var alertData : AlertInfo?
    var icono : UIImageView?
    var titulo : UILabel?
    var cuerpo : UILabel?
    var botonOk : UIButton?
    var botonCamara: UIButton?
    var botonEliminar: UIButton?
    var botonCancel : UIButton?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3);
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.layoutIfNeeded()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        setupView();
        animateView();
    }

    private func setupView(nameImgProfle: String) {
        let margin : CGFloat = 13;
        var currentY : CGFloat = 10.0;
        self.bkg = UIView();
        self.bkg?.backgroundColor = institutionalColors.claroWhiteColor;
        self.bkg?.layer.cornerRadius = 2;
        self.bkg?.frame = CGRect(x: margin, y: currentY, width: self.view.frame.width - (margin * 2), height: 100);
        self.view.addSubview(self.bkg!);
        
        let nameImage = nameImgProfle
        var tamFoto :CGFloat = 60.0
        if self.alertData?.icon == .IconoAlertaAviso || self.alertData?.icon == .IconoAlertaFelicidades || self.alertData?.icon == .IconoAlertaUnBlock {
            tamFoto = 100.0
        }

        if let logo = self.alertData?.icon, AlertIconType.NoIcon != self.alertData?.icon {
            self.icono = UIImageView()
           
            if (self.alertData as? AlertFoto) != nil && SessionSingleton.sharedInstance.checkImageExists(fileName: nameImage){
                let path = URL.urlInDocumentsDirectory(with: nameImage).path
                
                let image = UIImage(contentsOfFile: path)
                self.icono?.image = SessionSingleton.sharedInstance.resizeImage(image: image!, targetSize: CGSize(width: tamFoto*3, height: tamFoto*3))
            }else{
                self.icono?.image = UIImage(named: logo.rawValue)
            }
             self.icono?.frame = CGRect(x: (self.bkg!.frame.size.width - tamFoto) / 2, y: currentY, width: tamFoto, height: tamFoto)
            self.bkg?.addSubview(self.icono!);
        } else {
            self.icono = UIImageView()
            self.bkg?.addSubview(self.icono!);
        }
        currentY = self.icono!.frame.origin.y + self.icono!.frame.height + 10;

        if "" != (self.alertData?.title ?? "").trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) {
            self.titulo = UILabel();
            self.titulo?.frame = CGRect(x: margin, y: currentY, width: self.bkg!.frame.size.width - (margin * 2), height: 20);
            self.titulo?.text = self.alertData?.title.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) ?? "";
            self.titulo?.font = UIFont(name: RobotoFontName.RobotoBold.rawValue, size: CGFloat(20))
            self.titulo?.textColor = institutionalColors.claroBlackColor
            self.titulo?.textAlignment = .center
            self.titulo?.backgroundColor = UIColor.clear
            self.titulo?.lineBreakMode = .byWordWrapping;
            self.titulo?.numberOfLines = 0;
            self.bkg?.addSubview(self.titulo!);
            self.titulo?.sizeToFit();
            self.titulo?.frame.size.width = self.bkg!.frame.size.width - (margin * 2);
            currentY = currentY + self.titulo!.frame.size.height + 10
        }

        self.cuerpo = UILabel();
        self.cuerpo?.frame = CGRect(x: margin, y: currentY, width: self.bkg!.frame.size.width - (margin * 2), height: 20)
        self.cuerpo?.font = UIFont(name: RobotoFontName.RobotoRegular.rawValue, size: CGFloat(16))
        self.cuerpo?.textColor = institutionalColors.claroTextAlertBodyColor
        self.cuerpo?.textAlignment = .center
        self.cuerpo?.backgroundColor = UIColor.clear

        if let attributedText = try? NSAttributedString(htmlString: self.alertData?.text ?? "",
                                                        font: UIFont(name: RobotoFontName.RobotoRegular.rawValue, size: CGFloat(16)),
                                                        alignment : NSTextAlignment.center,
                                                        useDocumentFontSize: false){
            self.cuerpo?.attributedText = attributedText;
        } else {
            self.cuerpo?.lineBreakMode = .byWordWrapping;
            self.cuerpo?.text = self.alertData?.text ?? "";
        }
        self.cuerpo?.numberOfLines = 0;
        self.bkg?.addSubview(self.cuerpo!);
        self.cuerpo?.sizeToFit();
        self.cuerpo?.frame.size.width = self.bkg!.frame.size.width - (margin * 2);
        currentY = currentY + self.cuerpo!.frame.size.height + 20
        AnalyticsInteractionSingleton.sharedInstance.ADBTrackView(viewName: "Alerta", detenido: false, mensaje: self.cuerpo?.text)

        if let a = self.alertData as? AlertAcceptOnly {
            self.botonOk = UIButton();
            self.botonOk?.frame = CGRect(x: margin, y: currentY, width: self.bkg!.frame.size.width - (margin * 2), height: 40)
            if self.alertData?.buttonName != nil {
                self.botonOk?.setTitle(self.alertData?.buttonName!, for: .normal)
                self.botonOk?.setTitle(self.alertData?.buttonName!, for: .selected)
            } else {
                self.botonOk?.setTitle(a.acceptTitle, for: UIControlState.normal);
                self.botonOk?.setTitle(a.acceptTitle, for: UIControlState.selected);
            }
            self.botonOk?.titleLabel?.font = UIFont(name: RobotoFontName.RobotoBold.rawValue, size: CGFloat(16))
            if self.alertData?.buttonColor != nil {
                self.botonOk?.setTitleColor(self.alertData?.buttonColor!, for: UIControlState.normal)
                self.botonOk?.setTitleColor(self.alertData?.buttonColor!, for: UIControlState.selected)
                self.botonOk?.layer.borderColor = self.alertData?.buttonColor!.cgColor
            } else {
                self.botonOk?.setTitleColor(institutionalColors.claroRedColor, for: UIControlState.normal)
                self.botonOk?.setTitleColor(institutionalColors.claroRedColor, for: UIControlState.selected)
                self.botonOk?.layer.borderColor = institutionalColors.claroRedColor.cgColor
            }
            self.botonOk?.layer.borderWidth = 1;
            self.botonOk?.layer.cornerRadius = 2;
            self.botonOk?.addTarget(self,
                                    action: #selector(eventoOk),
                                    for: UIControlEvents.touchUpInside)
            self.bkg?.addSubview(self.botonOk!);

            currentY = currentY + self.botonOk!.frame.size.height + 20

        } else if let a = self.alertData as? AlertAcceptOnlyPasswordReq {
            
            //User phone:
            let iconoTelefono = UIImageView(frame: CGRect(x: 20, y: currentY, width: 30, height: 30))
            let tituloTelefono = UILabel()
            tituloTelefono.frame = CGRect(x: 55, y: currentY, width: self.bkg!.frame.size.width - (margin * 2), height: 30)
            
            currentY = currentY + tituloTelefono.frame.size.height + 20
            //User email:
            let iconoEmail = UIImageView(frame: CGRect(x: 20, y: currentY, width: 30, height: 30))
            let tituloEmail = UILabel()
            tituloEmail.frame = CGRect(x: 55, y: currentY, width: self.bkg!.frame.size.width - (margin * 2), height: 30)
            
            tituloTelefono.text = a.userPhone //"*******5678"
            tituloEmail.text = a.userEmail//"Na**********************@gmail.com"
            
            let imageTelefono = UIImage(named: "icon_telefono_input")
            iconoTelefono.image = imageTelefono
            
            let imageEmail = UIImage(named: "icon_correo_input")
            iconoEmail.image = imageEmail
            
            //adding contact info to Alert
            self.bkg?.addSubview(iconoEmail)
            self.bkg?.addSubview(iconoTelefono)
            
            self.bkg?.addSubview(tituloTelefono)
            self.bkg?.addSubview(tituloEmail)
            
            
            currentY = currentY + tituloEmail.frame.size.height + 20
            
            self.botonOk = UIButton();
            self.botonOk?.frame = CGRect(x: margin, y: currentY, width: self.bkg!.frame.size.width - (margin * 2), height: 40)
            if self.alertData?.buttonName != nil {
                self.botonOk?.setTitle(self.alertData?.buttonName!, for: .normal)
                self.botonOk?.setTitle(self.alertData?.buttonName!, for: .selected)
            } else {
                self.botonOk?.setTitle(a.acceptTitle, for: UIControlState.normal);
                self.botonOk?.setTitle(a.acceptTitle, for: UIControlState.selected);
            }
            self.botonOk?.titleLabel?.font = UIFont(name: RobotoFontName.RobotoBold.rawValue, size: CGFloat(16))
            if self.alertData?.buttonColor != nil {
                self.botonOk?.setTitleColor(self.alertData?.buttonColor!, for: UIControlState.normal)
                self.botonOk?.setTitleColor(self.alertData?.buttonColor!, for: UIControlState.selected)
                self.botonOk?.layer.borderColor = self.alertData?.buttonColor!.cgColor
            } else {
                self.botonOk?.setTitleColor(institutionalColors.claroRedColor, for: UIControlState.normal)
                self.botonOk?.setTitleColor(institutionalColors.claroRedColor, for: UIControlState.selected)
                self.botonOk?.layer.borderColor = institutionalColors.claroRedColor.cgColor
            }
            self.botonOk?.layer.borderWidth = 1;
            self.botonOk?.layer.cornerRadius = 2;
            self.botonOk?.addTarget(self,
                                    action: #selector(eventoOk),
                                    for: UIControlEvents.touchUpInside)
            self.bkg?.addSubview(self.botonOk!);
            
            currentY = currentY + self.botonOk!.frame.size.height + 20
            
        }else if let a = self.alertData as? AlertYesNo {
            self.botonOk = UIButton();
            self.botonOk?.frame = CGRect(x: margin, y: currentY, width: self.bkg!.frame.size.width - (margin * 2), height: 40)
            self.botonOk?.setTitle(a.acceptTitle, for: UIControlState.normal);
            self.botonOk?.setTitle(a.acceptTitle, for: UIControlState.selected);
            self.botonOk?.titleLabel?.font = UIFont(name: RobotoFontName.RobotoBold.rawValue, size: CGFloat(16))
            
            var colorAcceptBtn = institutionalColors.claroBlueColor
            if let _ = a.acceptButtonColor {
                colorAcceptBtn = a.acceptButtonColor ?? institutionalColors.claroBlueColor
            } else {
                colorAcceptBtn = self.alertData?.buttonColor ?? institutionalColors.claroBlueColor
            }
            
            self.botonOk?.setTitleColor(colorAcceptBtn, for: UIControlState.normal)
            self.botonOk?.setTitleColor(colorAcceptBtn, for: UIControlState.selected)
            self.botonOk?.layer.borderColor = colorAcceptBtn.cgColor
            self.botonOk?.layer.borderWidth = 1;
            self.botonOk?.layer.cornerRadius = 2
            self.botonOk?.addTarget(self,
                                    action: #selector(eventoOk),
                                    for: UIControlEvents.touchUpInside)
            self.bkg?.addSubview(self.botonOk!);

            currentY = currentY + self.botonOk!.frame.size.height + 20

            self.botonCancel = UIButton();
            self.botonCancel?.frame = CGRect(x: margin, y: currentY, width: self.bkg!.frame.size.width - (margin * 2), height: 40)
            self.botonCancel?.setTitle(a.cancelTitle, for: UIControlState.normal);
            self.botonCancel?.setTitle(a.cancelTitle, for: UIControlState.selected);
            self.botonCancel?.titleLabel?.font = UIFont(name: RobotoFontName.RobotoBold.rawValue, size: CGFloat(16))
            self.botonCancel?.setTitleColor(self.alertData?.buttonColor ?? institutionalColors.claroBlueColor, for: UIControlState.normal)
            self.botonCancel?.setTitleColor(self.alertData?.buttonColor ?? institutionalColors.claroBlueColor, for: UIControlState.selected)
            self.botonCancel?.layer.borderColor = self.alertData?.buttonColor?.cgColor ?? institutionalColors.claroBlueColor.cgColor
            self.botonCancel?.layer.borderWidth = 1;
            self.botonCancel?.layer.cornerRadius = 2;
            self.botonCancel?.addTarget(self,
                                        action: #selector(eventoCancel),
                                        for: UIControlEvents.touchUpInside)
            self.bkg?.addSubview(self.botonCancel!);
            let myCenter = UIView();
            myCenter.backgroundColor = UIColor.clear;
            self.bkg?.addSubview(myCenter);
            
            currentY = currentY + self.botonOk!.frame.size.height + 20
        }else if let a = self.alertData as? AlertFoto {
            
            let iconPosition : CGFloat =  70.0;
            
            self.titulo?.frame = CGRect(x: margin, y: 10.0, width: self.bkg!.frame.size.width - (margin * 2), height: 60);
            self.icono?.frame = CGRect(x: (self.bkg!.frame.size.width - tamFoto*2) / 2, y: iconPosition, width: tamFoto*2, height: tamFoto*2)
            
            if SessionSingleton.sharedInstance.checkImageExists(fileName: nameImage) {
                self.icono?.contentMode = .scaleAspectFill
                self.icono?.layer.cornerRadius = (self.icono?.frame.size.width)!/2
                self.icono?.clipsToBounds = true
            }
            currentY += 40
            
            self.botonOk = UIButton();
            self.botonOk?.frame = CGRect(x: margin, y: currentY, width: self.bkg!.frame.size.width - (margin * 2), height: 40)
            self.botonOk?.setTitle(a.acceptTitle, for: UIControlState.normal);
            self.botonOk?.setTitle(a.acceptTitle, for: UIControlState.selected);
            self.botonOk?.titleLabel?.font = UIFont(name: RobotoFontName.RobotoBold.rawValue, size: CGFloat(16))
            self.botonOk?.contentHorizontalAlignment = .left
            self.botonOk?.titleEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
            self.botonOk?.setTitleColor(institutionalColors.claroBlackColor, for: UIControlState.normal)
            self.botonOk?.setTitleColor(self.alertData?.buttonColor ?? institutionalColors.claroBlueColor, for: UIControlState.selected)
            self.botonOk?.layer.borderColor = institutionalColors.claroBlackColor.cgColor
            self.botonOk?.layer.borderWidth = 1;
            self.botonOk?.layer.cornerRadius = 2
            self.botonOk?.addTarget(self,
                                    action: #selector(eventoOk),
                                    for: UIControlEvents.touchUpInside)
            self.bkg?.addSubview(self.botonOk!);
    
            let accessoryViewOk = UIImageView(image: UIImage(named: "ico_siguiente")!)
            accessoryViewOk.frame = CGRect(x: (botonOk?.frame.width)! - 15, y: currentY+10, width: 20.0, height: 20.0)
            self.bkg?.addSubview(accessoryViewOk);
            
            currentY = currentY + self.botonOk!.frame.size.height + 20
            
            //********************
            
            self.botonCamara = UIButton();
            self.botonCamara?.frame = CGRect(x: margin, y: currentY, width: self.bkg!.frame.size.width - (margin * 2), height: 40)
            self.botonCamara?.setTitle(a.abrirCamaraTitle, for: UIControlState.normal);
            self.botonCamara?.setTitle(a.abrirCamaraTitle, for: UIControlState.selected);
            self.botonCamara?.titleLabel?.font = UIFont(name: RobotoFontName.RobotoBold.rawValue, size: CGFloat(16))
            self.botonCamara?.contentHorizontalAlignment = .left
            self.botonCamara?.titleEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
            self.botonCamara?.setTitleColor(institutionalColors.claroBlackColor, for: UIControlState.normal)
            self.botonCamara?.setTitleColor(self.alertData?.buttonColor ?? institutionalColors.claroBlueColor, for: UIControlState.selected)
            self.botonCamara?.layer.borderColor = institutionalColors.claroBlackColor.cgColor
            self.botonCamara?.layer.borderWidth = 1;
            self.botonCamara?.layer.cornerRadius = 2;
            self.botonCamara?.addTarget(self,
                                        action: #selector(eventoOpenCamara),
                                        for: UIControlEvents.touchUpInside)
            self.bkg?.addSubview(self.botonCamara!);
            
            let accessoryViewCamara = UIImageView(image: UIImage(named: "ico_siguiente")!)
            accessoryViewCamara.frame = CGRect(x: (botonCamara?.frame.width)! - 15, y: currentY+10, width: 20.0, height: 20.0)
            self.bkg?.addSubview(accessoryViewCamara);
            
            currentY = currentY + self.botonOk!.frame.size.height + 20
            
            //********************
            //********************
            
            if(a.eliminarFotoTitle != ""){
                
                self.botonEliminar = UIButton();
                self.botonEliminar?.frame = CGRect(x: margin, y: currentY, width: self.bkg!.frame.size.width - (margin * 2), height: 40)
                self.botonEliminar?.setTitle(a.eliminarFotoTitle, for: UIControlState.normal);
                self.botonEliminar?.setTitle(a.eliminarFotoTitle, for: UIControlState.selected);
                self.botonEliminar?.titleLabel?.font = UIFont(name: RobotoFontName.RobotoBold.rawValue, size: CGFloat(16))
                self.botonEliminar?.contentHorizontalAlignment = .left
                self.botonEliminar?.titleEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
                self.botonEliminar?.setTitleColor(institutionalColors.claroBlackColor, for: UIControlState.normal)
                self.botonEliminar?.setTitleColor(self.alertData?.buttonColor ?? institutionalColors.claroBlueColor, for: UIControlState.selected)
                self.botonEliminar?.layer.borderColor = institutionalColors.claroBlackColor.cgColor
                self.botonEliminar?.layer.borderWidth = 1;
                self.botonEliminar?.layer.cornerRadius = 2;
                self.botonEliminar?.addTarget(self,
                                              action: #selector(eventoDeletePhoto),
                                              for: UIControlEvents.touchUpInside)
                self.bkg?.addSubview(self.botonEliminar!);
                
                let accessoryViewDelete = UIImageView(image: UIImage(named: "ico_siguiente")!)
                accessoryViewDelete.frame = CGRect(x: (botonEliminar?.frame.width)! - 15, y: currentY+10, width: 20.0, height: 20.0)
                self.bkg?.addSubview(accessoryViewDelete);
                
                currentY = currentY + self.botonOk!.frame.size.height + 20
            }
            
            //********************
            self.botonCancel = UIButton();
            self.botonCancel?.frame = CGRect(x: margin, y: currentY, width: self.bkg!.frame.size.width - (margin * 2), height: 40)
            self.botonCancel?.setTitle(a.cancelTitle, for: UIControlState.normal);
            self.botonCancel?.setTitle(a.cancelTitle, for: UIControlState.selected);
            self.botonCancel?.titleLabel?.font = UIFont(name: RobotoFontName.RobotoBold.rawValue, size: CGFloat(16))
            self.botonCancel?.setTitleColor(self.alertData?.buttonColor ?? institutionalColors.claroBlueColor, for: UIControlState.normal)
            self.botonCancel?.setTitleColor(self.alertData?.buttonColor ?? institutionalColors.claroBlueColor, for: UIControlState.selected)
            self.botonCancel?.layer.borderColor = self.alertData?.buttonColor?.cgColor ?? institutionalColors.claroBlueColor.cgColor
            self.botonCancel?.layer.borderWidth = 1;
            self.botonCancel?.layer.cornerRadius = 2;
            self.botonCancel?.addTarget(self,
                                        action: #selector(eventoCancel),
                                        for: UIControlEvents.touchUpInside)
            self.bkg?.addSubview(self.botonCancel!);
            let myCenter = UIView();
            myCenter.backgroundColor = UIColor.clear;
            self.bkg?.addSubview(myCenter);

            currentY = currentY + self.botonOk!.frame.size.height + 20
        }

        let maxAllowedAlertHeight = self.view.frame.height - margin * 2
        currentY = currentY > maxAllowedAlertHeight ? maxAllowedAlertHeight : currentY

        self.bkg?.frame.size.height = currentY
        self.bkg?.frame = CGRect(x: 13, y: (self.view.frame.height - currentY) / 2, width: self.view.frame.width - (13 * 2), height: currentY);

    }

    private func animateView() {
        self.view.alpha = 0;
        self.view.frame.origin.y = self.view.frame.origin.y + 50
        UIView.animate(withDuration: 1, animations: { () -> Void in
            self.view.alpha = 1.0;
            self.bkg?.frame.origin.y = self.bkg?.frame.origin.y ?? 0 - 50
        })
    }

    @objc internal func eventoOk() {
        if let a = self.alertData as? AlertAcceptOnly {
            a.onAcceptEvent();
        } else if let a = self.alertData as? AlertAcceptOnlyPasswordReq {
            a.onAcceptEvent();
        } else if let a = self.alertData as? AlertYesNo {
            a.onAcceptEvent();
        } else if let a = self.alertData as? AlertFoto {
            self.dismiss(animated: true,
                         completion: nil)
            a.onAcceptEvent();
            return
        }

        self.dismiss(animated: true,
                     completion: nil)
    }
    
    @objc internal func eventoOpenCamara() {
        if let a = self.alertData as? AlertFoto {
            self.dismiss(animated: true,
                         completion: nil)
            a.onCamaraEvent();
        }
    }
    
    @objc internal func eventoDeletePhoto() {
        if let a = self.alertData as? AlertFoto {
            a.onDeletePhotoEvent();
        }
    }
    
    @objc internal func eventoCancel() {
        if let a = self.alertData as? AlertYesNo {
            a.onCancelEvent();
        } else if let a = self.alertData as? AlertFoto {
            a.onCancelEvent();
        }
        self.dismiss(animated: true,
                     completion: nil)
    }

}
