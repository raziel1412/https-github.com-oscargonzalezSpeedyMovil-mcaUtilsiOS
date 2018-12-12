//
//  mcaUtilsHelper.swift
//  mcaUtilsiOS
//
//  Created by Pilar del Rosario Prospero Zeferino on 11/27/18.
//  Copyright © 2018 Roberto. All rights reserved.
//

import UIKit

public class mcaUtilsHelper: NSObject {
    
    public class func refreshConfigurationFile() {
        UIResponder.upgradeConfigurationFile()
    }
    
    /// Función usada para setear datos al UserDefaults
    /// - parameter data: Bool
    /// - parameter toKey: String
    public class func setDefaults(data: Bool, toKey: String) {
        let defaults = UserDefaults.standard
        defaults.set(data, forKey: toKey)
        defaults.synchronize()
    }
    /// Función usada para setear datos al UserDefaults
    /// - parameter string: String
    /// - parameter toKey: String
    public class func setDefaults(string: String?, toKey: String) {
        let defaults = UserDefaults.standard
        defaults.set(string, forKey: toKey)
        defaults.synchronize()
    }
    /// Función usada para obtener datos del UserDefaults
    /// - parameter toKey: String
    /// - Returns: Any?
    public class func getDefaults(toKey: String) -> Any? {
        let defaults = UserDefaults.standard
        return defaults.object(forKey: toKey)
    }
    
    public class func getImage(image: String) -> UIImage {
        let bundle = Bundle(identifier: mcaUtilsConstants.BUNDLE_IDENTIFIER)
        if let aImage = UIImage(named: image, in: bundle, compatibleWith: nil) {
            return aImage
        }
        return UIImage()
    }
    
    public class func initCustomFonts() {
        UIFont.loadAllFonts
    }
    
    public class func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        return resizeImageP(image: image, targetSize: targetSize)
    }
    
    public class func checkImageExists(fileName: String) -> Bool{
        return checkImageExistsP(fileName: fileName)
    }
    
    public class func initGenericWebView(navController: UINavigationController?, info: GenericWebViewModel!) {
        GenericWebViewVC.show(navController: navController, info: info)
    }
    
    public class func getGoogleAPIKey() -> String{
        return mcaUtilsConstants.GOOGL_API_KEY
    }
    
    class func getLocalized(key: String) -> String{
        let s =  NSLocalizedString(key, tableName: nil, bundle: Bundle(identifier: mcaUtilsConstants.BUNDLE_IDENTIFIER) ?? Bundle(for: mcaUtilsHelper.self), value: key, comment: "")
        return s
    }
}
