//
//  CardSummaryDetailView.swift
//  MiClaro
//
//  Created by Jonathan Abimael Cruz Orozco on 09/07/18.
//  Copyright © 2018 am. All rights reserved.
//

import UIKit

protocol CardSummaryDetailDelegate {
    func showDetailAccount(typeAccount: TypeAccountService, serviceName: String)
}

class CardSummaryDetailView: UIView {

    @IBOutlet weak var viewContent: UIView!
    @IBOutlet weak var imgIcon: UIImageView!
    @IBOutlet weak var lblNameService: UILabel!
    @IBOutlet weak var lblAccount: UILabel!
    @IBOutlet weak var lblAmount: UILabel!
    @IBOutlet weak var lblDateVigency: UILabel!
    @IBOutlet weak var btnShowDetail: UIButton!
    
    /*********************** Constantes ***********************/
    let textConfiguration = SessionSingleton.sharedInstance.getGeneralConfig()
    /*********************** Constantes ***********************/
    /*********************** Variables ***********************/
    var viewParent: UIView!
    var delegate: CardSummaryDetailDelegate?
    private var typeAccount: TypeAccountService = .None
    private var textMobile: String = ""
    private var textPrepaid: String = ""
    private var textPostpaid: String = ""
    private var textTV: String = ""
    private var textAllPackage: String = ""
    private var textInternet: String = ""
    private var textPaidBeforePre: String = ""
    private var textNoPayment: String = ""
    private var textLineaFija: String = ""
    /*********************** Variables ***********************/

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.instanceFromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.instanceFromNib()
    }
    
    private func instanceFromNib() {
        if let customView = Bundle.main.loadNibNamed("CardSummaryDetailView", owner: self, options: nil)?.first as? UIView {
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
        self.textPaidBeforePre = textConfiguration?.translations?.data?.generales?.paidBeforePre ?? ""
        self.textNoPayment = textConfiguration?.translations?.data?.generales?.noPayment ?? ""
        self.textLineaFija = textConfiguration?.translations?.data?.generales?.fixedLine ?? ""
    }
    
    func setDataSummary(summary: CardsSummaryModel) {
        self.typeAccount = summary.typeAccount
        self.lblDateVigency.text = self.textPaidBeforePre + " " + summary.dateVigency
        self.lblNameService.text = self.getNameService(typeService: summary.typeAccount)
        self.lblNameService.adjustsFontSizeToFitWidth = true
        self.lblAccount.text = summary.nameService
        var amountTmp = formatToCountryCurrency(monto: summary.amount)
        if summary.amount == 0 && self.typeAccount != .MovilPrepago {
            amountTmp = self.textNoPayment
        }
        self.lblAmount.text = amountTmp
        let nameImage = self.getNameImageService(typeService: summary.typeAccount)
        self.imgIcon.image = UIImage(named: nameImage)
    }
    
    private func getNameService(typeService: TypeAccountService) -> String{
        var nameService: String = ""
        switch typeService {
        case .MovilPospago:
            nameService = self.textMobile + " " + self.textPostpaid
            break
        case .MovilPrepago:
            nameService = self.textMobile + " " + self.textPrepaid
            break
        case .Television:
            nameService = self.textTV
            break
        case .TodoClaro:
            nameService = self.textAllPackage
            break
        case .Internet:
            nameService = self.textInternet
            break
        case .LineaFija:
            nameService = self.textLineaFija
            break
        default:
            break
        }
        
        return nameService
    }
    
    private func getNameImageService(typeService: TypeAccountService) -> String {
        var nameImage = ""
        switch typeService {
        case .MovilPospago, .MovilPrepago:
            nameImage = "ico_resumen_movil"
            break
        case .Television:
            nameImage = "ico_resumen_tv"
            break
        case .TodoClaro:
            nameImage = "ico_resumen_todoclaro"
            break
        case .Internet:
            nameImage = "ico_resumen_internet"
            break
        case .LineaFija:
            nameImage = "ico_resumen_telefono"
            break
        default:
            break
        }
        return nameImage
    }
    
    //MARK: Action Button
    @IBAction func btnShowDetail(sender: UIButton) {
        let nameService = self.lblAccount.text ?? ""
        self.delegate?.showDetailAccount(typeAccount: self.typeAccount, serviceName: nameService)
    }
}
