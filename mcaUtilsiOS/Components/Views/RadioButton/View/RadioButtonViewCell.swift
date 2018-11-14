//
//  RadioButtonViewCell.swift
//  MiClaro
//
//  Created by Jonathan Abimael Cruz Orozco on 18/08/17.
//  Copyright © 2017 am. All rights reserved.
//

import UIKit
import Cartography

enum ubicationRadioButton {
    case left
    case right
}

class RadioButtonViewCell: UITableViewCell {

    var validationLabel: BlackBodyLabel!
    var roundCheckMark: RoundedCheckbox!
    //Value for default
    private var ubicationCheck:ubicationRadioButton = ubicationRadioButton.left
    private var multipleSelection:Bool = false
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    /// Creación y posicionamiento de los componentes visuales que seran mostrados en la interfaz.
    func setup() {
        if nil == validationLabel {
            validationLabel = BlackBodyLabel()
        }
        validationLabel.font = UIFont(name: RobotoFontName.RobotoLight.rawValue, size: CGFloat(14))
        //validationLabel.backgroundColor = UIColor.gray
        if false == contentView.subviews.contains(where: { $0 == validationLabel }) {
            contentView.addSubview(validationLabel)
        }

        if nil == roundCheckMark {
            roundCheckMark = RoundedCheckbox(frame: CGRect(x: 0.0, y: 0.0, width: 20.0, height: 20.0))
        }
        roundCheckMark.isSelected = false
        roundCheckMark.isUserInteractionEnabled = false
        if false == contentView.subviews.contains(where: { $0 == roundCheckMark }) {
            contentView.addSubview(roundCheckMark)
        }
        
        if ubicationCheck == ubicationRadioButton.left {
            validationLabel.textAlignment = .right
            constrain(contentView, roundCheckMark, validationLabel) { (view1, view2, view3) in
                view2.top == view1.top
                view2.leading == view1.leading + 10.0
                view2.centerY == view1.centerY
                view3.centerY == view1.centerY
                view3.trailing == view1.trailing - 10.0
                view3.width == view1.width - 35.0
            }
        }else {
            validationLabel.textAlignment = .left
            constrain(contentView, roundCheckMark, validationLabel) { (view1, view2, view3) in
                view2.top == view1.top
                view2.trailing == view1.trailing - 10.0
                view2.centerY == view1.centerY
                view3.centerY == view1.centerY
                view3.leading == view1.leading + 10.0
//                view3.width == view1.width - 35.0
            }
        }
    }
    
    /// Para definir la posición del check del radioButton
    /// - Parameter check: Puede tener los siguientes valores *left* o *right*
    func setUbicationCheck(check : ubicationRadioButton) {
        self.ubicationCheck = check;
        setup()
    }
    
    /// Para obtener la posición actual del check del radioButton
    func getUbicationCheck() -> ubicationRadioButton {
        return self.ubicationCheck;
    }
    
    /// Para habilitar la multiple selección de checks
    /// - Parameter enable: Si el valor es *true*, la multiple selección esta activa, si el valor es *false*, solo se permite seleccionar una opción
    func setMultipleSelection(enable: Bool) {
        self.multipleSelection = enable
    }
    
    /// Para saber si esta o no activa la multiple selección
    func getMultipleSelection() -> Bool {
        return self.multipleSelection
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    /// Para habilitar el check del radioButton
    /// - Parameter selected: Si el valor es *true* se activa el check, si el valor es *false* se desactiva el check
    /// - Parameter animated: Para agregar animación a la acción de habilitar el check
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
