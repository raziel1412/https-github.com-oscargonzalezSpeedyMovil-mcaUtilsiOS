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
        /*IMPORTANTE ISAI DESCOMENTAR ESA LINEA*/
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
            }, failure: { (exitURL: URL?) in
                NSLog("FAILURE")
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
