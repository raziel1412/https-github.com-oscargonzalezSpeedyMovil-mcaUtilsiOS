//
//  CardSinBolsaView.swift
//  MiClaro
//
//  Created by Jorge Isai Garcia Reyes on 01/10/18.
//  Copyright © 2018 am. All rights reserved.
//

import UIKit

class CardsSinBolsa: UIView {
    
    @IBOutlet weak var viewContent: UIView!
    @IBOutlet weak var viewBorder: UIView!
    @IBOutlet weak var lblService: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblNote: UILabel!
    @IBOutlet weak var widthLblService: NSLayoutConstraint!
    @IBOutlet weak var heightDesc: NSLayoutConstraint!
    
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
        if let customView = Bundle.main.loadNibNamed("CardSinBolsaView", owner: self, options: nil)?.first as? UIView {
            viewParent = customView
            viewParent.frame = self.bounds
            viewParent.autoresizingMask = [.flexibleHeight, .flexibleWidth]
            addSubview(viewParent)
        }
    }
    
    func setDataInfo(data: DataGraphicCard) {
        let serviceFeatureType = data.serviceFeatureType
        self.lblService.text = "Sin Servicios"
        switch serviceFeatureType {
        case "Datos":
            self.lblDescription.text = "No tienes bolsas de \(serviceFeatureType) disponibles"
            break
        case "MINS":
            self.lblDescription.text = "No tienes bolsas de \(serviceFeatureType) disponibles"
            break
        case "SMS":
            self.lblDescription.text = "No tienes bolsas de \(serviceFeatureType) disponibles"
            break
        case "Minutos internacionales":
            if data.has3country{
                self.lblDescription.text = "No tienes bolsas de \(serviceFeatureType) 3 paises disponibles"
            }else{
                self.lblDescription.text = "No tienes bolsas de \(serviceFeatureType) 8 paises disponibles"
            }
            break
        default:
            self.lblDescription.text = "No tienes bolsas disponibles"
        }
        
    }
    
    func setDataWithImage(desc: String, note: String, imgString: String) {
        self.lblService.text = ""
        let imgView = UIImageView(frame: self.lblService.bounds)
        imgView.contentMode = .scaleAspectFit
        imgView.image = UIImage(named: imgString)
        self.lblService.addSubview(imgView)
        self.lblDescription.text = desc
        self.lblDescription.font = UIFont(name: RobotoFontName.RobotoBold.rawValue, size: 14.0)
        self.lblNote.text = note
        widthLblService.constant = self.frame.width * 0.35
        heightDesc.constant = 25
    }
    
    func getHeightView() -> CGFloat {
        return self.bounds.height
    }
}
