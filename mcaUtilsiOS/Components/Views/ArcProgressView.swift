//  Created by Mauricio Javier Perez Flores on 8/14/17.
//  Copyright © 2017 am. All rights reserved.
//

import UIKit

/// Esta clase especializa un UIView para tener L&F de gráfica de arco para el despliegue del porcentaje de datos utilizados en un plan de internet.
public class ArcProgressView: UIView {
    
    var startPoint: CGFloat = 0
    var color: UIColor = institutionalColors.claroBlueColor
    var trackColor: UIColor = UIColor.gray
    var trackWidth: CGFloat = 1
    var fillPercentage: CGFloat = 100

    var showGraph : Bool = true
    
    override init(frame: CGRect) {
        
        super.init(frame: CGRect.zero)
        self.backgroundColor = institutionalColors.claroWhiteColor
    } // init
    
    required init(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)!
        self.backgroundColor = institutionalColors.claroWhiteColor
    } // init
    
    private func getGraphStartAndEndPointsInRadians() -> (graphStartingPoint: CGFloat, graphEndingPoint: CGFloat) {
        
        // make sure our starting point is at least 0 and less than 100
        if ( 0 > self.startPoint ) {
            self.startPoint = 0
        } else if ( 100 < self.startPoint ) {
            self.startPoint = 100
        } // if
        
        // make sure our fill percentage is at least 0 and less than 100
        if ( 0 > self.fillPercentage ) {
            self.fillPercentage = 0
        } else if ( 100 < self.fillPercentage ) {
            self.fillPercentage = 100
        } // if
        
        // we take 25% off the starting point, so that a zero starting point
        // begins at the top of the circle instead of the right side...
        self.startPoint = self.startPoint - 50
        
        // we calculate a true fill percentage as we need to account
        // for the potential difference in starting points
        let trueFillPercentage = (self.fillPercentage / 2 + self.startPoint)
        
        let π: CGFloat = CGFloat(Double.pi)
        
        // now we can calculate our start and end points in radians
        let startPoint: CGFloat = ((2 * π) / 100) * (CGFloat(self.startPoint))
        let endPoint: CGFloat = ((2 * π) / 100) * (CGFloat(trueFillPercentage))
        
        return(startPoint, endPoint)
        
    } // func
    
    override public func draw(_ rect: CGRect) {

        if false == showGraph {
            let infinito = UIImageView(image: mcaUtilsHelper.getImage(image: "ic_infinito"))
            infinito.frame.size.width = self.frame.size.width;
            infinito.frame.size.height = self.frame.size.height;
            infinito.contentMode = .center
            self.addSubview(infinito);
            return;
        }
        
        // first we want to find the centerpoint and the radius of our rect
        let center: CGPoint = CGPoint(x: rect.midX,y: rect.height)
        let radius: CGFloat = rect.width / 2
        
        // make sure our track width is at least 1
        if ( 1 > self.trackWidth) {
            self.trackWidth = 1
        } // if
        
        // and our track width cannot be greater than the radius of our circle
        if ( radius < self.trackWidth ) {
            self.trackWidth = radius
        } // if
        
        // we need our graph starting and ending points
        let (graphStartingPoint, graphEndingPoint) = self.getGraphStartAndEndPointsInRadians()
        
        // now we need to first draw the track...
        let arc = CAShapeLayer()
        let path = UIBezierPath(arcCenter: center, radius: radius - (trackWidth / 2), startAngle: graphStartingPoint, endAngle: graphStartingPoint + .pi, clockwise: true)
        arc.path = path.cgPath
        arc.lineWidth = 8
        arc.fillColor = UIColor.clear.cgColor
        arc.strokeColor = trackColor.cgColor
        //path.lineWidth = trackWidth
        //self.trackColor.setStroke()
        //path.stroke()
        self.layer.addSublayer(arc)


        let gradient = CAGradientLayer()
        let colorArray = [UIColor(rgb: 0x4dd0e1, alphaVal: 1).cgColor,
                          UIColor(rgb: 0x53cfd8, alphaVal: 1).cgColor,
                          UIColor(rgb: 0x58cfd1, alphaVal: 1).cgColor,
                          UIColor(rgb: 0x62cec2, alphaVal: 1).cgColor,
                          UIColor(rgb: 0x6cceb4, alphaVal: 1).cgColor,
                          UIColor(rgb: 0x73ceab, alphaVal: 1).cgColor,
                          UIColor(rgb: 0x78cea3, alphaVal: 1).cgColor,
                          UIColor(rgb: 0x81cd91, alphaVal: 0.8).cgColor,
                          UIColor(rgb: 0x8acd89, alphaVal: 0.8).cgColor,
                          UIColor(rgb: 0x93d46f, alphaVal: 0.5).cgColor,
                          UIColor(rgb: 0x9cda57, alphaVal: 0.5).cgColor]
        gradient.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        gradient.colors = colorArray
        gradient.startPoint = CGPoint(x: 0, y: 1)
        gradient.endPoint = CGPoint(x: 1, y: 1)
        gradient.mask = arc
        
        self.layer.addSublayer(gradient)

        
        // now we can draw the progress arc
        let arc2 = CAShapeLayer()
        let percentagePath = UIBezierPath(arcCenter: center, radius: radius - (trackWidth / 2), startAngle: graphStartingPoint, endAngle: graphEndingPoint, clockwise: true)
        arc2.path = percentagePath.cgPath
        arc2.lineWidth = trackWidth
        arc2.fillColor = UIColor.clear.cgColor
        arc2.strokeColor = institutionalColors.claroBlueColor.cgColor
        gradient.addSublayer(arc2)
    } // func
} // class

