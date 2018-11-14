//
//  PasswordValContainerView.swift
//  MiClaro
//
//  Created by Mauricio Javier Perez Flores on 8/3/17.
//  Copyright © 2017 am. All rights reserved.
//

import UIKit
import Cartography

/// Esta clase especializa un UITableView para agregar la funcionalidad de validación de passwords iguales en los casos de Recuperación de Contraseña.
class PasswordValContainerView: UITableView, UITableViewDataSource, UITableViewDelegate {

    var validationArray = [passwordValidation.between6and12Characters, passwordValidation.atLeastOneNumber, passwordValidation.atLeastOneLetter]
    var validationCheck = [false,false,false];
    
    var lengthLabel: BlackBodyLabel!
    var numbersLabel: BlackBodyLabel!
    var charsLabel: BlackBodyLabel!
    var symbolsLabel: BlackBodyLabel!
    static let identifier = "cell"
    static let identifier2 = "cell2"
    
    
    func setPosition() {
    
        self.register(PasswordCustomTableViewCell.self, forCellReuseIdentifier: PasswordValContainerView.identifier)
        self.register(SymbolsCustomTableViewCell.self, forCellReuseIdentifier: PasswordValContainerView.identifier2)
        self.allowsSelection = false
        self.separatorStyle = .none
        self.dataSource = self
        self.delegate = self
        self.isScrollEnabled = false
//        self.addSubview(tableViewContainer)

    }
    
    func updateDataSource() {
        DispatchQueue.main.async {
            self.reloadData()
        }
    }
    
    func resetValidationCheck() {
        validationCheck[0] = false
        validationCheck[1] = false
        validationCheck[2] = false
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return validationArray.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let lastRowIndex = tableView.numberOfRows(inSection: tableView.numberOfSections-1)

        if !(indexPath.row == lastRowIndex - 1) {
        
            let cell = tableView.dequeueReusableCell(withIdentifier: PasswordValContainerView.identifier, for: indexPath) as! PasswordCustomTableViewCell
            cell.validationLabel.text = validationArray[indexPath.row]
            //cell.roundCheckMark.isEnabled = validationCheck[indexPath.row]
            cell.roundCheckMark.changeSelect(isSelected: validationCheck[indexPath.row])
            
            return cell

        } else {
        
            let cell = tableView.dequeueReusableCell(withIdentifier: PasswordValContainerView.identifier2, for: indexPath) as! SymbolsCustomTableViewCell
            cell.symbolsLabel.text = NSLocalizedString("symbolsValidation", comment: "")
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 20
    }
    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
