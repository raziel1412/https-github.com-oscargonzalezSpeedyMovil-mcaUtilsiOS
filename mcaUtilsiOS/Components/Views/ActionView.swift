//
//  ActionView.swift
//  MiClaro
//
//  Created by Omar Israel Trujillo Osornio on 10/22/18.
//  Copyright © 2018 am. All rights reserved.
//

import Foundation
import UIKit

protocol ActionViewDelegate {
    func resultOk()
}

public class ActionView : UIView {
    
    var btnShowTicket: GreenBorderWhiteBackgroundButton!
    let viewModalActionBlack = UIView()
    let viewModalActionWhite = UIView()
    let img = UIImageView()
    let lbTitle = UILabel()
    let lbTitleDetail = UILabel()
    var delegate : ActionViewDelegate!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override init(frame : CGRect) {
        super.init(frame:frame)
    }
    override public func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    func setup(imagen: UIImage, title:  String, subTitle: String, titleBtn: String) {
        
        self.frame = CGRect (x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        //let conf = SessionSingleton.sharedInstance.getGeneralConfig()
        viewModalActionBlack.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        viewModalActionBlack.backgroundColor = institutionalColors.claroBlackColor.withAlphaComponent(0.6)
        viewModalActionWhite.frame = CGRect(x: 30, y: viewModalActionBlack.frame.size.height * 0.15, width: viewModalActionBlack.frame.width - 60, height: viewModalActionBlack.frame.height - 300)
        viewModalActionWhite.backgroundColor = institutionalColors.claroWhiteColor
        let marginX : CGFloat = viewModalActionWhite.frame.width * 0.05
        let viewWidth : CGFloat = viewModalActionWhite.frame.width
        
        //let imagen = UIImage(named: "ico_cuenta_exitosa")
        img.image = imagen
        img.frame = CGRect(x: viewModalActionWhite.frame.width / 2 - 50, y: 30, width: 100, height: 100)
        
        lbTitle.frame =  CGRect(x: viewModalActionWhite.frame.width / 2 - 110 , y: img.frame.maxY + 20, width:220, height: 40)
        lbTitle.text = title
        lbTitle.textColor = institutionalColors.claroBlackColor
        lbTitle.textAlignment = .center
        lbTitle.font = UIFont(name: RobotoFontName.RobotoBold.rawValue, size: 22.0)
        
        lbTitleDetail.frame = CGRect(x: 20, y: img.frame.maxY + 40, width: viewModalActionWhite.frame.width - 40, height:100)
        lbTitleDetail.text = subTitle
        lbTitleDetail.textColor = institutionalColors.claroBlackColor
        lbTitleDetail.font = UIFont(name: RobotoFontName.RobotoLight.rawValue, size: 16.0)
        lbTitleDetail.numberOfLines = 2
        lbTitleDetail.textAlignment = .center
        
        btnShowTicket = GreenBorderWhiteBackgroundButton(textButton: titleBtn)
        btnShowTicket.addTarget(self, action: #selector(showTicketAction), for: UIControlEvents.touchUpInside)
        btnShowTicket.frame = CGRect(x: marginX, y: lbTitleDetail.frame.maxY + 10, width: viewWidth - (marginX*2), height: 40)
        
        viewModalActionWhite.frame = CGRect(x: 30, y: viewModalActionBlack.frame.size.height * 0.15, width: viewModalActionBlack.frame.width - 60, height: btnShowTicket.frame.maxY + 30)
        viewModalActionWhite.center = CGPoint(x: viewModalActionBlack.center.x, y: viewModalActionBlack.center.y - 30)
        
        UIApplication.shared.keyWindow?.addSubview(viewModalActionBlack)
        viewModalActionBlack.addSubview(viewModalActionWhite)
        viewModalActionWhite.addSubview(img)
        viewModalActionWhite.addSubview(lbTitle)
        viewModalActionWhite.addSubview(lbTitleDetail)
        viewModalActionWhite.addSubview(btnShowTicket)
        
        viewModalActionBlack.isHidden = false
        viewModalActionWhite.isHidden = false
        img.isHidden = false
        lbTitle.isHidden = false
        lbTitleDetail.isHidden = false
        btnShowTicket.isHidden = false
    }
    
    func showTicketAction(){
        print("Clic ActionView")
        self.delegate?.resultOk()
    }
}
