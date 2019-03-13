//
//  alertRegistryAndEditPaswordVC.swift
//  mcaUtilsiOS
//
//  Created by Benjamin Velazquez Valtierra on 3/7/19.
//  Copyright © 2019 Roberto. All rights reserved.
//

import UIKit

public class NoticeRegistryAndEditPaswordView: UIView {

    public let mywindow = UIWindow(frame: UIScreen.main.bounds)
    let headerView = UIHeaderForm3()
    var btnNoticeNextRedAction : RedBackgroundButton!
    var btnNoticeCloseAction : GreenBorderWhiteBackgroundButton!
    let heightButton : CGFloat = 40
    var txtBtnNoticeNextRedAction: String = ""
    var txtBtnNoticeCloseAction: String = ""
    var view = UIView()
    public var delegate : NoticeRegistryAndEditPaswordVCDelegate!
    var heightView: CGFloat = 0
    
    override init(frame: CGRect){
        super.init(frame: frame)
        commonInit()
        
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    
    public func commonInit(){
        
        self.view.frame = CGRect(x: 0, y: 0, width: self.mywindow.frame.width, height: mywindow.frame.height/2)
        self.addSubview(view)
        
        headerView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.mywindow.frame.height * 0.35)
        self.view.addSubview(headerView)
        
        btnNoticeNextRedAction = RedBackgroundButton(textButton: "Next")
        btnNoticeNextRedAction.frame = CGRect(x: 20, y: headerView.frame.maxY + 45, width: self.view.frame.width - 40, height: heightButton)
        btnNoticeNextRedAction.titleLabel?.font = UIFont(name: RobotoFontName.RobotoRegular.rawValue, size: CGFloat(16))
        btnNoticeNextRedAction.addTarget(self, action: #selector(nextAction), for: UIControlEvents.touchUpInside)
        self.view.addSubview(btnNoticeNextRedAction)
        
        btnNoticeCloseAction = GreenBorderWhiteBackgroundButton(textButton: "Close")
        btnNoticeCloseAction.addTarget(self, action: #selector(closeAction), for: UIControlEvents.touchUpInside)
        btnNoticeCloseAction.frame = CGRect(x: 20, y: btnNoticeNextRedAction.frame.maxY + 15, width: self.view.frame.width - 40, height: heightButton)
        self.view.addSubview(btnNoticeCloseAction)
    }
    
    public func configure(imageName: String, title: String, subTitle: String, hiddenBtnNoticeNext: Bool, textNoticeNextButton:String?, hiddenBtnNoticeClose: Bool, textNoticeCloseButton: String?){
        
        
        self.headerView.setupElements(imageName: imageName, title: title, subTitle: subTitle)
        self.headerView.colorTextSetupElements(colorTitle: institutionalColors.claroBlackColor, colorSubtitle: nil)
        
        self.txtBtnNoticeNextRedAction = textNoticeNextButton ?? txtBtnNoticeNextRedAction
        self.txtBtnNoticeCloseAction = textNoticeCloseButton ?? txtBtnNoticeCloseAction
        
        self.btnNoticeNextRedAction.setTitle(txtBtnNoticeNextRedAction, for: .normal)
        self.btnNoticeNextRedAction.isHidden = hiddenBtnNoticeNext
        
        self.btnNoticeCloseAction.setTitle(txtBtnNoticeCloseAction, for: .normal)
        self.btnNoticeCloseAction.isHidden = hiddenBtnNoticeClose
        
        let headerViewHeight = self.headerView.frame.height
        let btnNoticeNextRedActionHeight = self.btnNoticeNextRedAction.frame.height
        let btnNoticeCloseActionHeight = self.btnNoticeCloseAction.frame.height
        
        heightView = headerViewHeight + btnNoticeNextRedActionHeight + btnNoticeCloseActionHeight + 30
        
        self.view.frame.size = CGSize(width: mywindow.frame.width, height: heightView)
        
    }
    
    func nextAction(){
        self.delegate.delNextActionVC!()
    }
    
    func closeAction(){
        self.delegate.delCloseActionVC!()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

@objc public protocol NoticeRegistryAndEditPaswordVCDelegate: class{
    @objc optional func delNextActionVC()
    @objc optional func delCloseActionVC()
}
