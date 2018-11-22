//
//  Appearance.swift
//  MiClaro
//
//  Created by Mauricio Javier Perez Flores on 25/07/17.
//  Copyright © 2017 am. All rights reserved.
//

import UIKit
/// Clase Appearance
public class Appearance: NSObject {

    /// Función que hace el setup de la apariencia inicial
    static func setInitialAppearance() {
    
        UINavigationBar.appearance().barTintColor = institutionalColors.claroGrayNavColor
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: institutionalColors.claroNavTitleColor]
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        // Sets shadow (line below the bar) to a blank image
        UINavigationBar.appearance().shadowImage = UIImage()
        // Sets the translucent background color
        UINavigationBar.appearance().backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)
        // Set translucent. (Default value is already true, so this can be removed if desired.)
        UINavigationBar.appearance().isTranslucent = false

        let selectionView = UIView()
        selectionView.backgroundColor = UIColor.white
        UITableViewCell.appearance().selectedBackgroundView = selectionView
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
}

public extension NSAttributedString {

    convenience init(htmlString html: String, font: UIFont? = nil, alignment: NSTextAlignment = NSTextAlignment.center, useDocumentFontSize: Bool = true) throws {
        let options: [String : Any] = [
            NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,
            NSCharacterEncodingDocumentAttribute: String.Encoding.utf8.rawValue
        ]

        let data = html.data(using: .utf8, allowLossyConversion: true)
        guard (data != nil), let fontFamily = font?.familyName, let attr = try? NSMutableAttributedString(data: data!, options: options, documentAttributes: nil) else {
            try self.init(data: data ?? Data(html.utf8), options: options, documentAttributes: nil)
            return
        }

        let fontSize: CGFloat? = useDocumentFontSize ? nil : font!.pointSize
        let range = NSRange(location: 0, length: attr.length)
        attr.enumerateAttribute(NSFontAttributeName, in: range, options: .longestEffectiveRangeNotRequired) { attrib, range, _ in
            if let htmlFont = attrib as? UIFont {
                let traits = htmlFont.fontDescriptor.symbolicTraits
                var descrip = htmlFont.fontDescriptor.withFamily(fontFamily)

                if (traits.rawValue & UIFontDescriptorSymbolicTraits.traitBold.rawValue) != 0 {
                    descrip = descrip.withSymbolicTraits(.traitBold)!
                }

                if (traits.rawValue & UIFontDescriptorSymbolicTraits.traitItalic.rawValue) != 0 {
                    descrip = descrip.withSymbolicTraits(.traitItalic)!
                }

                attr.addAttribute(NSFontAttributeName, value: UIFont(descriptor: descrip, size: fontSize ?? htmlFont.pointSize), range: range)
            }
        }

        let textAlignment = NSMutableParagraphStyle();
        textAlignment.alignment = alignment;
        attr.addAttribute(NSParagraphStyleAttributeName,
                          value: textAlignment,
                          range: range);
        self.init(attributedString: attr)
    }

}
