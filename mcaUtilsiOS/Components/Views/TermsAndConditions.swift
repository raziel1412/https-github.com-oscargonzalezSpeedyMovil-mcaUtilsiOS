//
//  TermsAndConditions.swift
//  MiClaro
//
//  Created by Fernando Rodriguez Minguet on 30/05/18.
//  Copyright © 2018 am. All rights reserved.
//

import UIKit
import Cartography

class TermsAndConditions: UIView {
    
    var checkBox : SquaredCheckbox = SquaredCheckbox(frame: .zero)
    private var contentLabel : LinkableLabel = LinkableLabel(frame: .zero)
    private var content : String = ""
    private var linkTextRange : NSRange?
    private var parentViewName : String = ""

    init(frame: CGRect, content: String? = nil) {
        super.init(frame: frame)
        if content != nil {
            contentLabel.text = content!
        }

        contentLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.lnkTerminos_OnClick)))
        contentLabel.numberOfLines = 0
        contentLabel.isEnabled = true
        self.addSubview(checkBox)
        self.addSubview(contentLabel)
        setupConstraints()
    }
    
    func setContent(_ content: String) {
        self.content = content
        contentLabel.showText(text: content)
    }
    func setParentView(_ parent: String) {
        parentViewName = parent
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        constrain(self, checkBox) { (view, box) in
            box.width == view.width * 0.07
            box.height == view.width * 0.07
            box.leading == view.leading
            box.top == view.top
        }
        constrain(self, contentLabel, checkBox) { (view, label, box) in
            label.leading == box.trailing + 16.0
            label.top == view.top
            label.bottom == view.bottom
            label.trailing == view.trailing
        }
    }
    
    func setupClickDelegate(target: Any?, action: Selector?) {
        contentLabel.gestureRecognizers?.removeAll()
        contentLabel.addGestureRecognizer(UITapGestureRecognizer(target: target, action: action))
    }
    
    var isChecked : Bool {
        return checkBox.isSelected
    }
    
    @objc func lnkTerminos_OnClick() {
        if false == SessionSingleton.sharedInstance.isNetworkConnected() {
            NotificationCenter.default.post(name: Observers.ObserverList.ShowOfflineMessage.name, object: nil);
            return;
        }

        let alert = WebViewAlertData();
        alert.method = "GET";
        alert.url = SessionSingleton.sharedInstance.getGeneralConfig()?.termsAndConditions?.url;
        alert.title = SessionSingleton.sharedInstance.getGeneralConfig()?.translations?.data?.generales?.termsAndConditions ?? "";
        alert.acceptTitle = SessionSingleton.sharedInstance.getGeneralConfig()?.translations?.data?.generales?.closeBtn ?? "";
        alert.onAcceptEvent = {
        }
        NotificationCenter.default.post(name: Observers.ObserverList.WebViewAlert.name,
                                        object: alert);

        if(parentViewName == "Registro"){
            AnalyticsInteractionSingleton.sharedInstance.ADBTrackViewRecoveryPass(viewName: "Recuperar contrasena|Terminos y condiciones", detenido: false)
            AnalyticsInteractionSingleton.sharedInstance.ADBTrackCustomLink(viewName: "Registro|Paso 1|Ingresar datos:Terminos y condiciones")
        }
        
    }
    
}
