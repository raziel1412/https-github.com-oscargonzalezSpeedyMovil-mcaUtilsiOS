//
//  SquaredCheckbox.swift
//  MiClaro
//
//  Created by Roberto Gutierrez Resendiz on 01/08/17.
//  Copyright © 2017 am. All rights reserved.
//

import UIKit
import FontAwesome_swift

/// Esta clase especializa un UIButton para permitirle tener apariencia visual de Checkbox cuadrado.
public class SquaredCheckbox: UIButton {
    override init(frame: CGRect = CGRect(x: 0, y: 0, width: 0, height: 0)) {
        super.init(frame: frame);
        setup();
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
        setup();
    }

    func setup() {
        self.frame.size.width = 32;
        self.frame.size.height = 32;
        let tam = CGSize(width: self.frame.size.width, height: self.frame.size.height);
        let imgSelected = UIImage.fontAwesomeIcon(name: .checkSquare, textColor: institutionalColors.claroBlueColor, size: tam);
        self.setImage(imgSelected, for: UIControlState.selected);
        let imgUnSelected = UIImage.fontAwesomeIcon(name: .squareO, textColor: institutionalColors.claroTextColor, size: tam);
        self.setImage(imgUnSelected, for: UIControlState.normal);
        self.addTarget(self, action: #selector(change), for: .touchUpInside);
        self.isSelected = false;
    }

    func change(sender:UIButton) {
        self.isSelected = !self.isSelected;
    }
}
