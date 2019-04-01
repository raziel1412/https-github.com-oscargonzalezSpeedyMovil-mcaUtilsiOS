//
//  ViewExtension.swift
//  MiClaro
//
//  Created by Jonathan Abimael Cruz Orozco on 10/11/17.
//  Copyright © 2017 am. All rights reserved.
//

import Foundation
import UIKit

/// Para mostrar el renderizado desde Interface builder
@IBDesignable
public class DesignableView: UIView {
}
@IBDesignable
public class DesignableButton: UIButton {
}

/// Extension UIView
public extension UIView {
    //Pinta las grecas inferiores de las boletas o cualquier vista que lo requiera
    public func addBottomGrecas(){
        let grecaCount = 22
        let containerWidth = self.frame.width
        let grecaWidth = containerWidth / CGFloat(grecaCount)
        let grecaHeight = grecaWidth * 0.95
        
        self.backgroundColor = UIColor.white
        
        for i in 0..<grecaCount{
            let grecaImage = mcaUtilsHelper.getImage(image: "ticket_prt4") // #imageLiteral(resourceName: "ticket_prt4")
            let offset : CGFloat = CGFloat(i)
            let frame = CGRect(x: grecaWidth * offset, y: self.frame.height - grecaHeight, width: grecaWidth, height: grecaHeight)
            let grecaImageView = UIImageView(frame: frame)
            grecaImageView.tag = 2018
            grecaImageView.image = grecaImage
            self.addSubview(grecaImageView)
        }
    
    }
    //Pinta linea punteada en la parte inferior en las vistas que lo requera
    public func addBottomlines(){
        let linesCount = 56
        let containerWidth = self.frame.width
        let linesWidth = containerWidth / CGFloat(linesCount)
        let linesHeight = linesWidth * 0.80
        self.backgroundColor = institutionalColors.claroWhiteColor
        for i in 0..<linesCount{
            let lineImage = mcaUtilsHelper.getImage(image: "guion") // #imageLiteral(resourceName: "guion")
            let lineImageView = UIImageView(image: lineImage)
            let offset : CGFloat = CGFloat(i)
            let frame = CGRect(x: linesWidth * offset, y: self.frame.height - linesHeight, width: 3.0, height: 1.0)
            lineImageView.frame = frame
            self.addSubview(lineImageView)
        }
    }
    
    public func showShadowBorderTicket(enable: Bool) {
        if enable {
            let border = SideView(Left: true, Right: true, Top: false, Bottom: true)
            self.addBorder(sides: border, color: institutionalColors.claroLightGrayColor, thickness: 0.5)
            self.layer.shadowColor = institutionalColors.claroLightGrayColor.cgColor
            self.layer.shadowOpacity = 0.4
            self.layer.shadowOffset = CGSize(width: 0, height: 5)  //CGSize.zero
            self.layer.shadowRadius = 8
        }else {
            self.layer.shadowColor = UIColor.clear.cgColor
            self.layer.shadowOpacity = 0
            self.layer.shadowOffset = CGSize.zero
            self.layer.shadowRadius = 0
        }
    }
    
    
    //UIView().addDashedBorder
    public func addDashedBorder(width: CGFloat? = nil, height: CGFloat? = nil, lineWidth: CGFloat = 0.5, lineDashPattern:[NSNumber]? = [6,3], strokeColor: UIColor = institutionalColors.claroLightGrayColor, fillColor: UIColor = UIColor.clear) {
        
        var fWidth: CGFloat? = width
        var fHeight: CGFloat? = height
        
        if fWidth == nil {
            fWidth = self.frame.width
        }
        
        if fHeight == nil {
            fHeight = self.frame.height
        }
        
        let shapeLayer:CAShapeLayer = CAShapeLayer()
        
        let shapeRect = CGRect(x: 0, y: 0, width: fWidth!, height: fHeight!)
        
        shapeLayer.bounds = shapeRect
        shapeLayer.position = CGPoint(x: fWidth!/2, y: fHeight!/2)
        shapeLayer.fillColor = fillColor.cgColor
        shapeLayer.strokeColor = strokeColor.cgColor
        shapeLayer.lineWidth = lineWidth
        shapeLayer.lineJoin = kCAFilterLinear //kCALineJoinRound
        shapeLayer.lineDashPattern = lineDashPattern
        shapeLayer.name = "kShapeDashed"
        shapeLayer.path = UIBezierPath(roundedRect: shapeRect, cornerRadius: 1).cgPath
        
        self.layer.addSublayer(shapeLayer)
    }
    //UIView.initializeCircle
    public class func initializeCircle(frame : CGRect) -> UIView {
        let view = UIView(frame: frame)
        view.backgroundColor = institutionalColors.claroRedColor
        view.layer.cornerRadius = frame.height / 2
        return view
    }
    
