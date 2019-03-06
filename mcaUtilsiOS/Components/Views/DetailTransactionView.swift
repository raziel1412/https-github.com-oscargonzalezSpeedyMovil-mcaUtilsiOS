//
//  DetailTransactionView.swift
//  mcaTopUpRefilliOS
//
//  Created by Ricardo Rodriguez De Los Santos on 3/4/19.
//  Copyright © 2019 Speedy Movil. All rights reserved.
//

import UIKit

public class DetailTransactionView: UIView {

    lazy var lblMethodPay: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont(name: RobotoFontName.RobotoMedium.rawValue, size: CGFloat(14.0))
        label.text = "Detalle de transacción"
        label.textColor = institutionalColors.claroRedColor
        
        return label
    }()
    
    var lblOrder: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont(name: RobotoFontName.RobotoBold.rawValue, size: CGFloat(14.0))
        label.text = "Orden:"
        
        return label
    }()
    
    var lblNumberOrder: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont(name: RobotoFontName.RobotoRegular.rawValue, size: CGFloat(14.0))
        label.text = "9867356201836274957"
        label.textAlignment = .right
        label.textColor = institutionalColors.claroLightGrayColor
        
        return label
    }()
    
    var lblReference: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont(name: RobotoFontName.RobotoBold.rawValue, size: CGFloat(14.0))
        label.text = "Número de referencia:"
        
        return label
    }()
    
    var lblNumberReference: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont(name: RobotoFontName.RobotoRegular.rawValue, size: CGFloat(14.0))
        label.text = "9867356201836"
        label.textAlignment = .right
        label.textColor = institutionalColors.claroLightGrayColor
        
        return label
    }()
    
    var lblAutorization: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont(name: RobotoFontName.RobotoBold.rawValue, size: CGFloat(14.0))
        label.text = "Número de autorización:"
        
        return label
    }()
    
    var lblNumberAutorization: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont(name: RobotoFontName.RobotoRegular.rawValue, size: CGFloat(14.0))
        label.text = "986735"
        label.textAlignment = .right
        label.textColor = institutionalColors.claroLightGrayColor
        
        return label
    }()
    
    var lblCard: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont(name: RobotoFontName.RobotoBold.rawValue, size: CGFloat(14.0))
        label.text = "Número de tarjeta:"
        
        return label
    }()
    
    var lblNumberCard: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont(name: RobotoFontName.RobotoRegular.rawValue, size: CGFloat(14.0))
        label.text = "XXXX XXXX XXXX 4356"
        label.textAlignment = .right
        label.textColor = institutionalColors.claroLightGrayColor
        
        return label
    }()
    
    var lblDateAndHour: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont(name: RobotoFontName.RobotoBold.rawValue, size: CGFloat(14.0))
        label.text = "Fecha y Hora:"
        
        return label
    }()
    
    var lblDateAndHourNumber: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont(name: RobotoFontName.RobotoRegular.rawValue, size: CGFloat(14.0))
        label.text = "12/02/2019 22:54:32"
        label.numberOfLines = 2
        label.textAlignment = .right
        label.textColor = institutionalColors.claroLightGrayColor
        
        return label
    }()
    
    var viewLineGray: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = institutionalColors.claroButtonDetailGraphicSelect
        
        return view
    }()
    
    let heightBetweenlbl: CGFloat = 5
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.initFrame()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initFrame(){
        
        self.lblMethodPay.frame = CGRect(x: 20, y: 0, width: self.frame.width - 40, height: 30)
        self.lblOrder.frame = CGRect(x: 20, y: self.lblMethodPay.frame.maxY + 10, width: (self.frame.width / 2) - 20, height: 30)
        self.lblNumberOrder.frame = CGRect(x: self.lblOrder.frame.maxX , y: self.lblOrder.frame.minY , width: (self.frame.width / 2) - 20, height: 30)
        self.lblReference.frame = CGRect(x: 20, y: self.lblOrder.frame.maxY + heightBetweenlbl, width: (self.frame.width / 2) - 20, height: 30)
        self.lblNumberReference.frame = CGRect(x: self.lblReference.frame.maxX , y: self.lblReference.frame.minY , width: (self.frame.width / 2) - 20, height: 30)
        self.lblAutorization.frame = CGRect(x: 20, y: self.lblReference.frame.maxY + heightBetweenlbl, width: (self.frame.width / 2) - 20, height: 30)
        self.lblNumberAutorization.frame = CGRect(x: self.lblAutorization.frame.maxX , y: self.lblAutorization.frame.minY , width: (self.frame.width / 2) - 20, height: 30)
        self.lblCard.frame = CGRect(x: 20, y: self.lblAutorization.frame.maxY + heightBetweenlbl, width: (self.frame.width / 2) - 20, height: 30)
        self.lblNumberCard.frame = CGRect(x: self.lblCard.frame.maxX , y: self.lblCard.frame.minY , width: (self.frame.width / 2) - 20, height: 30)
        self.lblDateAndHour.frame = CGRect(x: 20, y: self.lblCard.frame.maxY + heightBetweenlbl, width: (self.frame.width / 2) - 20, height: 30)
        self.lblDateAndHourNumber.frame = CGRect(x: self.frame.width - 120, y: self.lblDateAndHour.frame.minY , width: 100, height: 40)
        
        self.viewLineGray.frame = CGRect(x: 20, y: self.lblDateAndHour.frame.maxY + 30, width: self.frame.width - 40, height: 1)
        
        self.addSubview(lblMethodPay)
        self.addSubview(lblOrder)
        self.addSubview(lblNumberOrder)
        self.addSubview(lblReference)
        self.addSubview(lblNumberReference)
        self.addSubview(lblAutorization)
        self.addSubview(lblNumberAutorization)
        self.addSubview(lblCard)
        self.addSubview(lblNumberCard)
        self.addSubview(lblDateAndHour)
        self.addSubview(lblDateAndHourNumber)
        self.addSubview(viewLineGray)
        
        
    }
}
