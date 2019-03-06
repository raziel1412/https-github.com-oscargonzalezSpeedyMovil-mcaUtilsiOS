//
//  TermsAnsConditionsView.swift
//  mcaUtilsiOS
//
//  Created by Ricardo Rodriguez De Los Santos on 3/6/19.
//  Copyright © 2019 Roberto. All rights reserved.
//

import UIKit

public class TermsAndConditionsView: UIView {

    var actionCheckBox: () -> Void = {}
    
    lazy var lblTermsAndConditions: UILabel = {
        let label = UILabel(frame: CGRect(x: 20, y: 0, width: self.frame.width - 40, height: 30))
        label.font = UIFont(name: RobotoFontName.RobotoMedium.rawValue, size: CGFloat(14.0))
        label.text = "Terminos y condiciones"
        label.textColor = institutionalColors.claroRedColor
        
        return label
    }()
    
    public lazy var viewTermsAndConditions: TermsAndConditions = {
        let view = TermsAndConditions(frame: CGRect(x: 20, y: self.lblTermsAndConditions.frame.maxY + 10 , width: self.frame.width - 40, height: 40))
        view.checkBox.addTarget(self, action: #selector(enableButtonFinalReload), for: .touchUpInside)
        
        return view
    }()
    
    public init(frame:CGRect ,actionCheckBox: @escaping () -> Void) {
        super.init(frame:frame)
        self.actionCheckBox = actionCheckBox
        
        self.addSubview(self.lblTermsAndConditions)
        self.addSubview(self.viewTermsAndConditions)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func enableButtonFinalReload(){
        self.actionCheckBox()
    }
}
