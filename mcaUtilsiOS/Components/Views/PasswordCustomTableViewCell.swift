//
//  PasswordCustomTableViewCell.swift
//  MiClaro
//
//  Created by Mauricio Javier Perez Flores on 8/3/17.
//  Copyright © 2017 am. All rights reserved.
//

import UIKit
import Cartography

/// Esta clase que hereda de UITableViewCell se utiliza junto con PasswordValContainerView para realizar la función de captura, analisis y despliegue de passwords y su validación
public class PasswordCustomTableViewCell: UITableViewCell {

    var validationLabel: BlackBodyLabel!
    var roundCheckMark: RoundedCheckbox!

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    
        validationLabel = BlackBodyLabel()
        validationLabel.textAlignment = .left
        contentView.addSubview(validationLabel)

        roundCheckMark = RoundedCheckbox()
        roundCheckMark.isSelected = false
        roundCheckMark.isUserInteractionEnabled = false
        contentView.addSubview(roundCheckMark)

        
        constrain(contentView, roundCheckMark, validationLabel) { (view1, view2, view3) in
            view2.top == view1.top
            view2.leading == view1.leading
            view2.centerY == view1.centerY
            //view3.baseline == view2.baseline
            view3.centerY == view2.centerY
            distribute(by: 10, horizontally: view2, view3)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override public func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
