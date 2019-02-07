//
//  GenericWebViewVC.swift
//  MiClaro
//
//  Created by Mauricio Javier Perez Flores on 8/4/17.
//  Copyright © 2017 am. All rights reserved.
//

import UIKit
import SafariServices
import Foundation
import khenshin

/// Clase que hace uso del WebView para mostrar contenidos de páginas
class GenericWebViewVC: UIViewController, UIWebViewDelegate {
  
    /// WebView
    var webView: WebView!
    /// Indicador de uso
    var indicatorView: UIActivityIndicatorView!
    var fromMenu : Bool = false
    var information: GenericWebViewModel!
    var viewAlert = CustomView()
    
    
    class func show( navController: UINavigationController?, info: GenericWebViewModel!) {
        let genericWebView = GenericWebViewVC()
        genericWebView.information = info
        navController?.pushViewController(genericWebView, animated: true)
    }

    ///Carga inicial, seteo de variables RUR, Email Url, y carga de la WebView
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
        
        view.backgroundColor = institutionalColors.claroWhiteColor
        self.setNavigationBar()
        
        let url = urlToShow()
        webView = WebView(url: url.url, frame: CGRect(x: self.view.frame.origin.x, y: /*self.view.frame.origin.y*/ 0.0, width: self.view.frame.width, height: self.view.frame.height /*- 70.0*/), method: url.method, body: url.body)
        
        webView.backgroundColor = UIColor.clear
        //webView.loadRequest(getUrlRequest())
        webView.scrollView.isScrollEnabled = true
        webView.scalesPageToFit = true
        self.webView.delegate = self
        view.addSubview(webView)
        
        viewAlert = CustomView.init(frame: CGRect(x: self.view.frame.origin.x, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        viewAlert.khipuSuccess = information.khipuSuccess
        viewAlert.khipuFail = information.khipuFail
        viewAlert.backgroundColor = UIColor.white
        
        indicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        //        indicatorView.startAnimating()
        GeneralAlerts.showWaitDialog()
        indicatorView.center = view.center
        webView.addSubview(indicatorView)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        GeneralAlerts.hideWaitDialog()
    }
    
    /// Función usada para obtener un URLRequest usada en el WebView
    /// - Returns: URLRequest
    /*func getUrlRequest() -> URLRequest {
     var urlRequest = URLRequest(url: URL(string: urlToShow().url)!)
     urlRequest.httpMethod = "POST"
     
     if let r = rut, let e = email {
     let bodyData = String(format: "rut=%@&email=%@", r, e)
     urlRequest.httpBody = bodyData.data(using: .utf8)
     }
     return urlRequest
     }*/
    
    /// Función que setea el navigation bar
    func setNavigationBar() {
        /*IMPORTANTE Jorge ISAI DESCOMENTAR ESA LINEA*/
        //self.initWith(navigationType: information.buttonNavType, headerTitle: information.headerTitle)
    }
    
    /// Función que permite obtener la combinación de diversas combinaciónes dependiendo del típo de URL
    /// - Returns url: String
    /// - Returns method: String
    /// - Returns body: String?
    func urlToShow() -> (url: String, method: String, body : String?) {
        var method = "GET"
        var body : String? = nil
        
        switch information.serviceSelected {
        case .BillingPayment?:
            method = "POST"
            if let r = information.rut, let e = information.email {
                body = String(format: "rut=%@&email=%@", r, e)
            }
            break
        case .ScheduleCAC?:
            method = "GET"
            information.loadUrl = (information.loadUrl ?? "https://reservaweb.clarochile.cl/agenda/asp/par_sel.asp").replacingOccurrences(of: " ", with: "") + "?rut=\(information.rut!)&correo=\(information.email!)&nombre=\(information.name!)&tiempo=\(10)"
            break
        case.HoursCAC?:
            method = "POST"
            if let r = information.rut, let e = information.email {
                let complettUrl = String(format: "rut=%@&correo=%@", r, e)
                body = complettUrl
            }
        default:
            break
        }
        print("BODY\(String(describing: body))")
        return (information.loadUrl ?? "", method, body)
    }
    
    /// Función que determina cuando el WebView ha terminado de cargar
    /// - parameter webView: UIWebView
    func webViewDidFinishLoad(_ webView: UIWebView) {
        indicatorView.stopAnimating()
        GeneralAlerts.hideWaitDialog()
    }
    
    /// Función que permite ordenar cuando cargar una URL
    /// - parameter webView: UIWebView
    /// - parameter request: URLRequest
    /// - parameter navigationType: UIWebViewNavigationType
    /// - Returns: Bool
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        if request.url?.absoluteString.range(of:"khipu.com/payment") != nil {
            print("exists")
            //            let mySubstring = request.url?.absoluteString.prefix(41)
            let mySubstring = String((request.url?.absoluteString.suffix(12))!) // playground
            print(mySubstring)
            //"dujA9hJmIWa6JGkXgIG4"
            KhenshinInterface.startEngine(withPaymentExternalId: mySubstring , userIdentifier:"", isExternalPayment: true, success: { (exitURL: URL?) in
                NSLog("SUCCESS")
                self.viewAlert.setIconAndText(isSuccess: true)
                self.view.addSubview(self.viewAlert)
            }, failure: { (exitURL: URL?) in
                NSLog("FAILURE")
                self.viewAlert.setIconAndText(isSuccess: false)
                self.view.addSubview(self.viewAlert)
            }, animated: false)
        }
        if request.url?.absoluteString == information.reloadUrlSuccess || request.url?.absoluteString == information.paidUrlSucces {
            webView.stopLoading()
            webView.removeFromSuperview()
        }
        
        return true
    }
    
    
    
