//
//  CardHeaderServiceView.swift
//  MiClaro
//
//  Created by Jonathan Abimael Cruz Orozco on 27/06/18.
//  Copyright © 2018 am. All rights reserved.
//

import UIKit

protocol UpgradePlanDelegate {
    func upgradePlan();
}

class CardHeaderServiceView: UIView {
    @IBOutlet weak var viewContent: UIView!
    @IBOutlet weak var imgService: UIImageView!
    @IBOutlet weak var lblNameService: UILabel!
    @IBOutlet weak var lblNamePlan: UILabel!
    @IBOutlet weak var lblUpdatePlan: UILabel!

    /*********************** Constantes ***********************/
    let textConfiguration = SessionSingleton.sharedInstance.getGeneralConfig()
    /*********************** Constantes ***********************/
    
    /*********************** Variables ***********************/
    private var textMobile: String = ""
    private var textPrepaid: String = ""
    private var textPostpaid: String = ""
    private var textTV: String = ""
    private var textAllPackage: String = ""
    private var textInternet: String = ""
    private var textLineaFija: String = ""
    private var textSuscripciones: String = ""
    /*********************** Variables ***********************/

    var upgradePlanDelegate : UpgradePlanDelegate?

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
        if let customView = Bundle.main.loadNibNamed("CardHeaderServiceView", owner: self, options: nil)?.first as? UIView {
            viewParent = customView
            viewParent.frame = self.bounds
            viewParent.autoresizingMask = [.flexibleHeight, .flexibleWidth]
            addSubview(viewParent)
            self.setTextUI()
        }
    }
    
    private func setTextUI() {
        self.textMobile = textConfiguration?.translations?.data?.generales?.mobile ?? ""
        self.textPrepaid = textConfiguration?.translations?.data?.generales?.prepaid ?? ""
        self.textPostpaid = textConfiguration?.translations?.data?.generales?.postpaid ?? ""
        self.textTV = textConfiguration?.translations?.data?.generales?.tv ?? ""
        self.textAllPackage = textConfiguration?.translations?.data?.generales?.allPackage ?? ""
        self.textInternet = textConfiguration?.translations?.data?.generales?.internet ?? ""
        self.textLineaFija = textConfiguration?.translations?.data?.generales?.fixedLine ?? ""
        self.textSuscripciones = textConfiguration?.translations?.data?.subscriptions?.subscriptionsTitle ?? ""
    }
    
    func setTextSuscrip(typeCard: TypeCardView, title: String, descrip: String) {
        self.lblNameService.text = title
        self.lblNamePlan.text = descrip
        
        let nameImage = self.getImageService(typeCard: typeCard)
        self.imgService.image = UIImage(named: nameImage)
        
        self.lblUpdatePlan.text = "";
        self.lblUpdatePlan.isHidden = true;
        self.lblUpdatePlan.isUserInteractionEnabled = false;
    }
    
    func updateDataHeader(typeCard: TypeCardView, typeService: TypeAccountService, namePlan: String) {
        self.lblNameService.text = self.getNameService(typeAccount: typeService)
        self.lblNamePlan.text = namePlan
        let nameImage = self.getImageService(typeCard: typeCard)
        self.imgService.image = UIImage(named: nameImage)

        if (typeService == .MovilPospago) {
            let updateText = textConfiguration?.translations?.data?.updatePlan?.updatePlanHeader ?? "";
            let attributedText = NSMutableAttributedString(string: updateText);
            let rango = NSMakeRange(0, updateText.count);
//            attributedText.addAttribute(NSUnderlineStyleAttributeName, value: NSUnderlineStyle.styleSingle.rawValue, range: rango);
            attributedText.addAttribute(NSForegroundColorAttributeName, value: institutionalColors.claroBlueColor, range: rango);
            attributedText.addAttribute(NSFontAttributeName, value: UIFont(name: RobotoFontName.RobotoRegular.rawValue, size: 14) as Any, range: rango);
            self.lblUpdatePlan.attributedText = attributedText
            self.lblUpdatePlan.isHidden = false;
            self.lblUpdatePlan.isUserInteractionEnabled = true;
            let clickUpdatePlan = UITapGestureRecognizer(target: self, action: #selector(upgradePlanClick));
            self.lblUpdatePlan.gestureRecognizers?.removeAll();
            self.lblUpdatePlan.addGestureRecognizer(clickUpdatePlan);
        } else {
            self.lblUpdatePlan.text = "";
            self.lblUpdatePlan.isHidden = true;
            self.lblUpdatePlan.isUserInteractionEnabled = false;
        }

    }

    @objc private func upgradePlanClick() {
        self.upgradePlanDelegate?.upgradePlan();
    }

    private func getNameService(typeAccount: TypeAccountService) -> String {
        var titleService: String = ""
        switch typeAccount {
        case .MovilPrepago:
            titleService =  self.textMobile + " " + self.textPrepaid
            break
        case .MovilPospago:
            titleService = self.textMobile + " " + self.textPostpaid
            break
        case .Television:
            titleService = self.textTV
            break
        case .TodoClaro:
            titleService = self.textAllPackage
            break
        case .Internet:
            titleService = self.textInternet
            break
        case .LineaFija:
            titleService = self.textLineaFija
            break
        case .Suscripcion:
            titleService = self.textSuscripciones
            break
        default:
            break
        }
        
        return titleService
    }
    
    private func getImageService(typeCard: TypeCardView) -> String {
        var nameImage: String = ""
        
        switch typeCard {
        case .Móvil:
            nameImage = "ico_seccion_mc_movil"
            break
        case .Internet:
            nameImage = "ico_seccion_mc_internet"
            break
        case .Teléfono:
            nameImage = "ico_seccion_mc_telefono"
            break
        case .TodoClaro:
            nameImage = "ico_seccion_mc_todoclaro"
            break
        case .Televisión:
            nameImage = "ico_seccion_mc_tv"
            break
        case .Suscripción:
            nameImage = "ico-mensaje2"
            break
        default:
            break
        }
        
        return nameImage
    }
}
