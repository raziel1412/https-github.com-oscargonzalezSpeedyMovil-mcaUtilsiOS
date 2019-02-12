//
//  WebViewController.swift
//  MiClaro
//
//  Created by Jonathan Abimael Cruz Orozco on 21/08/17.
//  Copyright © 2017 am. All rights reserved.
//

import UIKit

extension WebView: UIWebViewDelegate {

    /// Sirve para mostrar el cuadro de loader al momento de iniciar la descarga del recurso externo
    open func webViewDidStartLoad(_ webView: UIWebView) {
        Observers.ShowWaitDialog(userEnabled: false)
    }

    /// Sirve para ocultar el cuadro de loader al momento de terminar satisfactoriamente la descarga del recurso externo
    open func webViewDidFinishLoad(_ webView: UIWebView) {
        Observers.HideWaitDialog()
        let myFontScript = String(format: "document.getElementsByTagName('body')[0].style.fontFamily='%@'", RobotoFontName.RobotoRegular.rawValue);
        self.stringByEvaluatingJavaScript(from: myFontScript);
    }

    /// Sirve para ocultar el cuadro de loader al momento de terminar la descarga del recurso externo, pero se produjo un error
    open func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        Observers.HideWaitDialog()
    }
}
