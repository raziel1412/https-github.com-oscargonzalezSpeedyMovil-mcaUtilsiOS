//
//  CustomNavigationBar.swift
//  MiClaro
//
//  Created by Mauricio Javier Perez Flores on 26/07/17.
//  Copyright © 2017 am. All rights reserved.
//
import UIKit
import Cartography
import SidebarOverlay

/// Tipo de NavigationBar
public enum ButtonNavType {
    case None
    case IconBack
    case IconMenu
}

/// Esta clase permite realizar customizaciones del Navigation Bar a partir de los parámetros proporcionados en el constructor
public extension UIViewController  {
    
    public func rightButtonAction() {
        print("right button action")
    }
    
    public func leftButtonAction() {
        print("left button action")
        self.navigationController?.popViewController(animated: true)
    }
    
    func openMenu() {
//        AnalyticsInteractionSingleton.sharedInstance.ADBTrackCustomLink(viewName: "General:Menu")
//        if let container = self.so_containerViewController {
//            self.view.endEditing(true);
//            container.isSideViewControllerPresented = true
//            AnalyticsInteractionSingleton.sharedInstance.ADBTrackView(viewName: "Menu", detenido: false)
//        }
//        GeneralAlerts
//        NotificationCenter.default.post(name: Notification.Name("refreshTipoPago"), object: nil);
    }
    
    /// El constructor permite customizar el NavigationBar dependiendo del valor de navigationType
    /// -param:
    ///     - navigationType : enum navType
    public func initWith(navigationType: ButtonNavType, backToMain: Bool = false, headerTitle: String, rightButtontitle: String = "", leftButtonTitle: String = "", isLogged: Bool = false) {
        
        let logoId = -1
        let customfont: UIFont = UIFont(name: RobotoFontName.RobotoMedium.rawValue, size: CGFloat(18)) ?? UIFont()
        let iconBack = mcaUtilsHelper.getImage(image: "ico_back")
        let iconLogo = mcaUtilsHelper.getImage(image: "ico_logo")
        
        switch navigationType {
            
        case .None:
            self.navigationController?.setNavigationBarHidden(true, animated: true)
            break
        case .IconBack:
            var iconLeftBtn = iconBack
            let iconRightBtn = UIImageView(image: iconLogo)
            
            iconRightBtn.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width * 0.144, height: 44.0)
            iconRightBtn.contentMode = .scaleAspectFit
            iconRightBtn.clipsToBounds = true
            
            let leftCustomView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 24.0, height: 44.0))
            let rightButton = UIBarButtonItem(customView: iconRightBtn)
            let leftButton = UIBarButtonItem(customView: leftCustomView)
            let leftCustomButton = UIButton.init(type: .custom)
            iconLeftBtn = iconBack
            leftCustomButton.setBackgroundImage(iconLeftBtn, for: .normal)
            leftCustomButton.addTarget(self, action: #selector(leftButtonAction), for: .touchUpInside)
            leftCustomButton.frame = CGRect(x: leftCustomView.frame.size.width * 0.053, y: 0, width: 24.0, height: 24.0)
            leftCustomButton.center.y = leftCustomView.center.y
            leftCustomView.addSubview(leftCustomButton)
            let marginX = CGFloat(leftCustomButton.frame.maxX + 16.0)
            let label = UILabel(frame: CGRect(x: marginX, y: 0.0, width: self.view.frame.width - marginX, height: 0.35 * 44))
            label.text = headerTitle
            label.textColor = institutionalColors.claroRedColor
            label.textAlignment = NSTextAlignment.left
            label.font = UIFont.init(name: RobotoFontName.RobotoMedium.rawValue, size: 18.0);
            label.backgroundColor = UIColor.clear
            label.adjustsFontSizeToFitWidth = true
            label.sizeToFit()
            leftButton.tintColor = institutionalColors.claroRedColor
            let leftTitle = UIBarButtonItem(customView: label)
            self.navigationItem.leftBarButtonItems = [leftButton, leftTitle]
            self.navigationItem.rightBarButtonItem = rightButton
            self.navigationController?.setNavigationBarHidden(false, animated: true)
            if let bkg = self.navigationController?.view.viewWithTag(logoId){
                bkg.removeFromSuperview();
            }
            self.navigationController?.navigationBar.barTintColor = institutionalColors.claroPlecaColor
            self.navigationController?.navigationBar.tintColor = institutionalColors.claroRedColor
            break
        case .IconMenu:
            let attributes = [NSFontAttributeName: UIFont.fontAwesome(ofSize: 20),
                              NSForegroundColorAttributeName : institutionalColors.claroRedColor] as [String: Any]
            let menuButton = UIBarButtonItem();
            menuButton.style = .plain;
            menuButton.setTitleTextAttributes(attributes, for: .normal)
            menuButton.setTitleTextAttributes(attributes, for: .selected)
            menuButton.image = UIImage(named: "ico_")
            menuButton.target = self;
            menuButton.action = #selector(self.leftButtonAction)
            self.navigationItem.setLeftBarButton(menuButton, animated: true);
            
            let marginX = CGFloat(32 + 20)
            
            let label = UILabel(frame: CGRect(x: marginX, y: 12.0, width: 180.0, height: 21))
            label.text = headerTitle
            label.textColor = institutionalColors.claroRedColor
            label.textAlignment = NSTextAlignment.left
            label.font = customfont
            label.backgroundColor = UIColor.clear
            label.frame = CGRect(x: 0, y: 0.0, width: self.view.frame.width - 40 * 2, height: 0.35 * 44)
            self.navigationItem.titleView = label
            
            self.navigationController?.setNavigationBarHidden(false, animated: true)
            if let bkg = self.navigationController?.view.viewWithTag(logoId){
                bkg.removeFromSuperview();
            break
            }
        }
    }
    
    /// Get distance from top, based on status bar and navigation
    public var topDistance : CGFloat{
        get{
            if self.navigationController == nil{
                return 0
            }else{
                let barHeight=self.navigationController?.navigationBar.frame.height ?? 0
                let statusBarHeight = UIApplication.shared.isStatusBarHidden ? CGFloat(0) : UIApplication.shared.statusBarFrame.height
                return barHeight + statusBarHeight
            }
        }
    }
    
    public func indexSelected(selected:Int) {
        print("selected at extension: ()")
    }
    
}