    // OUTPUT 1
    public func dropShadow(scale: Bool = true) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: -1, height: 1)
        self.layer.shadowRadius = 1
        
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    // OUTPUT 2
    public func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = offSet
        self.layer.shadowRadius = radius
        
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    public func borderCard() {
        self.layer.cornerRadius = 0
        self.layer.shadowOpacity = 0.0
        self.layer.borderWidth = 0.5
        self.layer.borderColor = institutionalColors.claroLightGrayColor.cgColor
    }
    
    public func addBorder(sides: SideView, color: UIColor, thickness: CGFloat, shadowSize: CGSize? = nil, cornerRadius: CGFloat = 0) {
        self.layer.cornerRadius = cornerRadius
        self.layer.shadowOpacity = 0.0
        self.layer.borderWidth = 0.0
        self.layoutIfNeeded()
        
        if sides.Left {
            self.layer.addBorder(edge: .left, color: color, thickness: thickness, shadowSize: shadowSize)
        }
        if sides.Right {
            self.layer.addBorder(edge: .right, color: color, thickness: thickness, shadowSize: shadowSize)
        }
        if sides.Top {
            self.layer.addBorder(edge: .top, color: color, thickness: thickness, shadowSize: shadowSize)
        }
        if sides.Bottom {
            self.layer.addBorder(edge: .bottom, color: color, thickness: thickness, shadowSize: shadowSize)
        }
        
    }
    
    public func addBorderLayer(sides: SideView, color: UIColor, thickness: CGFloat, sizeShadow: CGSize = CGSize(width: 0, height: 2)) {
        /*self.layer.cornerRadius = 3.0
        self.layer.shadowOpacity = 0.3
        self.layer.borderWidth = 0.5
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowRadius = 1.0
        self.layoutIfNeeded()*/
        
        self.layer.shadowColor = institutionalColors.claroLightGrayColor.cgColor;
        self.layer.shadowOpacity = 0.8
        self.layer.shadowOffset = sizeShadow
        self.layer.shadowRadius = 2
        
        if sides.Left {
            self.layer.addBorder(edge: .left, color: color, thickness: thickness)
        }
        if sides.Right {
            self.layer.addBorder(edge: .right, color: color, thickness: thickness)
        }
        if sides.Top {
            self.layer.addBorder(edge: .top, color: color, thickness: thickness)
        }
        if sides.Bottom {
            self.layer.addBorder(edge: .bottom, color: color, thickness: thickness)
        }
        
    }
    
    public func addBorderWithLayer(sides: SideView, color: UIColor, thickness: CGFloat, layers: [(Sides,CALayer)]) {
        for border in layers {
            switch border.0 {
            case .left:
                self.layer.addBorderWithLayer(edge: .left, color: color, thickness: thickness, layer: border.1)
                break
            case .right:
                self.layer.addBorderWithLayer(edge: .right, color: color, thickness: thickness, layer: border.1)
                break
            case .top:
                self.layer.addBorderWithLayer(edge: .top, color: color, thickness: thickness, layer: border.1)
                break
            case .bottom:
                self.layer.addBorderWithLayer(edge: .bottom, color: color, thickness: thickness, layer: border.1)
                break
            }
        }
    }
    
    public func updateLayers(sides: SideView, thickness: CGFloat) {
        if sides.Left {
            self.layer.updateLayers(edge: .left, thickness: thickness)
        }
        if sides.Right {
            self.layer.updateLayers(edge: .right, thickness: thickness)
        }
        if sides.Top {
            self.layer.updateLayers(edge: .top, thickness: thickness)
        }
        if sides.Bottom {
            self.layer.updateLayers(edge: .bottom, thickness: thickness)
        }
    }
    
    public func updateLayer(sides: SideView, thickness: CGFloat, layers: [(Sides, CALayer)]) {
        for border in layers {
            switch border.0 {
            case .left:
                self.layer.updateLayers(edge: .left, thickness: 0.5, layer: border.1)
                break
            case .right:
                self.layer.updateLayers(edge: .right, thickness: 0.5, layer: border.1)
                break
            case .top:
                self.layer.updateLayers(edge: .top, thickness: 0.5, layer: border.1)
                break
            case .bottom:
                self.layer.updateLayers(edge: .bottom, thickness: 0.5, layer: border.1)
                break
            }
        }
    }
    
    public func setCircle(colorBorder: UIColor = .clear) {
        let radius = self.frame.width / 2
        self.layer.cornerRadius = radius
        self.layer.borderWidth = 2
        self.layer.borderColor = colorBorder.cgColor
        self.layer.masksToBounds = true
    }
    
    public func applyGradient(colours: [UIColor]) -> Void {
        self.applyGradient(colours: colours, locations: nil)
    }
    
    public func applyGradient(colours: [UIColor], locations: [NSNumber]?) -> Void {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colours.map { $0.cgColor }
        gradient.locations = locations
        self.layer.addSublayer(gradient)
    }
    
    //MARK: Configure data in view
    /// Set and Get the corner radius
    @IBInspectable
    public var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
        }
    }
    
    /// Set and Get the border width
    @IBInspectable
    public var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    /// Set and Get the border color
    @IBInspectable
    public var borderColor: UIColor? {
        get {
            if let color = self.layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            }else {
                layer.borderColor = nil
            }
        }
    }
    
    /// Set and Get shadow border
    @IBInspectable
    public var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    /// Set and Get shadow opacity
    @IBInspectable
    public var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    /// Set and Get shadow offset
    @IBInspectable
    public var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    /// Set and Get shadow color
    @IBInspectable
    public var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            }else {
                layer.shadowColor = nil
            }
        }
    }
}

