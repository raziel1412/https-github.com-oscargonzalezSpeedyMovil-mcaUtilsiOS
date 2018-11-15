//
//  CardHeaderSummaryView.swift
//  MiClaro
//
//  Created by Jonathan Abimael Cruz Orozco on 09/07/18.
//  Copyright © 2018 am. All rights reserved.
//

import UIKit

class CardHeaderSummaryView: UIView {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    
    var viewParent: UIView!
    /*********************** Constantes ***********************/
    let textConfiguration = SessionSingleton.sharedInstance.getGeneralConfig()
    /*********************** Constantes ***********************/
    /*********************** Textos de la interfaz ***********************/
    private var textTitle: String = ""
    /*********************** Textos de la interfaz ***********************/
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.instanceFromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.instanceFromNib()
    }
    
    private func instanceFromNib() {
        if let customView = Bundle.main.loadNibNamed("CardHeaderSummaryView", owner: self, options: nil)?.first as? UIView {
            viewParent = customView
            viewParent.frame = self.bounds
            viewParent.autoresizingMask = [.flexibleHeight, .flexibleWidth]
            addSubview(viewParent)
            
            self.setTextUI()
        }
    }
    
    private func setTextUI() {
        self.textTitle = self.textConfiguration?.translations?.data?.landing?.summaryTitle ?? ""
        self.lblTitle.text = self.textTitle
        self.lblDescription.text = ""
    }
}
