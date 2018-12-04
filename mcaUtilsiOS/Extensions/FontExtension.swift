//
//  FontExtension.swift
//  mcaUtilsiOS
//
//  Created by Pilar del Rosario Prospero Zeferino on 12/4/18.
//  Copyright © 2018 Roberto. All rights reserved.
//

import UIKit

extension UIFont {
    
    // load framework font in application
    static let loadAllFonts: () = {
        registerFontWith(filenameString: "Roboto-Regular")
        registerFontWith(filenameString: "Roboto-Light")
        registerFontWith(filenameString: "Roboto-Medium")
        registerFontWith(filenameString: "Roboto-Black")
        registerFontWith(filenameString: "Roboto-CondensedItalic")
        registerFontWith(filenameString: "Roboto-BoldCondensedItalic")
        registerFontWith(filenameString: "Roboto-BoldItalic")
        registerFontWith(filenameString: "Roboto-LightItalic")
        registerFontWith(filenameString: "Roboto-Thin")
        registerFontWith(filenameString: "Roboto-MediumItalic")
        registerFontWith(filenameString: "Roboto-Condensed")
        registerFontWith(filenameString: "Roboto-Bold")
        registerFontWith(filenameString: "Roboto-BlackItalic")
        registerFontWith(filenameString: "Roboto-Italic")
        registerFontWith(filenameString: "Roboto-ThinItalic")
        registerFontWith(filenameString: "Roboto-BoldCondensed")
    }()
    
    //MARK: - Make custom font bundle register to framework
    static func registerFontWith(filenameString: String) {
        if let bundle = Bundle(identifier: "com.miclaro.app.mcaUtilsiOS"), let pathForResourceString = bundle.path(forResource: filenameString, ofType: "ttf") {
            if let fontData = NSData(contentsOfFile: pathForResourceString), let dataProvider = CGDataProvider.init(data: fontData) {
                let fontRef = CGFont.init(dataProvider)
                var errorRef: Unmanaged<CFError>? = nil
                if (CTFontManagerRegisterGraphicsFont(fontRef, &errorRef) == false) {
                    print("Failed to register font - register graphics font failed - this font may have already been registered in the main bundle.")
                }
            }
            else {
                print("Failed to register font - bundle identifier invalid.")
            }
        }
    }
}


