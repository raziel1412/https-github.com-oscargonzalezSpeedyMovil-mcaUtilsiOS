//
//  PasswordRulesContainer.swift
//  MiClaro
//
//  Created by Fernando Rodriguez Minguet on 31/05/18.
//  Copyright © 2018 am. All rights reserved.
//

import UIKit
import Cartography


class PasswordRulesContainer : UIView {
    
    private var titleLabel : UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont(name: RobotoFontName.RobotoRegular.rawValue, size: 12.0)
        label.textAlignment = .left
        return label
    }()
    
    private var rulesLabel : UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 0
        label.font = UIFont(name: RobotoFontName.RobotoRegular.rawValue, size: 12.0)
        label.textAlignment = .left
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupElements()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupElements() {
        self.addSubview(titleLabel)
        self.addSubview(rulesLabel)
        setupConstraints()
    }
    
    private func setupConstraints() {
        constrain(self, titleLabel, rulesLabel) { (view, title, rules) in
            title.top == view.top
            title.leading == view.leading + 16.0
            title.trailing == view.trailing
            title.height == 15.0
            
            rules.top == title.top + 16.0
            rules.leading == view.leading + 16.0
            rules.trailing == view.trailing
            rules.bottom == view.bottom
            
        }
    }
    
    public func setupContent(title: String?, rules: [String?]) {
        self.titleLabel.text = title != nil ? title! : ""
        var rulesString = ""
        rules.forEach({
            rulesString += $0 != nil ? "\($0!)\n" : ""
        })
        rulesString.removeLast()
        self.rulesLabel.text = rulesString
    }
    
    
}

