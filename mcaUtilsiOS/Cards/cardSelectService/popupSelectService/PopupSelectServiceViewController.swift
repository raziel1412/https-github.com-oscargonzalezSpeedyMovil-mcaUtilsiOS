//
//  PopupSelectServiceViewController.swift
//  MiClaro
//
//  Created by Jonathan Abimael Cruz Orozco on 27/06/18.
//  Copyright © 2018 am. All rights reserved.
//

import UIKit

protocol PopupSelectServiceDelegate {
    func popupSelectServiceAcceptAction(indexService: Int)
}

class PopupSelectServiceViewController: UIViewController {

    @IBOutlet weak var viewContent: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var tbServices: UITableView!
    @IBOutlet weak var btnAccept: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    
    /*********************** Variables ***********************/
    var arrayServices: [CardsMovilModel] = []
    var arrayServiceID: [AssociatedServicesCard] = []
    var titlePopup: String = ""
    var indexSelected: Int = 0
    var delegate: PopupSelectServiceDelegate?
    /*********************** Variables ***********************/
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        self.view.isOpaque = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.showInfoTableView()
        self.lblTitle.text = self.titlePopup
        self.lblTitle.adjustsFontSizeToFitWidth = true
    }
    
    /// Obtener la informacion a mostrar en el listado
    func setDataInformationServices(arrayServices: [CardsMovilModel], title: String, indexSelect: Int) {
        self.arrayServices = arrayServices
        self.titlePopup = title
        self.indexSelected = indexSelect
    }
    
    func showInfoTableView() {
        for service in self.arrayServices {
            for serv in service.arrayServices {
                self.arrayServiceID.append(serv)
            }
        }
        self.tbServices.register(RadioButtonViewCell.self, forCellReuseIdentifier: "cell")
        self.tbServices.delegate = self
        self.tbServices.dataSource = self
    }
    
    /// Limpiar las opciones marcadas anteriormente
    func clearRadioButtons(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        for index  in 0 ..< self.arrayServiceID.count {
            let indexP = IndexPath(row: index, section: indexPath.section)
            if let cell = tableView.cellForRow(at: indexP) as? RadioButtonViewCell {
                cell.roundCheckMark.changeSelect(isSelected: index == indexPath.row);
            }
        }
    }
    
    //MARK: Button action
    @IBAction func btnAcceptAction(sender: UIButton) {
        self.dismiss(animated: true) {
            self.delegate?.popupSelectServiceAcceptAction(indexService: self.indexSelected)
        }
    }
    
    @IBAction func btnCancelAction(sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

}

//MARK: UITableViewDelegate, UITableViewDataSource
extension PopupSelectServiceViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayServiceID.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! RadioButtonViewCell
        cell.setMultipleSelection(enable: false)
        cell.setUbicationCheck(check: .right)
        cell.roundCheckMark.isUserInteractionEnabled = false
        cell.validationLabel.text = self.arrayServiceID[indexPath.row].nameService
        cell.roundCheckMark.changeSelect(isSelected: self.indexSelected == indexPath.row)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! RadioButtonViewCell
        if cell.getMultipleSelection() {
            //"Multiple selection"
            cell.roundCheckMark.changeSelect(isSelected: !cell.roundCheckMark.isSelected)
        }else {
            //"Single selection"
            self.indexSelected = indexPath.row
            self.clearRadioButtons(tableView, didSelectRowAt: indexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }
}
