//
//  MandatoryInformation.swift
//  MiClaro
//
//  Created by Fernando Rodriguez Minguet on 30/05/18.
//  Copyright © 2018 am. All rights reserved.
//

import UIKit
import Cartography
//import mcaManageriOS

public class MandatoryInformation: UIView {

    private var mandatoryField : UILabel = {
        let label = UILabel(frame: .zero)
        label.text = ""
        label.textColor = institutionalColors.claroRedColor
        label.font =  UIFont.init(name: RobotoFontName.RobotoRegular.rawValue, size: 10)
        label.textAlignment = .left
        return label
    }()
    
    private var mandatoryText = ""//mcaManagerSession.getGeneralConfig()?.translations?.data?.generales?.emptyField ?? ""
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(mandatoryField)
        setupConstraint()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
        self.addSubview(mandatoryField)
        setupConstraint()
    }
    
    private func setupConstraint() {
        constrain(self, mandatoryField) { (view, field) in
            field.top == view.top
            field.leading == view.leading
            field.trailing == view.trailing
            field.bottom == view.bottom
        }
    }
    
    public func hideView() {
        UIView.animate(withDuration: 1.0) {
            self.mandatoryField.text = ""
        }
    }
    
    public func displayView(customString: String? = nil) {
        UIView.animate(withDuration: 1.0) {
            if let displayText = customString, displayText.count > 0 {
                self.mandatoryField.text = customString!
            } else {
                self.mandatoryField.text = self.mandatoryText
            }
        }
    }
    
    
}
