//
//  HomeServiceDetailView.swift
//  MiClaro
//
//  Created by Jonathan Abimael Cruz Orozco on 10/07/18.
//  Copyright © 2018 am. All rights reserved.
//

import UIKit

protocol HomeServiceDetailViewDelegate {
    func showDetailAccount(typeAccount: TypeAccountService)
}
class HomeServiceDetailView: UIView {

    @IBOutlet weak var viewContent: UIView!
    @IBOutlet weak var imgService: UIImageView!
    @IBOutlet weak var lblNameService: UILabel!
    @IBOutlet weak var lblAmount: UILabel!
    @IBOutlet weak var btnShowDetail: UIButton!
    
    /*********************** Constantes ***********************/
    let textConfiguration = SessionSingleton.sharedInstance.getGeneralConfig()
    /*********************** Constantes ***********************/
    var viewParent: UIView!
    private var typeAccount: TypeAccountService = .None
    var delegate: HomeServiceDetailViewDelegate?
    /*********************** Textos de la interfaz ***********************/
    private var textNoPayment: String = ""
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
        if let customView = Bundle.main.loadNibNamed("HomeServiceDetailView", owner: self, options: nil)?.first as? UIView {
            viewParent = customView
            viewParent.frame = self.bounds
            viewParent.autoresizingMask = [.flexibleHeight, .flexibleWidth]
            addSubview(viewParent)
            self.layoutIfNeeded()
            self.setTextUI()
        }
    }
    
    private func setTextUI() {
        self.textNoPayment = self.textConfiguration?.translations?.data?.generales?.noPayment ?? ""
    }
    
    func setDataServices(dataService: HomeServiceDetailModel) {
        self.lblNameService.text = dataService.nameService
        self.lblAmount.adjustsFontSizeToFitWidth = true
        self.typeAccount = dataService.typeAccount
        if dataService.amount == 0 || dataService.typeAccount == .MovilPrepago {
            self.lblAmount.text = self.textNoPayment
        }else {
            self.lblAmount.text = formatToCountryCurrency(monto: dataService.amount)
        }
        let nameImage = self.getNameImageService(typeService: dataService.typeAccount)
        self.imgService.image = UIImage(named: nameImage)
    }
    
    private func getNameImageService(typeService: TypeAccountService) -> String {
        var nameImage: String = ""
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
    @IBAction func btnShowDetailAction(sender: UIButton) {
        self.delegate?.showDetailAccount(typeAccount: self.typeAccount)
    }
}

class HomeServiceDetailModel {
    var accountID: String = ""
    var typeAccount: TypeAccountService = .None
    var nameService: String = ""
    var amount: Float = 0.0
    
    func setAccountID(accountID: String) {
        self.accountID = accountID
    }
    
    func setTypeAccount(typeAccount: TypeAccountService) {
        self.typeAccount = typeAccount
    }
    
    func setNameService(nameService: String) {
        self.nameService = nameService
    }
    
    func setAmount(amount: Float) {
        self.amount = amount
    }
    
}
