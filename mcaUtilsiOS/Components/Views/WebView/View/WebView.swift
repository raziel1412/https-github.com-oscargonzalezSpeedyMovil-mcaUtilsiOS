//
//  WebView.swift
//  MiClaro
//
//  Created by Jonathan Abimael Cruz Orozco on 21/08/17.
//  Copyright © 2017 am. All rights reserved.
//

import UIKit

class WebView: UIWebView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    /// Constructor del componente webView
    /// - Parameter url: URL a consultar
    /// - Parameter frame: Tamaño del componente webView
    init(url: String, frame: CGRect, method: String = "GET", body : String? = nil) {
        super.init(frame: frame)
        let url = url.addingPercentEncoding( withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
        if let urlWeb = URL(string: url!) {
            self.delegate = self
            var request = URLRequest(url: urlWeb , cachePolicy: NSURLRequest.CachePolicy.reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 60.0)
            request.httpMethod = method
            if method == "POST", body != nil {
                request.httpBody = body!.data(using: .utf8)
            }
            self.loadRequest(request)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