    /// Alerta de insuficiencia de memoria
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        indicatorView.stopAnimating()
        webView.stopLoading()
    }
}

class CustomView: UIView {
    var label: UILabel = UILabel()
    var icono : UIImageView?
    var superFrame : CGRect = CGRect()
    var khipuSuccess: String = ""
    var khipuFail: String = ""
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        superFrame = frame
        self.addCustomView()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setIconAndText(isSuccess: Bool){
        if isSuccess{
            self.icono?.image = UIImage(named: "ico_alerta_ok")
            label.text = self.khipuSuccess
        }else{
            self.icono?.image = UIImage(named: "ico_alerta_error")
            label.text = self.khipuFail
        }
    }
    
    func addCustomView() {
        
        self.icono = UIImageView()
        self.icono?.image = UIImage(named: "ico_alerta_ok")
        self.icono?.frame = CGRect(x: (self.frame.size.width - 120) / 2, y: 10, width: 120, height: 120)
        self.addSubview(self.icono!);
        
        label.frame = CGRect(x: (self.frame.size.width - 280) / 2, y: (self.icono?.frame.maxY)!, width: 280, height: 100)
        label.backgroundColor=UIColor.white
        label.textAlignment = NSTextAlignment.center
        label.text = ""
        
        label.font = UIFont(name: RobotoFontName.RobotoBold.rawValue, size: CGFloat(20))
        label.textColor = institutionalColors.claroBlackColor
        label.textAlignment = .center
        label.backgroundColor = UIColor.clear
        label.lineBreakMode = .byWordWrapping;
        label.numberOfLines = 0;
        self.addSubview(label)
        
        let btn: UIButton = UIButton()
        btn.frame = CGRect(x:(self.frame.size.width - 200) / 2, y: label.frame.maxY, width: 200, height: 40)
        btn.setTitle("Volver a Inicio", for: UIControlState.normal)
        btn.titleLabel?.font = UIFont(name: RobotoFontName.RobotoBold.rawValue, size: CGFloat(16))
        btn.setTitleColor(institutionalColors.claroBlueColor, for: UIControlState.normal)
        btn.setTitleColor(institutionalColors.claroBlueColor, for: UIControlState.selected)
        btn.layer.borderColor = institutionalColors.claroBlueColor.cgColor
        btn.layer.borderWidth = 1;
        btn.layer.cornerRadius = 2
        btn.addTarget(self,
                      action: #selector(goToHome),
                      for: UIControlEvents.touchUpInside)
        self.addSubview(btn)
        
    }
    
    func goToHome() {
        NotificationCenter.default.post(name: Notification.Name("initializeHome"), object: nil)
    }
}

