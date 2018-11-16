//
//  DetailSuscriptionView.swift
//  MiClaro
//
//  Created by Jonathan Abimael Cruz Orozco on 13/09/18.
//  Copyright © 2018 am. All rights reserved.
//

import UIKit

protocol DetailSuscriptionDelegate {
    func eraseSubscrip(index: Int)
}

class DetailSuscriptionView: UIView {

    @IBOutlet weak var viewContent: UIView!
    @IBOutlet weak var viewBorder: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblStatusText: UILabel!
    @IBOutlet weak var lblStatusDesc: UILabel!
    @IBOutlet weak var lblNumberShort: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var btnCustom: UIButton!
    
    var viewParent: UIView!
    
    var delegate: DetailSuscriptionDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.instanceFromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.instanceFromNib()
    }
    
    private func instanceFromNib() {
        if let customView = Bundle.main.loadNibNamed("DetailSuscriptionView", owner: self, options: nil)?.first as? UIView {
            viewParent = customView
            viewParent.frame = self.bounds
            viewParent.autoresizingMask = [.flexibleHeight, .flexibleWidth]
            addSubview(viewParent)
        }
    }
    
    @IBAction func desactivarSubscrip(_ sender: UIButton) {
       self.delegate?.eraseSubscrip(index: sender.tag)
    }
}
