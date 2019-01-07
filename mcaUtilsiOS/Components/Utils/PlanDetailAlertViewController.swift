//
//  PlanDetailAlertViewController.swift
//  MiClaro
//
//  Created by Roberto Gutierrez Resendiz on 09/08/18.
//  Copyright © 2018 am. All rights reserved.
//

import UIKit

public class PlanDetailAlertViewController: UIViewController {
    private var bkg : UIView?
    var alertData : PlanDetailAlertData?
    var myScroll : UIScrollView?
    var icono : UIImageView?
    var titulo : UILabel?
    var subtitulo : UILabel?
    var incluye : UILabel?
    var cuerpo : UILabel?
    var botonOk : UIButton?
    var botonCancel : UIButton?

    override public func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3);
    }

    override public func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.layoutIfNeeded()
    }

    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        setupView();
        animateView();
    }

    private func setupView() {
        let margin : CGFloat = 16;
        var currentY : CGFloat = 10.0;
        self.bkg = UIView();
        self.bkg?.backgroundColor = institutionalColors.claroWhiteColor;
        self.bkg?.layer.cornerRadius = 2;
        self.bkg?.frame = CGRect(x: margin, y: currentY, width: self.view.frame.width - (margin * 2), height: 100);
        self.view.addSubview(self.bkg!);

        self.myScroll = UIScrollView();
        self.myScroll?.frame = self.bkg?.frame ?? UIScreen.main.bounds;
        self.view.addSubview(self.myScroll!);

        if let logo = self.alertData?.icon, AlertIconType.NoIcon != self.alertData?.icon {
            self.icono = UIImageView(image: mcaUtilsHelper.getImage(image: logo.rawValue))
            self.icono?.frame = CGRect(x: (self.bkg!.frame.size.width - self.icono!.frame.size.width) / 2, y: currentY, width: self.icono!.frame.width, height: self.icono!.frame.height)
            self.myScroll?.addSubview(self.icono!);
        } else {
            self.icono = UIImageView()
            self.myScroll?.addSubview(self.icono!);
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
            self.myScroll?.addSubview(self.titulo!);
            self.titulo?.sizeToFit();
            self.titulo?.frame.size.width = self.bkg!.frame.size.width - (margin * 2);
            currentY = currentY + self.titulo!.frame.size.height + 10
        }

        if "" != (self.alertData?.subtitle ?? "").trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) {
            self.subtitulo = UILabel();
            self.subtitulo?.frame = CGRect(x: margin, y: currentY, width: self.bkg!.frame.size.width - (margin * 2), height: 20);
            self.subtitulo?.text = self.alertData?.subtitle?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) ?? "";
            self.subtitulo?.font = UIFont(name: RobotoFontName.RobotoLight.rawValue, size: CGFloat(20))
            self.subtitulo?.textColor = institutionalColors.claroBlackColor
            self.subtitulo?.textAlignment = .center
            self.subtitulo?.backgroundColor = UIColor.clear
            self.subtitulo?.lineBreakMode = .byWordWrapping;
            self.subtitulo?.numberOfLines = 0;
            self.myScroll?.addSubview(self.subtitulo!);
            self.subtitulo?.sizeToFit();
            self.subtitulo?.frame.size.width = self.bkg!.frame.size.width - (margin * 2);
            currentY = currentY + self.subtitulo!.frame.size.height + 10
        }

        self.incluye = UILabel();
        self.incluye?.frame = CGRect(x: margin, y: currentY, width: self.bkg!.frame.size.width - (margin * 2), height: 20)
        self.incluye?.text = self.alertData?.includes?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) ?? "";
        self.incluye?.font = UIFont(name: RobotoFontName.RobotoBold.rawValue, size: CGFloat(20))
        self.incluye?.textColor = institutionalColors.claroBlackColor
        self.incluye?.textAlignment = .left
        self.incluye?.backgroundColor = UIColor.clear
        self.incluye?.lineBreakMode = .byWordWrapping;
        self.incluye?.numberOfLines = 0;
        self.myScroll?.addSubview(self.incluye!);
        self.incluye?.sizeToFit();
        self.incluye?.frame.size.width = self.bkg!.frame.size.width - (margin * 2);
        currentY = currentY + self.incluye!.frame.size.height + 10

        self.cuerpo = UILabel();
        self.cuerpo?.frame = CGRect(x: margin, y: currentY, width: self.bkg!.frame.size.width - (margin * 2), height: 20)
        self.cuerpo?.font = UIFont(name: RobotoFontName.RobotoRegular.rawValue, size: CGFloat(16))
        self.cuerpo?.textColor = institutionalColors.claroTextAlertBodyColor
        self.cuerpo?.textAlignment = .left
        self.cuerpo?.backgroundColor = UIColor.clear

        if let attributedText = try? NSAttributedString(htmlString: self.alertData?.text ?? "",
                                                        font: UIFont(name: RobotoFontName.RobotoRegular.rawValue, size: CGFloat(16)),
                                                        alignment : NSTextAlignment.left,
                                                        useDocumentFontSize: false){
            self.cuerpo?.attributedText = attributedText;
        } else {
            self.cuerpo?.lineBreakMode = .byWordWrapping;
            self.cuerpo?.text = self.alertData?.text ?? "";
        }
        self.cuerpo?.numberOfLines = 0;
        self.myScroll?.addSubview(self.cuerpo!);
        self.cuerpo?.sizeToFit();
        self.cuerpo?.frame.size.width = self.bkg!.frame.size.width - (margin * 2);
        currentY = currentY + self.cuerpo!.frame.size.height + 20
        
        let notificationAnalytics = NotificationAnalyticsModel(viewName: "Alerta", isStopped: false, message: self.cuerpo?.text ?? "")
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "ADBTrackView"), object: notificationAnalytics)

        if let a = self.alertData {
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
            self.myScroll?.addSubview(self.botonOk!);

            currentY = currentY + self.botonOk!.frame.size.height + 20

        }

        let maxAllowedAlertHeight = self.view.frame.height - margin * 2
        self.myScroll?.contentSize = CGSize(width: self.view.frame.width - (13 * 2), height: currentY);

        currentY = currentY > maxAllowedAlertHeight ? maxAllowedAlertHeight : currentY

        self.bkg?.frame.size.height = currentY
        self.bkg?.frame = CGRect(x: 13, y: (self.view.frame.height - currentY) / 2, width: self.view.frame.width - (13 * 2), height: currentY);

        self.myScroll?.frame = self.bkg!.frame;

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
        if let a = self.alertData {
            a.onAcceptEvent();
        }

        self.dismiss(animated: true,
                     completion: nil)
    }

}
