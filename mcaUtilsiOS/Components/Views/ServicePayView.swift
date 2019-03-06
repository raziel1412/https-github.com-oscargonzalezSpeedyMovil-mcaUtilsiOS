//
//  ServicePayView.swift
//  mcaTopUpRefilliOS
//
//  Created by Ricardo Rodriguez De Los Santos on 3/4/19.
//  Copyright © 2019 Speedy Movil. All rights reserved.
//

import UIKit

public class ServicePayView: UIView {

    lazy var lblServicePay: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont(name: RobotoFontName.RobotoMedium.rawValue, size: CGFloat(14.0))
        label.text = "Servicio pagado"
        label.textColor = institutionalColors.claroRedColor
        
        return label
    }()
    
    var lblService: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont(name: RobotoFontName.RobotoBold.rawValue, size: CGFloat(14.0))
        label.text = "Televisión:"
        
        return label
    }()
    
    var lblServiceDescription: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont(name: RobotoFontName.RobotoRegular.rawValue, size: CGFloat(14.0))
        label.text = "Plan TV Pro HD Cable"
        label.textAlignment = .right
        label.textColor = institutionalColors.claroLightGrayColor
        
        return label
    }()
    
    var lblDescription: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont(name: RobotoFontName.RobotoBold.rawValue, size: CGFloat(14.0))
        label.text = "Descripción:"
        
        return label
    }()
    
    var lblDetailService: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont(name: RobotoFontName.RobotoRegular.rawValue, size: CGFloat(14.0))
        label.text = "descripcion del plan o servicio contradado,descripcion del plan o servicio contradado,descripcion del plan o servicio contradado,descripcion del plan o servicio contradado,descripcion del plan o servicio contradado,descripcion del plan o servicio contradado,descripcion del plan o servicio contradado"
        label.textColor = institutionalColors.claroLightGrayColor
        
        return label
    }()
    
    var lblTotal: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont(name: RobotoFontName.RobotoBold.rawValue, size: CGFloat(14.0))
        label.text = "Monto: $100.00"
        
        return label
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.iniFrame()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func iniFrame(){
        
        self.lblServicePay.frame = CGRect(x: 20, y: 0, width: self.frame.width - 40, height: 30)
        self.lblService.frame = CGRect(x: 20, y: self.lblServicePay.frame.maxY + 10, width: (self.frame.width / 2) - 20, height: 30)
        self.lblServiceDescription.frame = CGRect(x: self.lblService.frame.maxX , y: self.lblService.frame.minY , width: (self.frame.width / 2) - 20, height: 30)
        self.lblDescription.frame = CGRect(x: 20, y: self.lblService.frame.maxY + 5, width: self.frame.width/2, height: 30)
        self.lblDetailService.frame = CGRect(x: 20, y: self.lblDescription.frame.maxY, width: self.frame.width - 40, height: 40)
        self.lblDetailService.adjustHeighToFit()
        self.lblTotal.frame = CGRect(x: 20, y: self.lblDetailService.frame.maxY, width: self.frame.width/2, height: 30)
        
        self.addSubview(lblServicePay)
        self.addSubview(lblService)
        self.addSubview(lblServiceDescription)
        self.addSubview(lblDescription)
        self.addSubview(lblDetailService)
        self.addSubview(lblTotal)
        
    }
    
    public func getHeight() -> CGFloat {
        let height = self.lblServicePay.frame.height + self.lblService.frame.height + self.lblServiceDescription.frame.height + self.lblDescription.frame.height + self.lblDetailService.frame.height + self.lblTotal.frame.height + 15
        
        return height   
    }
}
