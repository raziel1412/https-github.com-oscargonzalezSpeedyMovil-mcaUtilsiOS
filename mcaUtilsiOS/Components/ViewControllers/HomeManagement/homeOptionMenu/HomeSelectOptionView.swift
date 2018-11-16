//
//  HomeSelectOptionView.swift
//  MiClaro
//
//  Created by Jonathan Abimael Cruz Orozco on 10/07/18.
//  Copyright © 2018 am. All rights reserved.
//

import UIKit

protocol HomeSelectOptionViewDelegate {
    func showHomeOptionSelect(nameSection: String)
}

class HomeSelectOptionView: UIView {

    @IBOutlet weak var viewContent: UIView!
    @IBOutlet weak var viewBorder: UIView!
    @IBOutlet weak var imgService: UIImageView!
    @IBOutlet weak var lblTitleService: UILabel!
    @IBOutlet weak var lblDescService: UILabel!
    
    var viewParent: UIView!
    var delegate: HomeSelectOptionViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.instanceFromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.instanceFromNib()
    }
    
    private func instanceFromNib() {
        if let customView = Bundle.main.loadNibNamed("HomeSelectOptionView", owner: self, options: nil)?.first as? UIView {
            viewParent = customView
            viewParent.frame = self.bounds
            viewParent.autoresizingMask = [.flexibleHeight, .flexibleWidth]
            addSubview(viewParent)
            self.layoutIfNeeded()
        }
    }
    
    func setDataOption(dataOption: HomeSelectOptionModel) {
        self.lblTitleService.text = dataOption.title
        self.lblDescService.text = dataOption.subtitle
        self.imgService.image = UIImage(named: dataOption.nameImageService)
        
        let tapOptionView = UITapGestureRecognizer(target: self, action: #selector(showOptionSelectViewController))
        self.viewBorder.isUserInteractionEnabled = true
        self.viewBorder.addGestureRecognizer(tapOptionView)
    }
    
    @objc func showOptionSelectViewController() {
        self.delegate?.showHomeOptionSelect(nameSection: self.lblTitleService.text!)
    }
}

class HomeSelectOptionModel {
    var nameImageService: String = ""
    var title: String = ""
    var subtitle: String = ""
    
    func setNameImage(nameImage: String) {
        self.nameImageService = nameImage
    }
    
    func setTitle(title: String) {
        self.title = title
    }
    
    func setSubtitle(subtitle: String) {
        self.subtitle = subtitle
    }
}
