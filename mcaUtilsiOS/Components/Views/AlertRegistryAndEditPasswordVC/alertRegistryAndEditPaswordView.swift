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
    let headerView = UIHeaderForm()
    var btnAlertContinue : RedBackgroundButton!
    var btnAlertClose : GreenBorderWhiteBackgroundButton!
    let container = UIView()
    var txtBtnAlertContinue: String = ""
    var txtBtnAlertClose: String = ""
    let heightButton: CGFloat = 40
    var font: UIFont = UIFont(name: RobotoFontName.RobotoBold.rawValue, size: 17)!
    
    override init(frame: CGRect){
        super.init(frame: frame)
        commomInit()
        
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commomInit()
    }
    
    public func configure(imageName: String, title: String, subTitle: String, hiddenBtnAlertContinue: Bool, textAlertContinueButton:String?, hiddenBtnAlertClose: Bool, textAlertCloseButton: String?){
        
        headerView.setupElements(imageName: imageName, title: title, subTitle: subTitle)
        
        txtBtnAlertContinue = textAlertContinueButton ?? txtBtnAlertContinue
        txtBtnAlertClose = textAlertCloseButton ?? txtBtnAlertClose
        
        btnAlertContinue.setTitle(txtBtnAlertContinue, for: .normal)
        btnAlertContinue.isHidden = hiddenBtnAlertContinue
        
        btnAlertClose.setTitle(txtBtnAlertClose, for: .normal)
        btnAlertClose.isHidden = hiddenBtnAlertClose
        
        if (hiddenBtnAlertContinue || hiddenBtnAlertClose){
            container.frame.size = CGSize(width: 288, height: container.bounds.height - heightButton + 10)
        } else if (hiddenBtnAlertContinue && hiddenBtnAlertClose) {
            container.frame.size = CGSize(width: 288, height: container.bounds.height - heightButton + 10)
        } else {
            container.frame.size = CGSize(width: 288, height: 306)
        }
    }
    
    func commomInit(){
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
        btnAlertContinue.addTarget(self, action: #selector(self.nextAction), for: UIControlEvents.touchUpInside)
        container.addSubview(btnAlertContinue)
        
        btnAlertClose = GreenBorderWhiteBackgroundButton(textButton: "Close")
        btnAlertClose.addTarget(self, action: #selector(self.closeAction), for: UIControlEvents.touchUpInside)
        btnAlertClose.frame = CGRect(x: 20, y: btnAlertContinue.frame.maxY + 10, width: self.container.frame.width - 40, height: heightButton)
        
        container.addSubview(btnAlertClose)
        
    }
    
    func nextAction(){
        
    }
    
    func closeAction(){
        
    }

}
