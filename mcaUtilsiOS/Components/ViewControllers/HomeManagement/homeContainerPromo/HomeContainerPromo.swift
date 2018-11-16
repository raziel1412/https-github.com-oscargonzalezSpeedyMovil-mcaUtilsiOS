//
//  HomeContainerPromo.swift
//  MiClaro
//
//  Created by Jonathan Abimael Cruz Orozco on 11/07/18.
//  Copyright © 2018 am. All rights reserved.
//

import UIKit

protocol HomeContainerPromoDelegate {
    func showPromotionWeb(url: String)
}

class HomeContainerPromo: UIView {

    @IBOutlet weak var viewContent: UIView!
    
    var viewParent: UIView!
    var delegate: HomeContainerPromoDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.instanceFromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.instanceFromNib()
    }
    
    private func instanceFromNib() {
        if let customView = Bundle.main.loadNibNamed("HomeContainerPromo", owner: self, options: nil)?.first as? UIView {
            viewParent = customView
            viewParent.frame = self.bounds
            viewParent.autoresizingMask = [.flexibleHeight, .flexibleWidth]
            addSubview(viewParent)
            self.layoutIfNeeded()
        }
    }
    
    func setDataPromos(arrayPromos: [Promos]) {
        var posY: CGFloat = 0.0
        for promo in arrayPromos {
            let framePromo = CGRect(x: 0, y: posY, width: self.viewContent.bounds.width, height: 135)
            let viewPromo = HomePromoImageView(frame: framePromo)
            self.viewContent.addSubview(viewPromo)
            viewPromo.setDataInfo(dataPromo: promo)
            viewPromo.delegate = self
            posY += 135
        }
    }
}

extension HomeContainerPromo: HomePromoImageViewDelegate {
    func showPromotionWeb(url: String) {
        self.delegate?.showPromotionWeb(url: url)
    }
}
