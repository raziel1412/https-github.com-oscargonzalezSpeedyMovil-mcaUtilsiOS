//
//  WarningView.swift
//  MiClaro
//
//  Created by Roberto Gutierrez Resendiz on 10/11/17.
//  Copyright © 2017 am. All rights reserved.
//

import UIKit
import Foundation
import QuartzCore
import Cartography
import mcaManageriOS

/// Esta clase especializa un UIView para tener L&F de titulo de advertencia en los casos en que los servicios entregan respuesta de fallo o no hay resultados
public class WarningView: UIView {
    private var lblTexto : UILabel?
    private var imgWarning : UIImageView?

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override init(frame:CGRect) {
        super.init(frame:frame)
    }

    override public func awakeFromNib() {
        super.awakeFromNib()
    }

    func setup() {
        lblTexto = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 30))
        let myConf = mcaManagerSession.getGeneralConfig()
        self.imgWarning = UIImageView(image: UIImage(named: "ic_error_naranja_16px"));
        self.lblTexto?.text = myConf?.translations?.data?.generales?.serviceNotRespond ?? "Información no actualizada por el momento";
        self.lblTexto?.textColor = institutionalColors.claroTextColor;
        self.lblTexto?.font = UIFont(name: RobotoFontName.RobotoLight.rawValue, size: CGFloat(13));
        self.lblTexto?.textAlignment = .center
        self.lblTexto?.lineBreakMode = .byWordWrapping;
        self.lblTexto?.numberOfLines = 0;
        self.layer.borderColor = institutionalColors.claroOrangeColor.cgColor;
        self.layer.borderWidth = 1;

        self.addSubview(imgWarning!);
        self.addSubview(lblTexto!);

        //self.lblTexto?.sizeToFit();
        //self.lblTexto?.adjustHeighToFit();
        
        
        //self.sizeToFit();
        
        if let needs = self.lblTexto?.needAdjustHeightLabel(), needs.needs {
            self.lblTexto?.frame = CGRect(x: self.lblTexto!.frame.origin.x, y: self.lblTexto!.frame.origin.y, width: self.lblTexto!.frame.width, height: needs.newHeight)
            self.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: self.frame.width, height: needs.newHeight + 20)
        }

       constrain(self, imgWarning!, lblTexto!) { (vw, img, lbl) in
            img.centerY == vw.centerY
            img.height == vw.height * 0.5
            img.width == img.height
            img.trailing == lbl.leading;
            lbl.centerX == vw.centerX
            lbl.centerY == vw.centerY
            lbl.width == vw.width * 0.75
            lbl.height >= img.height * 2
        }
        
        
    }


}
