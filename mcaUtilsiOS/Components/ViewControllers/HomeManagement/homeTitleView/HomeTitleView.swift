//
//  HomeTitleView.swift
//  MiClaro
//
//  Created by Jonathan Abimael Cruz Orozco on 10/07/18.
//  Copyright © 2018 am. All rights reserved.
//

import UIKit

class HomeTitleView: UIView {

    @IBOutlet weak var viewContent: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSubTitle: UILabel!
    
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
        if let customView = Bundle.main.loadNibNamed("HomeTitleView", owner: self, options: nil)?.first as? UIView {
            viewParent = customView
            viewParent.frame = self.bounds
            viewParent.autoresizingMask = [.flexibleHeight, .flexibleWidth]
            addSubview(viewParent)
            self.layoutIfNeeded()
        }
    }
    
    func setDataText(title: String, subtitle: String) {
        self.lblTitle.text = title
        self.lblSubTitle.text = subtitle
    }

}
