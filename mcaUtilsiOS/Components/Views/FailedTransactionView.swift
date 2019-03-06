//
//  FailedTransactionView.swift
//  mcaTopUpRefilliOS
//
//  Created by Ricardo Rodriguez De Los Santos on 3/4/19.
//  Copyright © 2019 Speedy Movil. All rights reserved.
//

import UIKit

public class FailedTransactionView: UIView {

    lazy var lblTitleFailed: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont(name: RobotoFontName.RobotoMedium.rawValue, size: CGFloat(14.0))
        label.text = "Transacción fallida"
        label.textColor = institutionalColors.claroRedColor
        
        return label
    }()
    
    var lblDescription: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont(name: RobotoFontName.RobotoBold.rawValue, size: CGFloat(14.0))
        label.text = "Motivo del fallo:"
        
        return label
    }()
    
    var lblDescriptionDetail: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont(name: RobotoFontName.RobotoRegular.rawValue, size: CGFloat(14.0))
        label.text = "descripcion del fallo o servicio contradado,descripcion del fallo o servicio contradado, descripcion del fallo o servicio contradado, descripcion del fallo o servicio contradado, descripcion del fallo o servicio contradado, descripcion del fallo o servicio contradado, descripcion del fallo o servicio contradado"
        label.textColor = institutionalColors.claroLightGrayColor
        
        return label
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.initFrame()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initFrame(){
        self.lblTitleFailed.frame = CGRect(x: 20, y: 0, width: self.frame.width - 40, height: 30)
        self.lblDescription.frame = CGRect(x: 20, y: self.lblTitleFailed.frame.maxY + 5, width: self.frame.width - 40, height: 30)
        self.lblDescriptionDetail.frame = CGRect(x: 20, y: self.lblDescription.frame.maxY, width: self.frame.width - 40, height: 30)
        self.lblDescriptionDetail.adjustHeighToFit()
        
        self.addSubview(lblTitleFailed)
        self.addSubview(lblDescription)
        self.addSubview(lblDescriptionDetail)
    }
    
    public func getHeight() -> CGFloat {
        let height = self.lblTitleFailed.frame.height + self.lblDescription.frame.height + self.lblDescriptionDetail.frame.height + 15
        
        return height
    }
}
