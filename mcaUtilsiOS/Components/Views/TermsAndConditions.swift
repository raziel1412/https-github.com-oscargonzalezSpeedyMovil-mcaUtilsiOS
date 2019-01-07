//
//  TermsAndConditions.swift
//  MiClaro
//
//  Created by Fernando Rodriguez Minguet on 30/05/18.
//  Copyright © 2018 am. All rights reserved.
//

import UIKit
import Cartography
import ReachabilitySwift

public class TermsAndConditions: UIView {
    
    public var checkBox : SquaredCheckbox = SquaredCheckbox(frame: .zero)
    private var contentLabel : LinkableLabel = LinkableLabel(frame: .zero)
    private var content : String = ""
    private var linkTextRange : NSRange?
    private var parentViewName : String = ""
    
    var url: String = ""
    var title: String = ""
    var acceptTitle: String = ""
    var offlineAction: () -> Void = {}

    public init(frame: CGRect, content: String? = nil) {
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
    /// termsConditions.setContent(String(format: "%@ <b>%@</b> %@", parte1, parte2, parte3), url: mcaManagerSession.getGeneralConfig()?.termsAndConditions?.url ?? "", title: mcaManagerSession.getGeneralConfig()?.translations?.data?.generales?.termsAndConditions ?? "", acceptTitle: mcaManagerSession.getGeneralConfig()?.translations?.data?.generales?.closeBtn ?? "", offlineAction: {mcaManagerSession.showOfflineMessage()})
    public func setContent(_ content: String, url: String, title: String, acceptTitle: String, offlineAction: @escaping () -> Void) {
        self.content = content
        contentLabel.showText(text: content)
        self.title = title
        self.url = url
        self.acceptTitle = acceptTitle
    }
    public func setParentView(_ parent: String) {
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
    
    public func setupClickDelegate(target: Any?, action: Selector?) {
        contentLabel.gestureRecognizers?.removeAll()
        contentLabel.addGestureRecognizer(UITapGestureRecognizer(target: target, action: action))
    }
    
    public var isChecked : Bool {
        return checkBox.isSelected
    }
    
    @objc public func lnkTerminos_OnClick() {
        if false == Reachability()?.isReachable {
            offlineAction()
            return
        }

        let alert = WebViewAlertData();
        alert.method = "GET";
        alert.url = url
        alert.title = title
        alert.acceptTitle = acceptTitle
        alert.onAcceptEvent = {
        }
        Observers.WebViewAlert(info: alert)
        

        if(parentViewName == "Registro"){
            
            let notificationAnalyticsRec = NotificationAnalyticsModel(viewName: "Recuperar contrasena|Terminos y condiciones")
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "ADBTrackViewRecoveryPass"), object: notificationAnalyticsRec)
            
            let notificationAnalyticsLink = NotificationAnalyticsModel(viewName: "Registro|Paso 1|Ingresar datos:Terminos y condiciones")
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "ADBTrackCustomLink"), object: notificationAnalyticsLink)
        }
        
    }
    
}
