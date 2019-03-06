//
//  BankCardViewCell.swift
//  mcaTopUpRefilliOS
//
//  Created by Ricardo Rodriguez De Los Santos on 2/14/19.
//  Copyright © 2019 Speedy Movil. All rights reserved.
//

import UIKit

public class BankCardViewCell: UITableViewCell {

    lazy var cardContainerView: UIView = {
        let uiView = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.width , height: 90))
        uiView.borderColor = institutionalColors.claroButtonDetailGraphicSelect
        uiView.shadowRadius = 1
        uiView.shadowOpacity = 1
        uiView.shadowOffset.width = 0
        uiView.shadowOffset.height = 1
        uiView.borderWidth = 1
        uiView.shadowColor = institutionalColors.claroButtonDetailGraphicSelect
        
        return uiView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 10, y: 10, width: 50, height: 20))
        label.font = UIFont(name: RobotoFontName.RobotoBold.rawValue, size: CGFloat(12.0))
        label.text = "Tarjeta: "
        
        return label
    }()
    
    lazy var imageBankCard: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: self.titleLabel.frame.maxX , y: 10, width: 33, height: 18))
        
        return imageView
    }()
    
    lazy var numberCardLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: self.cardContainerView.frame.width - 210, y: 10, width: 200, height: 20))
        label.textAlignment = .right
        label.font = UIFont(name: RobotoFontName.RobotoBold.rawValue, size: CGFloat(12.0))
        label.text = "****4589"
        
        return label
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 10, y: self.imageBankCard.frame.maxY + 5, width: self.frame.width - 50, height: 20))
        label.font = UIFont(name: RobotoFontName.RobotoBold.rawValue, size: CGFloat(14.0))
        label.text = "Juan Martinez Perez"
        
        return label
    }()
    
    lazy var dateVigencyLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 10, y: self.nameLabel.frame.maxY , width: self.frame.width - 60, height: 25))
        label.font = UIFont(name: RobotoFontName.RobotoMedium.rawValue, size: CGFloat(12.0))
        label.text = "Fecha de vencimiento 10/2020"
        label.textColor = institutionalColors.claroLightGrayColor
        
        return label
    }()
    
    
    lazy var checkButton: UIButton = {
        let button = UIButton(frame: CGRect(x: self.cardContainerView.frame.width - 40, y: self.cardContainerView.frame.height/2, width: 20, height: 20))
        button.addTarget(self, action: #selector(selectedCheckButton), for: .touchUpInside)
        button.cornerRadius = 4
        button.backgroundColor = institutionalColors.claroWhiteColor
        button.borderColor = institutionalColors.claroBlueColor
        button.borderWidth = 2
        button.imageEdgeInsets = UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3)
        button.isEnabled = true
        button.isUserInteractionEnabled = true
        
        return button
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.cardContainerView.addSubview(titleLabel)
        self.cardContainerView.addSubview(imageBankCard)
        self.cardContainerView.addSubview(numberCardLabel)
        self.cardContainerView.addSubview(dateVigencyLabel)
        self.cardContainerView.addSubview(nameLabel)
        self.cardContainerView.addSubview(checkButton)
        self.addSubview(cardContainerView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override public func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func selectedCheckButton(){
        checkButton.isSelected = !checkButton.isSelected
        
        if checkButton.isSelected {
            checkButton.setImage(mcaUtilsHelper.getImage(image: "ic_tick"), for: .normal)
            checkButton.layer.backgroundColor = institutionalColors.claroBlueColor.cgColor
            checkButton.imageEdgeInsets = UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3)
            checkButton.cornerRadius = 4
            checkButton.borderColor = institutionalColors.claroBlueColor
            checkButton.borderWidth = 2
        }else{
            checkButton.cornerRadius = 4
            checkButton.backgroundColor = institutionalColors.claroWhiteColor
            checkButton.borderColor = institutionalColors.claroBlueColor
            checkButton.borderWidth = 2
            checkButton.imageEdgeInsets = UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3)
        }
        
    }

}
