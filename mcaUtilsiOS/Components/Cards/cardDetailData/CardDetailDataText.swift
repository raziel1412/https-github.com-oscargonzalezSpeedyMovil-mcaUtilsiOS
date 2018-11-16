//
//  CardDetailDataText.swift
//  MiClaro
//
//  Created by Jonathan Abimael Cruz Orozco on 08/08/18.
//  Copyright © 2018 am. All rights reserved.
//

import UIKit

class CardDetailDataText: UIView {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var borderView: UIView!
    @IBOutlet weak var lblDescPlan: UILabel!
    
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
        if let customView = Bundle.main.loadNibNamed("CardDetailDataText", owner: self, options: nil)?.first as? UIView {
            viewParent = customView
            viewParent.frame = self.bounds
            viewParent.autoresizingMask = [.flexibleHeight, .flexibleWidth]
            addSubview(viewParent)
        }
    }
    
    func setTextDescription(description: String) {
        self.lblDescPlan.text = description
        self.lblDescPlan.sizeToFit()
        self.lblDescPlan.adjustsFontSizeToFitWidth = true
    }
}
