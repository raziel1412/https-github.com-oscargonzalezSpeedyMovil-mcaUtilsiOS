//
//  UILabelExtension.swift
//  MiClaro
//
//  Created by Roberto Gutierrez Resendiz on 29/08/17.
//  Copyright © 2017 am. All rights reserved.
//

import UIKit

/// Extensión de UILabel
extension UILabel
{
    /// Estructura AssociatedKeys
    private struct AssociatedKeys {
        static var padding = UIEdgeInsets()
    }

    /// Variable Padding para label
    var padding: UIEdgeInsets? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.padding) as? UIEdgeInsets
        }
        set {
            if let newValue = newValue {
                objc_setAssociatedObject(self, &AssociatedKeys.padding, newValue as UIEdgeInsets!, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
    }

    /// Draw
    override open func draw(_ rect: CGRect) {
        if let insets = padding {
            self.drawText(in: UIEdgeInsetsInsetRect(rect, insets))
        } else {
            self.drawText(in: rect)
        }
    }
    /// IntrinsicContentSize
    override open var intrinsicContentSize: CGSize {
        get {
            var contentSize = super.intrinsicContentSize
            if let insets = padding {
                contentSize.height += insets.top + insets.bottom
                contentSize.width += insets.left + insets.right
            }
            return contentSize
        }
    }
    
    /// Función que determina si necesita ajustar un label según su contenido
    /// - Returns needs: Bool
    /// - Returns newHeight: CGFloat
    func needAdjustLabel() -> (needs: Bool, newHeight: CGFloat) {
        if let textToEvaluate = self.text as NSString? {
            let expectedSize = textToEvaluate.size(attributes: [NSFontAttributeName: self.font])
            if expectedSize.width > self.frame.width - 3 {
                return (true, self.frame.height * 2)
            }
        }
        return (false, self.frame.height)
    }
    
    /// Función que determina si necesita ajustar el Height un label según su contenido
    /// - Returns needs: Bool
    /// - Returns newHeight: CGFloat
    func needAdjustHeightLabel() -> (needs: Bool, newHeight: CGFloat) {
        if let textToEvaluate = self.text as NSString? {
            let expectedSize = textToEvaluate.size(attributes: [NSFontAttributeName: self.font])
            if expectedSize.width > self.frame.width {
                if (expectedSize.width / self.frame.width) > round(expectedSize.width / self.frame.width) {
                    return (true, ((round(expectedSize.width / self.frame.width) + 1)) * (self.font.lineHeight + self.font.lineHeight))
                }
                return (true, ((round(expectedSize.width / self.frame.width)) * (self.font.lineHeight + self.font.lineHeight)))
            }
        }
        return (false, self.frame.height)
    }
    
    /// Función que ajustar el frame de un label para que se ajuste a su contenido
    func adjustHeighToFit() {
        if let textToEvaluate = self.text as NSString? {
            let expectedSize = textToEvaluate.size(attributes: [NSFontAttributeName: self.font])
            if expectedSize.width > self.frame.width - 3 {
                self.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: self.frame.width, height: self.frame.height * 3)
                self.numberOfLines = 0
                self.lineBreakMode = .byWordWrapping
            }
        }
    }

    
}

