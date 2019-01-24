//
//  ImageViewExtension.swift
//  MiClaro
//
//  Created by Jonathan Abimael Cruz Orozco on 24/08/17.
//  Copyright © 2017 am. All rights reserved.
//

import UIKit

/// Extensión UIImageView
public extension UIImageView {
    
    /// Función que permite descargar asincronamente una imagen de una URL
    /// - parameter url : URL
    /// - parameter mode : UIViewContentMode
    public func downloadedFrom(url: URL, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        contentMode = mode
        
        //        URLSession.shared.dataTask(with: url) { (data, response, error) in
        //            guard let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
        //                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
        //                let data = data, error == nil,
        //                let image = UIImage(data: data)
        //                else { return }
        //            self.image = image
        //        }.resume()
        
        DispatchQueue.main.async {
            do {
                let data = try Data(contentsOf: url);
                self.image = UIImage(data: data);
                
            } catch {
                self.image = nil;
                
            }
        }
    }
    
    /// Función que permite descargar asincronamente una imagen de una URL
    /// - parameter link : String
    /// - parameter mode : UIViewContentMode
    public func downloadedFrom(link: String, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloadedFrom(url: url, contentMode: mode)
    }
    
    /// Función que permite cargar una imágen desde una URL
    /// - parameter urlString : String
    public func imageFromServerURL(urlString: String) {
        URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in
            if error != nil {
                return
            }
            DispatchQueue.main.async(execute: { () -> Void in
                let image = UIImage(data: data!)
                self.image = image
            })
        }).resume()
    }
}

public extension UIImage {
    public convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        guard let cgImage = image?.cgImage else { return nil }
        self.init(cgImage: cgImage)
    }
    
    public func tint(with color: UIColor) -> UIImage {
        var image = withRenderingMode(.alwaysTemplate)
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        color.set()
        
        image.draw(in: CGRect(origin: .zero, size: size))
        image = UIGraphicsGetImageFromCurrentImageContext() ?? UIImage()
        UIGraphicsEndImageContext()
        return image
    }
}
