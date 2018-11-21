//
//  Extension + UIViewController.swift
//  MiClaro
//
//  Created by Fernando Rodriguez Minguet on 06/03/18.
//  Copyright © 2018 am. All rights reserved.
//

import Foundation
import UIKit
import Cartography
/*
/// Extensión UIViewController
extension UIViewController {
    
    /// Función usada para setear datos al UserDefaults
    /// - parameter data: Bool
    /// - parameter toKey: String
    func setDefaults(data: Bool, toKey: String) {
        let defaults = UserDefaults.standard
        defaults.set(data, forKey: toKey)
    }
    
    /// Función usada para obtener datos del UserDefaults
    /// - parameter toKey: String
    /// - Returns: Any?
    func getDefaults(toKey: String) -> Any? {
        let defaults = UserDefaults.standard
        return defaults.object(forKey: toKey)
    }
    
    /// Función que permite agregar una TabBar con los elementos de cuentas y soporte
    /// - parameter selectedIndex : Int, Índice actual del TabBar, por defecto es -1 (nínguno seleccionado)
    /// - parameter lockIndex: Int, Índice de bloqueo,  por defecto es -1 (nínguno)
    /// - Returns CGRect: Propiedades de dimensaiones del Fake TabBar
    func addFakeTabBar(selectedIndex : String, lockIndex : Int = -1, posY: CGFloat = -1) -> CGRect {
        let config = SessionSingleton.sharedInstance.getGeneralConfig();
        let yPosition = self.view.frame.height < 812 ? self.view.bounds.height - 50 : self.view.bounds.height - 100
        let tabBarView = UIView(frame: CGRect(x: 0, y: yPosition - (self.navigationController?.navigationBar.frame.height)! - 20, width: self.view.bounds.width, height: 80))
        if self.view.frame.height >= 812 || posY != -1 {
            tabBarView.backgroundColor = institutionalColors.claroWhiteColor
        } else {
            tabBarView.backgroundColor = institutionalColors.claroToolBarColor
        }
        tabBarView.alpha = 1.0
        tabBarView.tag = 812
        print(tabBarView.frame)
        
        if posY != -1 {
            tabBarView.frame = CGRect(x: 0, y: posY, width: self.view.bounds.width, height: 50)
        }
        
        let bar = UIView(frame: CGRect(x: 0, y: 0, width: tabBarView.frame.width , height: 0.4))
        if self.view.frame.height >= 812 {
            bar.backgroundColor = .lightGray
        }

        tabBarView.addSubview(bar)
        let widthView = tabBarView.frame.width
        let viewImg = widthView * 0.25

        if var tabConfig = config?.bottomMenu?.nodes {
            
             tabConfig.sort(by: {Int($0.order ?? "0")! < Int($1.order ?? "0")!})
            
            let imgNormalHome = UIImage(named: "icon_inicio_off_navbar")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal);
            let imgSelectedHome = UIImage(named: "icon_inicio_on_navbar")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal);

            let imgNormalBoletas = UIImage(named: "icon_boleta_off_navbar")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal);
            let imgSelectedBoletas = UIImage(named: "icon_boleta_on_navbar")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal);

            let imgNormalRecarga = UIImage(named: "icon_recarga_off_navbar")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal);
            let imgSelectedRecarga = UIImage(named: "icon_recarga_on_navbar")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal);

            let imgNormalAyuda = UIImage(named: "ico_soporte_off_navbar")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal);
            let imgSelectedAyuda = UIImage(named: "ico_soporte_on_navbar")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal);

            let imgNormalContrataciones = UIImage(named: "icon_contratar_off_navbar")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal);
            let imgSelectedContrataciones = UIImage(named: "icon_contratar_on_navbar")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal);

            var lastContainer = UIView();
            for item in tabConfig {
                if ("1" != item.status){
                    continue;
                }

                let currentContainer = UIView();
                currentContainer.frame = CGRect(x: lastContainer.frame.maxX, y: 3, width: viewImg, height: 49);

                let lbl = UILabel()
                lbl.font = UIFont(name: RobotoFontName.RobotoRegular.rawValue, size: 11)
                lbl.text = item.text
                lbl.textColor = institutionalColors.claroLightGrayColor

                let imgView = UIImageView();
                currentContainer.addSubview(lbl);
                currentContainer.addSubview(imgView);
                tabBarView.addSubview(currentContainer);

                constrain(currentContainer, imgView, lbl, currentContainer) { cont, img, lbl, view in
                    img.top == view.top + 5
                    img.centerX == cont.centerX
                    img.height == 24
                    img.width == 24
                    lbl.centerX == img.centerX
                    lbl.top == img.bottom + 5
                }

                switch item.code! {
                // Home
                case "home":
                    let gestureHome = UITapGestureRecognizer(target: self, action:#selector(goAccounts))
                    currentContainer.addGestureRecognizer(gestureHome);
                    imgView.image = selectedIndex == item.code! ? imgSelectedHome : imgNormalHome;
                    break;

                // Boletas
                case "billing":
                    let gestureBoletas = UITapGestureRecognizer(target: self, action:#selector(goTicket))
                    currentContainer.addGestureRecognizer(gestureBoletas)
                    imgView.image = selectedIndex == item.code! ? imgSelectedBoletas : imgNormalBoletas;
                    break;

                // Recargar
                case "prepaid":
                    let gestureRecarga = UITapGestureRecognizer(target: self, action:#selector(goReload))
                    currentContainer.addGestureRecognizer(gestureRecarga)
                    imgView.image = selectedIndex == item.code! ? imgSelectedRecarga : imgNormalRecarga;
                    break;

                // Soporte
                case "help":
                    let gestureAyuda = UITapGestureRecognizer(target: self, action:#selector(goService))
                    currentContainer.addGestureRecognizer(gestureAyuda)
                    imgView.image = selectedIndex == item.code! ? imgSelectedAyuda : imgNormalAyuda;
                    break;

                // Contrataciones
                case "click2Buy":
                    let gestureContrataciones = UITapGestureRecognizer(target: self, action:#selector(goHiring))
                    currentContainer.addGestureRecognizer(gestureContrataciones)
                    imgView.image = selectedIndex == item.code! ? imgSelectedContrataciones : imgNormalContrataciones;
                    break;

                default:
                    imgView.image = nil;
                    currentContainer.gestureRecognizers?.removeAll();
                    break;
                }
                lastContainer = currentContainer;
            }

            let divisor = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 1))
            divisor.backgroundColor = .black
            tabBarView.addSubview(divisor)
            constrain(divisor, tabBarView) { div, tab in
                div.bottom == tab.top
            }

        }
        self.view.addSubview(tabBarView)
        return tabBarView.frame
    }

    /// Función que realiza la navegación al ContainerVC()
    func goAccounts() {
        UIApplication.shared.keyWindow?.rootViewController  = ContainerVC();
    }
  
    func goTicket() {
        if(!SessionSingleton.sharedInstance.getDigitalBirth()! && showModal == false){
            let vcTicket = MenuTickets()
            let nav = UINavigationController(rootViewController: vcTicket);
            nav.navigationBar.layer.shadowColor = institutionalColors.claroLightGrayColor.cgColor;
            nav.navigationBar.layer.shadowOpacity = 0.8;
            nav.navigationBar.layer.shadowOffset = CGSize(width: 0, height: 2);
            nav.navigationBar.layer.shadowRadius = 2;
            self.so_containerViewController?.topViewController = nav;
        }
    }

  func goReload() {
        if(!SessionSingleton.sharedInstance.getDigitalBirth()! && showModal == false){
            goToWebView(action: "reload")
        }
    }
    
    func goToWebView(action: String) {
        if false == SessionSingleton.sharedInstance.isNetworkConnected() {
            NotificationCenter.default.post(name: Observers.ObserverList.ShowOfflineMessage.name, object: nil);
            return;
        }
        if(!SessionSingleton.sharedInstance.getDigitalBirth()! && showModal == false){
            let webView2 = GenericWebViewVC()
            webView2.fromMenu = true
            webView2.serviceSelected = action
            let nav = UINavigationController(rootViewController: webView2);
            nav.navigationBar.layer.shadowColor = institutionalColors.claroLightGrayColor.cgColor;
            nav.navigationBar.layer.shadowOpacity = 0.8;
            nav.navigationBar.layer.shadowOffset = CGSize(width: 0, height: 2);
            nav.navigationBar.layer.shadowRadius = 2;
            self.so_containerViewController?.topViewController = nav;
        }
    }
    
    /// Función que realiza la navegación al SupportVC()
    func goService() {
        if(!SessionSingleton.sharedInstance.getDigitalBirth()! && showModal == false){
            let support = SupportVC()
            let nav = UINavigationController(rootViewController: support)
            nav.navigationBar.layer.shadowColor = institutionalColors.claroLightGrayColor.cgColor;
            nav.navigationBar.layer.shadowOpacity = 0.8;
            nav.navigationBar.layer.shadowOffset = CGSize(width: 0, height: 2);
            nav.navigationBar.layer.shadowRadius = 2;
            self.so_containerViewController?.topViewController = nav;
        }
    }

    /// Función que realiza la navegación al menú de contrataciones
    func goHiring() {
        if(!SessionSingleton.sharedInstance.getDigitalBirth()! && showModal == false){
            let vcHiring = HiringMenu()
            let nav = UINavigationController(rootViewController: vcHiring);
            nav.navigationBar.layer.shadowColor = institutionalColors.claroLightGrayColor.cgColor;
            nav.navigationBar.layer.shadowOpacity = 0.8;
            nav.navigationBar.layer.shadowOffset = CGSize(width: 0, height: 2);
            nav.navigationBar.layer.shadowRadius = 2;
            self.so_containerViewController?.topViewController = nav;
        }
    }

    /// Función que realiza un recorrido de los controladores disponibles dentro del navigation controller, en la búsqueda de PasswordRecovery
    /// - Returns UIViewController? : Nil de no encontrar ninguno, PasswordRecovery de encontrarse
    func findPasswordRecoveryVC() -> UIViewController? {
        if let viewControllers = self.navigationController?.viewControllers {
            for viewController in viewControllers {
                if viewController.isKind(of: PasswordRecoveryVC.self) {
                    return viewController
                }
            }
        }
        return nil
    }
}

*/
