//
//  SelectOptionSuscription.swift
//  MiClaro
//
//  Created by Jonathan Abimael Cruz Orozco on 13/09/18.
//  Copyright © 2018 am. All rights reserved.
//

import UIKit

protocol SelectOptionSuscriptionDelegate {
    func showPopupSubscriptions()
}

class SelectOptionSuscription: UIView {
    @IBOutlet weak var viewContent: UIView!
    @IBOutlet weak var lblInstruction: UILabel!
    @IBOutlet weak var lblTitleOption: UILabel!
    @IBOutlet weak var imgArrow: UIImageView!
    
    var viewParent: UIView!
    var delegate: SelectOptionSuscriptionDelegate?
    let textConfiguration = SessionSingleton.sharedInstance.getGeneralConfig()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.instanceFromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.instanceFromNib()
    }
    
    private func instanceFromNib() {
        if let customView = Bundle.main.loadNibNamed("SelectOptionSuscription", owner: self, options: nil)?.first as? UIView {
            viewParent = customView
            viewParent.frame = self.bounds
            viewParent.autoresizingMask = [.flexibleHeight, .flexibleWidth]
            addSubview(viewParent)
            self.addUserInteraction()
            self.setTextUI(txtLbl: "")
        }
    }
    
    private func setTextUI(txtLbl: String) {
        if(txtLbl == ""){
            self.lblInstruction.text = textConfiguration?.translations?.data?.subscriptions?.subscriptionsCheckStatus ?? ""
        }else{
            self.lblInstruction.text = txtLbl
        }
    }
    
    /// Agregar acción para cambiar de cuentas
    private func addUserInteraction() {
        self.imgArrow.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(showSuscriptions))
        self.imgArrow.addGestureRecognizer(tap)
    }
    
    /// Acción para mostrar el listado de cuentas a elegir
    @objc private func showSuscriptions() {
        print("MOSTRAR SUSCRIPCIONES")
        self.delegate?.showPopupSubscriptions()
    }
    
    /// Mostrar informacion requerida
    func setDataInformation(titleOption: String) {
        self.lblTitleOption.text = titleOption
        self.lblTitleOption.adjustsFontSizeToFitWidth = true
    }
    
    /// Deshabilitar funcionalidad para mostrar el pop
    func disableActionButtonArrow() {
        self.imgArrow.isUserInteractionEnabled = false
        self.imgArrow.isHidden = true
    }
}
