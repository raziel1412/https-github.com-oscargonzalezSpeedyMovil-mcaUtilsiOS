//
//  CardSelectServiceView.swift
//  MiClaro
//
//  Created by Jonathan Abimael Cruz Orozco on 27/06/18.
//  Copyright © 2018 am. All rights reserved.
//

import UIKit

protocol CardSelectServiceDelegate {
    func showPopupServices()
}

class CardSelectServiceView: UIView {
    
    @IBOutlet weak var borderView: DesignableView!
    @IBOutlet weak var viewContent: UIView!
    @IBOutlet weak var lblInstruction: UILabel!
    @IBOutlet weak var lblTitleOption: UILabel!
    @IBOutlet weak var lblNameOption: UILabel!
    @IBOutlet weak var imgArrow: UIImageView!
    
    var viewParent: UIView!
    var delegate: CardSelectServiceDelegate?
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
        if let customView = Bundle.main.loadNibNamed("CardSelectServiceView", owner: self, options: nil)?.first as? UIView {
            viewParent = customView
            viewParent.frame = self.bounds
            viewParent.autoresizingMask = [.flexibleHeight, .flexibleWidth]
            addSubview(viewParent)
            self.addUserInteraction()
            self.setTextUI(txtLbl: "")
        }
    }
    
    ///
    func setTextUI(txtLbl: String) {
        if(txtLbl == ""){
              self.lblInstruction.text = textConfiguration?.translations?.data?.generales?.chooseOne ?? ""
        }else{
            self.lblInstruction.text = txtLbl
        }
    }
    /// Agregar acción para cambiar de cuentas
    private func addUserInteraction() {
        self.imgArrow.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(showMovilServices))
        self.imgArrow.addGestureRecognizer(tap)
    }
    
    /// Acción para mostrar el listado de cuentas a elegir
    @objc private func showMovilServices() {
        print("MOSTRAR CUENTAS MOVILES")
        self.delegate?.showPopupServices()
    }

    /// Mostrar informacion requerida
    func setDataInformation(titleOption: String, namePlanOption: String) {
        self.lblTitleOption.text = titleOption
        self.lblTitleOption.adjustsFontSizeToFitWidth = true
        self.lblNameOption.text = namePlanOption
    }
    
    /// Deshabilitar funcionalidad para mostrar el pop
    func disableActionButtonArrow() {
        self.imgArrow.isUserInteractionEnabled = false
        self.imgArrow.isHidden = true
    }
}
