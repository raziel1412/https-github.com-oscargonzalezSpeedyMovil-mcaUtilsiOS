//
//  Extension + UIView.swift
//  Animations
//
//  Created by Fernando Rodriguez Minguet on 17/05/18.
//  Copyright © 2018 com.JoseFernando.BestSecretTest.BBCNews. All rights reserved.
//

import UIKit

extension UIView : CAAnimationDelegate {
    public func addProgressArchAnimation(lineSize: CGSize, value: CGFloat, fillColor: UIColor, backgroundLineColor: UIColor, colorsGradient: [CGColor], containtsLabel: Bool = false, labelText : String = "", labelColor : UIColor = .clear, subtitleText: String = "", subtitleColor : UIColor = .lightGray) {
        let archPath = UIBezierPath(arcCenter: self.center, radius: self.frame.size.height / 2, startAngle:CGFloat.pi, endAngle: 2 * CGFloat.pi, clockwise: true)
        let fillShape = generateShapeLayer(strokeLineColor: fillColor, fillLineColor: UIColor.clear, path: archPath, lineWidth: lineSize.height)
        let backgroundShape = generateTracker( path: archPath)
        let gradientShape = generateGradient(trackColors: colorsGradient, frame: self.bounds)
        [gradientShape, fillShape].forEach({
            self.layer.addSublayer($0)
        })
        if containtsLabel {
            let labelLayer = generateTextLayer(textLayerString: labelText, foregroundColor: labelColor)
            let subtitleLayer = generateSubTitleLayer(textLayerString: subtitleText, foregroundColor: subtitleColor, refLayer: labelLayer)
            [labelLayer, subtitleLayer].forEach({
                self.layer.addSublayer($0)
            })
        }
        gradientShape.mask = backgroundShape
        progressAnimation(shapeLayer: fillShape, value: value)
    }
    
    public func addProgressCircleAnimation(lineSize: CGSize, value: CGFloat, fillColor: UIColor, backgroundLineColor: UIColor, colorsGradient: [CGColor], containtsLabel: Bool = false, labelText : String = "", labelColor : UIColor = .clear, subtitleText: String = "", subtitleColor : UIColor = .lightGray) {
        
        let archPath = UIBezierPath(arcCenter: self.center, radius: (self.frame.size.height - 10.0) / 2, startAngle: (3 / 2) * CGFloat.pi, endAngle: (67 / 45) * CGFloat.pi, clockwise: true)
        let fillShape = generateShapeLayer(strokeLineColor: fillColor, fillLineColor: UIColor.clear, path: archPath, lineWidth: lineSize.height)
        let backgroundShape = generateTracker( path: archPath)
        let gradientShape = generateGradient(trackColors: colorsGradient, frame: self.bounds)
        [gradientShape, fillShape].forEach({
            self.layer.addSublayer($0)
        })
        if containtsLabel {
            let labelLayer = generateTextLayer(textLayerString: labelText, foregroundColor: labelColor)
            let subtitleLayer = generateSubTitleLayer(textLayerString: subtitleText, foregroundColor: subtitleColor, refLayer: labelLayer)
            [labelLayer, subtitleLayer].forEach({
                self.layer.addSublayer($0)
            })
        }
        gradientShape.mask = backgroundShape
        progressAnimation(shapeLayer: fillShape, value: value)
    }
    
    public func addProgressAnimation(lineSize: CGSize, value: CGFloat, fillColor: UIColor, backgroundLineColor: UIColor) {
        let linearPath = UIBezierPath()
        linearPath.move(to: CGPoint(x:  10, y: 0))
        linearPath.addLine(to: CGPoint(x: self.frame.maxX - 10, y: 0))
        linearPath.stroke()
        let backgroundShape = generateTracker(trackColor: backgroundLineColor, path: linearPath, lineWidth: lineSize.height)
        let fillShape = generateShapeLayer(strokeLineColor: fillColor, fillLineColor: UIColor.clear, path: linearPath, lineWidth: lineSize.height)
        [backgroundShape, fillShape].forEach({
            self.layer.addSublayer($0)
        })
        progressAnimation(shapeLayer: fillShape, value: value)
    }
    
