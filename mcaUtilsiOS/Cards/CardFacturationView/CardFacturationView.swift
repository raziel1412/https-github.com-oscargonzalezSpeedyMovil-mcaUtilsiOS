//
//  CardFacturationView.swift
//  MiClaro
//
//  Created by Jonathan Abimael Cruz Orozco on 24/07/18.
//  Copyright © 2018 am. All rights reserved.
//

import UIKit

class CardFacturationView: UIView {
    @IBOutlet weak var viewContent: UIView!
    @IBOutlet weak var viewBorder: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblStartDate: UILabel!
    @IBOutlet weak var lblEndDate: UILabel!
    @IBOutlet weak var lblDayPending: UILabel!
    
    /*********************** Constantes ***********************/
    let textConfiguration = SessionSingleton.sharedInstance.getGeneralConfig()
    /*********************** Constantes ***********************/
    /*********************** Variables ***********************/
    var viewParent: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.instanceFromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.instanceFromNib()
    }
    
    private func instanceFromNib() {
        if let customView = Bundle.main.loadNibNamed("CardFacturationView", owner: self, options: nil)?.first as? UIView {
            viewParent = customView
            viewParent.frame = self.bounds
            viewParent.autoresizingMask = [.flexibleHeight, .flexibleWidth]
            addSubview(viewParent)
        }
    }
    
    func setDataInfo(data: CycleInformation) {
        self.lblTitle.text = "Facturación"
        self.lblStartDate.text = "Inicio: " + data.startDate
        self.lblEndDate.text = "Fin: " + data.endDate
        self.lblDayPending.text = NSString(format: "Días restantes: %d", data.remainingDays) as String
    }
}
