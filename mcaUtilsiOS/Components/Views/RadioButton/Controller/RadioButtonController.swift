//
//  RadioButtonController.swift
//  MiClaro
//
//  Created by Jonathan Abimael Cruz Orozco on 18/08/17.
//  Copyright © 2017 am. All rights reserved.
//

import UIKit

extension RadioButtonView: UITableViewDelegate, UITableViewDataSource {

    //MARK: Table delegate and Data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! RadioButtonViewCell
        cell.setMultipleSelection(enable: self.multipleSelection)
        cell.setUbicationCheck(check: self.ubicationCheck)
        cell.roundCheckMark.isUserInteractionEnabled = false
        cell.validationLabel.text = arrayOptions[indexPath.row].description
        //cell.roundCheckMark.isEnabled = validationCheck[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! RadioButtonViewCell
        if cell.getMultipleSelection() {
            //"Multiple selection"
            cell.roundCheckMark.changeSelect(isSelected: !cell.roundCheckMark.isSelected)
        }else {
            //"Single selection"
            self.clearRadioButtons(tableView, didSelectRowAt: indexPath)
            delegate.radioButtonSingleOptionSelected(option: arrayOptions[indexPath.row])
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40.0
    }
    //MARK: Private functions
    /// Si la opción de selección es **multiple** se habilita el check seleccionado y los demas se quedan igual
    /// Si la opción de selección es **no es multiple** se habilita el check seleccionado y los demas se inhabilitan
    /// - Parameter tableView: Tabla que contiene las opciones de radioButton
    /// - Parameter indexPath: indice de la celda radioButton seleccionada
    private func clearRadioButtons(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        for index  in 0 ..< arrayOptions.count {
            let indexP = IndexPath(row: index, section: indexPath.section)
            let cell = tableView.cellForRow(at: indexP) as! RadioButtonViewCell
            if index == indexPath.row {
                cell.roundCheckMark.changeSelect(isSelected: true)
            }else {
                cell.roundCheckMark.changeSelect(isSelected: false)
            }
        }
    }
    
    //MARK: Public functions
    /// Para recuperar las opciones seleccionadas
    /// - Returns [RadioButtonOption]: Arreglo de opciones seleccionadas
    public func getOptionsSelected() -> [RadioButtonOption] {
        arrayOptionsSelected.removeAll()
        let sections = tblOptions.numberOfSections
        for sec in 0 ..< sections {
            for row in 0 ..< arrayOptions.count {
                let indexP = IndexPath(row: row, section: sec)
                let cell = tblOptions.cellForRow(at: indexP) as! RadioButtonViewCell
                
                if cell.roundCheckMark.isSelected {
                    arrayOptionsSelected.append(arrayOptions[row])
                }
            }
        }
        
        return arrayOptionsSelected
    }
}
