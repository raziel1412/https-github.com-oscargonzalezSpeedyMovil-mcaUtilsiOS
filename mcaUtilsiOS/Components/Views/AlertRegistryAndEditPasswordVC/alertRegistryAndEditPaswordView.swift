//
//  alertRegistryAndEditPaswordView.swift
//  mcaUtilsiOS
//
//  Created by Benjamin Velazquez Valtierra on 3/7/19.
//  Copyright © 2019 Roberto. All rights reserved.
//

import UIKit

public class alertRegistryAndEditPaswordView: UIView {
    
    public let mywindow = UIWindow(frame: UIScreen.main.bounds)
    let shadowContent = UIView()
    let headerView = UIHeaderForm3()
    var btnAlertContinue : RedBackgroundButton!
    var btnAlertClose : GreenBorderWhiteBackgroundButton!
    let container = UIView()
    var txtBtnAlertContinue: String = ""
    var txtBtnAlertClose: String = ""
    let heightButton: CGFloat = 40
    var font: UIFont = UIFont(name: RobotoFontName.RobotoBold.rawValue, size: 17)!
    var heightView : CGFloat = 0
    public var delegate: alertRegistryAndEditPaswordViewDelegate!
    
    override init(frame: CGRect){
        super.init(frame: frame)
        commonInit()
        
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    public func configure(imageName: String, title: String, subTitle: String, hiddenBtnAlertContinue: Bool, textAlertContinueButton:String?, hiddenBtnAlertClose: Bool, textAlertCloseButton: String?){
        
        self.headerView.setupElements(imageName: imageName, title: title, subTitle: subTitle)
        self.headerView.colorTextSetupElements(colorTitle: institutionalColors.claroBlackColor, colorSubtitle: nil)
        
        self.txtBtnAlertContinue = textAlertContinueButton ?? txtBtnAlertContinue
        self.txtBtnAlertClose = textAlertCloseButton ?? txtBtnAlertClose
        
        self.btnAlertContinue.setTitle(txtBtnAlertContinue, for: .normal)
        self.btnAlertContinue.isHidden = hiddenBtnAlertContinue
        
        self.btnAlertClose.setTitle(txtBtnAlertClose, for: .normal)
        self.btnAlertClose.isHidden = hiddenBtnAlertClose
        
        let headerHeight = self.headerView.frame.height
        let btnAlertContinueHeight = self.btnAlertContinue.frame.height
        let btnAlertCloseHeight = self.btnAlertClose.frame.height
        self.heightView = headerHeight + btnAlertContinueHeight + btnAlertCloseHeight + 30
        
        self.container.frame.size = CGSize(width: 288, height:heightView)
        
    }
    
    func commonInit(){
//        Bundle.main.loadNibNamed("alertRegistryAndEditPaswordView", owner: self, options: nil)
        shadowContent.frame = mywindow.bounds
        shadowContent.backgroundColor = institutionalColors.claroBlackColor.withAlphaComponent(0.6)
        self.addSubview(shadowContent)
        
        container.center = self.shadowContent.center
        container.frame.size = CGSize(width: 288, height: 306)
        container.center = self.shadowContent.center
        container.backgroundColor = institutionalColors.claroWhiteColor
        shadowContent.addSubview(container)
        
        headerView.frame = CGRect(x: 0, y: 0, width: container.frame.width, height: 200)
        container.addSubview(headerView)
        
        btnAlertContinue = RedBackgroundButton(textButton: "Next")
        btnAlertContinue.frame = CGRect(x: 20, y: headerView.frame.maxY + 10, width: self.container.frame.width - 40, height: heightButton)
        btnAlertContinue.titleLabel?.font = UIFont(name: RobotoFontName.RobotoRegular.rawValue, size: CGFloat(16))
        btnAlertContinue.addTarget(self, action: #selector(nextAction), for: UIControlEvents.touchUpInside)
        container.addSubview(btnAlertContinue)
        
        btnAlertClose = GreenBorderWhiteBackgroundButton(textButton: "Close")
        btnAlertClose.addTarget(self, action: #selector(closeAction), for: UIControlEvents.touchUpInside)
        btnAlertClose.frame = CGRect(x: 20, y: btnAlertContinue.frame.maxY + 10, width: self.container.frame.width - 40, height: heightButton)
        
        container.addSubview(btnAlertClose)

        
    }
    
    func nextAction(){
        self.delegate.delNextAction!()
    }
    
    func closeAction(){
        self.delegate.delCloseAction!()
    }

}

@objc public protocol alertRegistryAndEditPaswordViewDelegate: class {
    @objc optional func delNextAction()
    @objc optional func delCloseAction()
}
