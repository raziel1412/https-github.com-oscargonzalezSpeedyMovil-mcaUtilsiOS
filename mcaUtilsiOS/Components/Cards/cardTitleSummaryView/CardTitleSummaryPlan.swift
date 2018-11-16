//
//  CardTitleSummaryPlan.swift
//  MiClaro
//
//  Created by Jonathan Abimael Cruz Orozco on 04/07/18.
//  Copyright © 2018 am. All rights reserved.
//

import UIKit

class CardTitleSummaryPlan: UIView {

    @IBOutlet weak var viewContent: UIView!
    @IBOutlet weak var lblTitle: UILabel!

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
        if let customView = Bundle.main.loadNibNamed("CardTitleSummaryPlan", owner: self, options: nil)?.first as? UIView {
            viewParent = customView
            viewParent.frame = self.bounds
            viewParent.autoresizingMask = [.flexibleHeight, .flexibleWidth]
            addSubview(viewParent)
        }
    }
    
    func setTitle(title: String) {
        self.lblTitle.text = title
    }
}
