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
    }
    /// Función usada para setear datos al UserDefaults
    /// - parameter string: String
    /// - parameter toKey: String
    public class func setDefaults(string: String?, toKey: String) {
        let defaults = UserDefaults.standard
        defaults.set(string, forKey: toKey)
    }
    /// Función usada para obtener datos del UserDefaults
    /// - parameter toKey: String
    /// - Returns: Any?
    public class func getDefaults(toKey: String) -> Any? {
        let defaults = UserDefaults.standard
        return defaults.object(forKey: toKey)
    }
    
    public class func getImage(image: String) -> UIImage {
        let bundle = Bundle(identifier: "com.miclaro.app.mcaUtilsiOS")
        if let aImage = UIImage(named: image, in: bundle, compatibleWith: nil) {
            return aImage
        }
        return UIImage()
    }
    
    public class func initCustomFonts() {
        UIFont.loadAllFonts
    }
}