public extension CALayer {
    
    public func addBorder(edge: UIRectEdge, color: UIColor, thickness: CGFloat, shadowSize: CGSize? = nil) {
        //        needsDisplayOnBoundsChange = true
        self.borderWidth = 0.0
        self.layoutIfNeeded()
        let border = CALayer()
        border.needsDisplayOnBoundsChange = true
        
        switch edge {
        case UIRectEdge.top:
            border.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: thickness)
            break
        case UIRectEdge.bottom:
            border.frame = CGRect(x: 0, y: self.frame.height - thickness, width: self.frame.width, height: thickness)
            break
        case UIRectEdge.left:
            if shadowSize != nil {
                border.shadowRadius = 3
                border.shadowColor = color.cgColor
                border.shadowOpacity = 1.0
                border.shadowOffset = shadowSize!
            }
            border.frame = CGRect(x: 0, y: 0, width: thickness, height: self.frame.height)
            break
        case UIRectEdge.right:
            if shadowSize != nil {
                border.shadowRadius = 3
                border.shadowColor = color.cgColor
                border.shadowOpacity = 1.0
                border.shadowOffset = shadowSize!
            }
            border.frame = CGRect(x: self.frame.width - thickness, y: 0, width: thickness, height: self.frame.height)
            break
        default:
            break
        }
        
        border.backgroundColor = color.cgColor;
        
        self.addSublayer(border)
        border.setNeedsDisplay()
    }
    
    public func addBorderWithLayer(edge: UIRectEdge, color: UIColor, thickness: CGFloat, layer: CALayer) {
        self.borderWidth = 0.0
        self.layoutIfNeeded()
        let border = layer
        border.needsDisplayOnBoundsChange = true
        
        switch edge {
        case UIRectEdge.top:
            border.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: thickness)
            break
        case UIRectEdge.bottom:
            border.frame = CGRect(x: 0, y: self.frame.height - thickness, width: self.frame.width, height: thickness)
            break
        case UIRectEdge.left:
            border.frame = CGRect(x: 0, y: 0, width: thickness, height: self.frame.height)
            break
        case UIRectEdge.right:
            border.frame = CGRect(x: self.frame.width - thickness, y: 0, width: thickness, height: self.frame.height)
            break
        default:
            break
        }
        
        border.backgroundColor = color.cgColor;
        
        self.addSublayer(border)
        border.setNeedsDisplay()
    }
    
    public func updateLayers(edge: UIRectEdge, thickness: CGFloat) {
        
        self.setNeedsDisplay()
        
        for border in self.sublayers! {
            switch edge {
            case UIRectEdge.top:
                border.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: thickness)
                break
            case UIRectEdge.bottom:
                border.frame = CGRect(x: 0, y: self.frame.height - thickness, width: self.frame.width, height: thickness)
                break
            case UIRectEdge.left:
                border.frame = CGRect(x: 0, y: 0, width: thickness, height: self.frame.height)
                break
            case UIRectEdge.right:
                border.frame = CGRect(x: self.frame.width - thickness, y: 0, width: thickness, height: self.frame.height)
                break
            default:
                break
            }
        }
    }
    
    public func updateLayers(edge: UIRectEdge, thickness: CGFloat, layer: CALayer) {
        switch edge {
        case UIRectEdge.top:
            layer.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: thickness)
            break
        case UIRectEdge.bottom:
            layer.frame = CGRect(x: 0, y: self.frame.height - thickness, width: self.frame.width, height: thickness)
            break
        case UIRectEdge.left:
            layer.frame = CGRect(x: 0, y: 0, width: thickness, height: self.frame.height)
            break
        case UIRectEdge.right:
            layer.frame = CGRect(x: self.frame.width - thickness, y: 0, width: thickness, height: self.frame.height)
            break
        default:
            break
        }
        
        self.setNeedsDisplay()
    }
}

extension UITextField {
    public func setBottomBorder() {
        self.borderStyle = .none
        self.layer.backgroundColor = UIColor.white.cgColor
        
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
    }
}

extension SimpleGrayTextFieldQuestionMark {
    public func disable(){
        self.alpha = 0.5;
        self.isUserInteractionEnabled = false
    }
    
    public func enable() {
        self.alpha = 1.0;
        self.isUserInteractionEnabled = true
    }
}
