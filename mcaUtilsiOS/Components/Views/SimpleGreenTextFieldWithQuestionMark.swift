//
//  SimpleGreenTextFieldWithQuestionMark.swift
//  MiClaro
//
//  Created by Roberto Gutierrez Resendiz on 02/08/17.
//  Copyright © 2017 am. All rights reserved.
//

import UIKit
import FontAwesome_swift

/// Esta clase es similar a SimpleGreenTextField, pero agrega la capacidad de mostrar un icono representando mas ayuda
class SimpleGreenTextFieldWithQuestionMark: SimpleGreenTextField {
    private var btnView : UIButton?;

    var action = {};

    override init(text: String, placeholder: String) {
        super.init(text: text, placeholder: placeholder);

        setup();
    }

    convenience required init?(coder aDecoder: NSCoder) {
        self.init(coder: aDecoder);
        setup();
    }

    private func setup() {
        self.rightViewMode = .always;

        let dim = 32;
        
        let imgNormal = UIImage(named: "icon_question_input")//UIImage.fontAwesomeIcon(name: .questionCircleO, textColor: institutionalColors.claroBlueColor, size: CGSize(width: dim, height: dim));
        let imgActive = UIImage(named: "icon_question_input")//UIImage.fontAwesomeIcon(name: .questionCircle, textColor: institutionalColors.claroBlueColor, size: CGSize(width: dim, height: dim));
        btnView = UIButton(type: UIButtonType.custom);

        btnView?.setImage(imgNormal, for: UIControlState.normal);
        btnView?.setImage(imgActive, for: UIControlState.highlighted);
        btnView?.frame = CGRect(x: 0, y: 0, width: dim, height: dim);
        btnView?.addTarget(self, action: #selector(cmdButton_OnClick(sender:)), for: .touchUpInside);
        self.rightView = btnView;
    }

    func cmdButton_OnClick(sender : UIButton) {
        action();
    }

    func hideQuestionMark() {
        self.rightView = nil;
    }

    func showQuestionMark() {
        setup();
    }


}
