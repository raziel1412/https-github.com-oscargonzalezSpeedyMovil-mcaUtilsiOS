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

public struct TextNumberNotification {
    public static var labelBadg =  UILabel()
}

/// Esta clase permite realizar customizaciones del Navigation Bar a partir de los parámetros proporcionados en el constructor
extension UIViewController  {
    
    open func rightButtonAction() {
        print("right button action")
    }
    
    open func leftButtonAction() {
        print("left button action")
        self.navigationController?.popViewController(animated: true)
    }
    
    open func openNotificationCenter() {
        print("Notification btn was pressed")
        NotificationCenter.default.post(name: NSNotification.Name("goToNotificationMessageCenter"), object: nil)
    }
    
    open func openMenu() {
        let notificationAnalytics = NotificationAnalyticsModel(viewName: "General:Menu")
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "ADBTrackCustomLink"), object: notificationAnalytics)
        
        if let container = self.so_containerViewController {
            self.view.endEditing(true);
            container.isSideViewControllerPresented = true
            
            let notificationAnalytics = NotificationAnalyticsModel(viewName: "Menu", isStopped: false)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "AddTrackView"), object: notificationAnalytics)
        }
        NotificationCenter.default.post(name: Notification.Name("NotificationOpenMenu"), object: nil);
    }
    
    /// El constructor permite customizar el NavigationBar dependiendo del valor de navigationType
    /// -param:
    ///     - navigationType : enum navType
    open func initWith(navigationType: ButtonNavType, backToMain: Bool = false, headerTitle: String, rightButtontitle: String = "", leftButtonTitle: String = "", isLogged: Bool = false, enableNotificationBtn: Bool = false) {
        
        let logoId = -1
        let iconBack = mcaUtilsHelper.getImage(image: "ico_back")
        let iconLogo = mcaUtilsHelper.getImage(image: "ico_logo")
        let iconMenu = mcaUtilsHelper.getImage(image: "ico_hamburger")
        if let container = self.so_containerViewController {
            container.isSideViewControllerPresented = false
            print("mcaUtilsiOS container.IsSideViewControllerPresented settting to false")
        }
        
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
            
            ///Btn notification
            if enableNotificationBtn {
                TextNumberNotification.labelBadg = UILabel(frame: CGRect(x: 18, y: 0, width: 20, height: 20))
                TextNumberNotification.labelBadg.layer.borderColor = UIColor.clear.cgColor
                TextNumberNotification.labelBadg.layer.borderWidth = 2
                TextNumberNotification.labelBadg.layer.cornerRadius = 20 / 2
                TextNumberNotification.labelBadg.textAlignment = .center
                TextNumberNotification.labelBadg.layer.masksToBounds = true
                TextNumberNotification.labelBadg.textColor = .white
                TextNumberNotification.labelBadg.backgroundColor = institutionalColors.claroBlueColor
                
                let rightButtonNotification = UIButton(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
                let image = mcaUtilsHelper.getImage(image: "notification")
                rightButtonNotification.setImage(image.tint(with: institutionalColors.claroRedColor), for: .normal)
                rightButtonNotification.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5)
                rightButtonNotification.imageView?.contentMode = .scaleAspectFit
                rightButtonNotification.addTarget(self, action: #selector(openNotificationCenter), for: .touchUpInside)
                rightButtonNotification.addSubview(TextNumberNotification.labelBadg)
                let rightBarButtomItemNotification = UIBarButtonItem(customView: rightButtonNotification)
                
                self.navigationItem.rightBarButtonItem = nil
                self.navigationItem.rightBarButtonItems =  [rightButton, rightBarButtomItemNotification]
            } else {
                self.navigationItem.rightBarButtonItems = nil
                self.navigationItem.rightBarButtonItem =  rightButton
            }
            
            self.navigationController?.setNavigationBarHidden(false, animated: true)
            if let bkg = self.navigationController?.view.viewWithTag(logoId){
                bkg.removeFromSuperview();
            }
            self.navigationController?.navigationBar.barTintColor = institutionalColors.claroPlecaColor
            self.navigationController?.navigationBar.tintColor = institutionalColors.claroRedColor
            break
        case .IconMenu:
            /*let attributes = [NSFontAttributeName: UIFont.fontAwesome(ofSize: 20),
                              NSForegroundColorAttributeName : institutionalColors.claroRedColor] as [String: Any]
            let menuButton = UIBarButtonItem();
            menuButton.style = .plain;
            menuButton.setTitleTextAttributes(attributes, for: .normal)
            menuButton.setTitleTextAttributes(attributes, for: .selected)
            menuButton.image = UIImage(named: "ico_hamburger")
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
                bkg.removeFromSuperview();*/
            
            var iconLeftBtn = iconMenu
            let iconRightBtn = UIImageView(image: iconLogo)
            
            iconRightBtn.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width * 0.144, height: 44.0)
            iconRightBtn.contentMode = .scaleAspectFit
            iconRightBtn.clipsToBounds = true
            
            let leftCustomView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 24.0, height: 44.0))
            let rightButton = UIBarButtonItem(customView: iconRightBtn)
            let leftButton = UIBarButtonItem(customView: leftCustomView)
            let leftCustomButton = UIButton.init(type: .custom)
            iconLeftBtn = iconMenu
            leftCustomButton.setBackgroundImage(iconLeftBtn, for: .normal)
            leftCustomButton.addTarget(self, action: #selector(openMenu), for: .touchUpInside)
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
            
            ///Btn notification
            if enableNotificationBtn {
                TextNumberNotification.labelBadg = UILabel(frame: CGRect(x: 18, y: 0, width: 20, height: 20))
                TextNumberNotification.labelBadg.layer.borderColor = UIColor.clear.cgColor
                TextNumberNotification.labelBadg.layer.borderWidth = 2
                TextNumberNotification.labelBadg.layer.cornerRadius = 20 / 2
                TextNumberNotification.labelBadg.textAlignment = .center
                TextNumberNotification.labelBadg.layer.masksToBounds = true
                TextNumberNotification.labelBadg.textColor = .white
                TextNumberNotification.labelBadg.backgroundColor = institutionalColors.claroBlueColor
                
                let rightButtonNotification = UIButton(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
                let image = mcaUtilsHelper.getImage(image: "notification")
                rightButtonNotification.setImage(image.tint(with: institutionalColors.claroRedColor), for: .normal)
                rightButtonNotification.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5)
                rightButtonNotification.imageView?.contentMode = .scaleAspectFit
                rightButtonNotification.addTarget(self, action: #selector(openNotificationCenter), for: .touchUpInside)
                rightButtonNotification.addSubview(TextNumberNotification.labelBadg)
                let rightBarButtomItemNotification = UIBarButtonItem(customView: rightButtonNotification)
                
                self.navigationItem.rightBarButtonItem = nil
                self.navigationItem.rightBarButtonItems =  [rightButton, rightBarButtomItemNotification]
            } else {
                self.navigationItem.rightBarButtonItems = nil
                self.navigationItem.rightBarButtonItem =  rightButton
            }
            
            self.navigationController?.setNavigationBarHidden(false, animated: true)
            if let bkg = self.navigationController?.view.viewWithTag(logoId){
                bkg.removeFromSuperview();
            }
            self.navigationController?.navigationBar.barTintColor = institutionalColors.claroPlecaColor
            self.navigationController?.navigationBar.tintColor = institutionalColors.claroRedColor
            
            break
            
        }
    }
    
    /// Get distance from top, based on status bar and navigation
    open var topDistance : CGFloat{
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
    
}


