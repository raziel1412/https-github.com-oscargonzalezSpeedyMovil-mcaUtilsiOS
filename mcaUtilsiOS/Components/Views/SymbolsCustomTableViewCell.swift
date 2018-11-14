//
//  SymbolsCustomTableViewCell.swift
//  MiClaro
//
//  Created by Mauricio Javier Perez Flores on 8/3/17.
//  Copyright © 2017 am. All rights reserved.
//

import UIKit
import Cartography

/// Esa clase se utiliza junto con PasswordValContainerView para mostrar las caracerísticas que cumple o no la validación de passwords
class SymbolsCustomTableViewCell: UITableViewCell {

    var symbolsLabel: BlackBodyLabel!
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        symbolsLabel = BlackBodyLabel()
        symbolsLabel.textColor = institutionalColors.claroLightGrayColor
        contentView.addSubview(symbolsLabel)
        
        constrain(contentView, symbolsLabel) { (view1, view2) in
            view2.top == view1.top + 5
            view2.leading == view1.leading + 30
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
