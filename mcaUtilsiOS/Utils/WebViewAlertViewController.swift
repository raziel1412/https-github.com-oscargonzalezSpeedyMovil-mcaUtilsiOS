//
//  WebViewAlertViewController.swift
//  MiClaro
//
//  Created by Roberto Gutierrez Resendiz on 25/05/18.
//  Copyright © 2018 am. All rights reserved.
//

import UIKit

class WebViewAlertViewController: UIViewController {
    private var bkg : UIView?
    var alertData : WebViewAlertData?
    var wv : WebView?
    var botonOk : UIButton?
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

    private func setupView() {
        let margin : CGFloat = 13;
        var currentY : CGFloat = margin;
        self.bkg = UIView();
        self.bkg?.backgroundColor = institutionalColors.claroWhiteColor;
        self.bkg?.layer.cornerRadius = 2;
        self.bkg?.frame = CGRect(x: margin, y: currentY, width: self.view.frame.width - (margin * 2), height: (UIApplication.shared.keyWindow?.rootViewController?.view?.frame.size.height ?? (margin * 2)) - (margin * 2));
        self.view.addSubview(self.bkg!);

        let vwFullHeight = (UIApplication.shared.keyWindow?.rootViewController?.view?.frame.size.height ?? (margin * 2)) - (margin * 2);
        let fwv = CGRect(x: margin, y: currentY, width: self.bkg!.frame.size.width - (margin * 2), height: vwFullHeight - currentY - 80)
        self.wv = WebView(url: alertData?.url ?? "",
                          frame: fwv,
                          method: alertData?.method ?? "GET",
                          body: nil);
        self.wv?.backgroundColor = UIColor.clear
        self.bkg?.addSubview(self.wv!);
        currentY = currentY + self.wv!.frame.size.height + 20

        let a = self.alertData;
        self.botonOk = UIButton();
        self.botonOk?.frame = CGRect(x: margin, y: currentY, width: self.bkg!.frame.size.width - (margin * 2), height: 40)
        self.botonOk?.setTitle(a?.acceptTitle, for: UIControlState.normal);
        self.botonOk?.setTitle(a?.acceptTitle, for: UIControlState.selected);
        self.botonOk?.titleLabel?.font = UIFont(name: RobotoFontName.RobotoBold.rawValue, size: CGFloat(16))
        self.botonOk?.setTitleColor(institutionalColors.claroBlueColor, for: UIControlState.normal)
        self.botonOk?.setTitleColor(institutionalColors.claroBlueColor, for: UIControlState.selected)
        self.botonOk?.layer.borderColor = institutionalColors.claroBlueColor.cgColor
        self.botonOk?.layer.borderWidth = 1;
        self.botonOk?.layer.cornerRadius = 2;
        self.botonOk?.addTarget(self,
                                action: #selector(eventoOk),
                                for: UIControlEvents.touchUpInside)
        self.bkg?.addSubview(self.botonOk!);

        currentY = currentY + self.botonOk!.frame.size.height + 20

        let maxAllowedAlertHeight = self.view.frame.height - margin * 2
        currentY = currentY > maxAllowedAlertHeight ? maxAllowedAlertHeight : currentY

        self.bkg?.frame.size.height = currentY
        self.bkg?.frame = CGRect(x: 13, y: 22, width: self.view.frame.width - (13 * 2), height: (UIApplication.shared.keyWindow?.rootViewController?.view?.frame.size.height ?? (margin * 2)) - (margin * 2) - 10);
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
        self.alertData?.onAcceptEvent();

        self.dismiss(animated: true,
                     completion: nil)
    }

    @objc internal func eventoCancel() {

        self.dismiss(animated: true,
                     completion: nil)
    }

}