    private func progressAnimation(shapeLayer: CAShapeLayer, value: Any?) {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0.0
        animation.toValue = value
        animation.duration = 0.6
        animation.fillMode = kCAFillModeForwards
        animation.isRemovedOnCompletion = false
        shapeLayer.add(animation, forKey: "progressAnimation")
    }
    
    private func addAlphaSubView(_ backgroundColor : UIColor = .white, alpha: CGFloat = 0.6) {
        let alphaView = UIView(frame: self.bounds)
        alphaView.backgroundColor = backgroundColor
        alphaView.alpha = alpha
        alphaView.tag = 99
        self.addSubview(alphaView)
    }
    
    private func generateTracker(path : UIBezierPath, lineWidth: CGFloat = 10) -> CALayer {
        let trackLayer = CAShapeLayer()
        trackLayer.path = path.cgPath
        trackLayer.lineWidth = lineWidth
        trackLayer.strokeEnd = 1
        trackLayer.strokeColor = UIColor.gray.cgColor
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.lineCap = kCALineCapRound
        return trackLayer
    }
    
    private func generateGradient(trackColors : [CGColor], frame: CGRect) -> CAGradientLayer {
        let gradient = CAGradientLayer()
        gradient.colors = trackColors
        var startLocation = 1.0 / Double(trackColors.count)
        var locations : [NSNumber] = []
        trackColors.forEach({_ in
            locations.append(NSNumber(value: startLocation))
            startLocation += startLocation
        })
        gradient.locations = locations
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 0)
        gradient.frame = frame
        return gradient
    }
    
    private func generateTracker(trackColor : UIColor, path : UIBezierPath, lineWidth: CGFloat = 10) -> CAShapeLayer {
        let trackLayer = CAShapeLayer()
        trackLayer.path = path.cgPath
        trackLayer.lineWidth = lineWidth
        trackLayer.strokeEnd = 1
        trackLayer.strokeColor = trackColor.cgColor
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.lineCap = kCALineCapRound
        trackLayer.setValue("trackLayer", forKey: "Layers")
        return trackLayer
    }
    
    private func generateShapeLayer(strokeLineColor : UIColor, fillLineColor: UIColor, path : UIBezierPath, lineWidth: CGFloat = 10.0) -> CAShapeLayer {
        let layer = CAShapeLayer()
        layer.path = path.cgPath
        layer.lineWidth = lineWidth
        layer.strokeEnd = 0
        layer.strokeColor = strokeLineColor.cgColor
        layer.fillColor = fillLineColor.cgColor
        layer.lineCap = kCALineCapRound
        layer.setValue("shapeLayer", forKey: "Layers")
        return layer
    }
    
    private func generateTextLayer(textLayerString : String, foregroundColor: UIColor) -> CATextLayer {
        let tLayer = CATextLayer()
        tLayer.string = textLayerString
        tLayer.font = CTFontCreateWithName(UIFont.boldSystemFont(ofSize: 12.0).fontName as CFString, 12.0, nil)
        tLayer.fontSize = 18.0
        tLayer.contentsScale = UIScreen.main.scale
        tLayer.backgroundColor = UIColor.clear.cgColor
        tLayer.foregroundColor = foregroundColor.cgColor
        tLayer.frame = CGRect(x: 0,y: 0,width: self.frame.size.width / 2, height: 30)
        tLayer.alignmentMode = kCAAlignmentCenter
        tLayer.position = self.center
        tLayer.allowsFontSubpixelQuantization = true
        tLayer.setValue("textLayer", forKey: "Layers")
        
        return tLayer
    }
    
    private func generateSubTitleLayer(textLayerString : String, foregroundColor: UIColor, refLayer : CALayer) -> CATextLayer {
        let tLayer = CATextLayer()
        tLayer.string = textLayerString
        tLayer.fontSize = 11.0
        tLayer.contentsScale = UIScreen.main.scale
        tLayer.backgroundColor = UIColor.clear.cgColor
        tLayer.foregroundColor = foregroundColor.cgColor
        tLayer.frame = CGRect(x: 0,y: 0,width: self.frame.size.width / 2, height: 30)
        tLayer.alignmentMode = kCAAlignmentCenter
        tLayer.position = CGPoint.init(x: self.center.x, y: refLayer.frame.maxY + 5)
        tLayer.setValue("textLayer", forKey: "Layers")
        return tLayer
    }
    
}


