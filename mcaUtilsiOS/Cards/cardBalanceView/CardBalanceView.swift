//
//  CardBalanceView.swift
//  MiClaro
//
//  Created by Jonathan Abimael Cruz Orozco on 02/07/18.
//  Copyright © 2018 am. All rights reserved.
//

import UIKit

protocol CardBalanceViewDelegate {
    func btnBalanceAction(webId: String)
}

class CardBalanceView: UIView {

    /*********************** Componentes de la interfaz ***********************/
    @IBOutlet weak var viewContent: UIView!
    @IBOutlet weak var viewBorder: UIView!
    @IBOutlet weak var lblBalanceTitle: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblBalanceDescription: UILabel!
    @IBOutlet weak var btnBalance: UIButton!
    @IBOutlet weak var imgCheck: UIImageView!
    /*********************** Componentes de la interfaz ***********************/
    /*********************** Variables ***********************/
    var viewParent: UIView!
    private var typeAccount: TypeAccountService = .None
    var delegate: CardBalanceViewDelegate?
    /*********************** Variables ***********************/
    /*********************** Constantes ***********************/
    private let heightContentView: CGFloat = 240
    private let heightContentViewWithoutBoletas: CGFloat = 120
    private let heightViewBorder: CGFloat = 230
    private let heightViewBorderWithoutBoletas: CGFloat = 112
    private let heightViewContentBoletas: CGFloat = 118
    private let heightViewContentBoletasEmpty: CGFloat = 0
    let textConfiguration = SessionSingleton.sharedInstance.getGeneralConfig()
    /*********************** Constantes ***********************/
    /*********************** Textos de la interfaz ***********************/
    private var textBalance: String = ""
    private var texttopUpBtn: String = ""
    private var textPayBill: String = ""
    private var textTotalToPay: String = ""
    private var textNoPayment: String = ""
    private var textExpiration: String = ""
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
        if let customView = Bundle.main.loadNibNamed("CardBalanceView", owner: self, options: nil)?.first as? UIView {
            viewParent = customView
            viewParent.frame = self.bounds
            viewParent.autoresizingMask = [.flexibleHeight, .flexibleWidth]
            addSubview(viewParent)
            
            /*self.viewBorder.addBottomGrecas()*/
            let sides = SideView(Left: true, Right: true, Top: true, Bottom: false)
            self.viewBorder.addBorder(sides: sides, color: institutionalColors.claroBorderBalanceView, thickness: 0.5)
            self.setTextUI()
        }
    }
    
    private func setTextUI() {
        self.textBalance = self.textConfiguration?.translations?.data?.mobile?.balance ?? ""
        self.texttopUpBtn = self.textConfiguration?.translations?.data?.mobile?.topUpBtn ?? ""
        self.textPayBill = self.textConfiguration?.translations?.data?.generales?.payBill ?? ""
        self.textTotalToPay = self.textConfiguration?.translations?.data?.generales?.totalToPay ?? ""
        self.textNoPayment = self.textConfiguration?.translations?.data?.generales?.noPayment ?? ""
        self.textExpiration = self.textConfiguration?.translations?.data?.billing?.expiration ?? ""
    }
    
    func setDataBalance(balance: Float, dateVigency: String, typeAccount: TypeAccountService) {
        self.typeAccount = typeAccount
        self.showInformation(balance: balance, dateVigency: dateVigency, typeAccount: typeAccount)
    }
    
    private func showInformation(balance: Float, dateVigency: String, typeAccount: TypeAccountService) {
        var titleButton: String = self.texttopUpBtn
        var titleBalance: String = self.textBalance
        var monto = formatToCountryCurrency(monto: balance)
        self.activeUI()
        
        switch typeAccount {
        case .MovilPospago:
            titleButton = self.textPayBill
            titleBalance = self.textTotalToPay
            if balance == 0 {
                self.imgCheck.isHidden = false
                monto = self.textNoPayment
                self.disableUI()
            }else {
                self.imgCheck.isHidden = true
                monto = formatToCountryCurrency(monto: balance)
            }
            break
        case .MovilPrepago:
            if balance == 0 {
                self.lblDate.isHidden = true
            }
            break
        case .Television:
            titleButton = self.textPayBill
            titleBalance = self.textTotalToPay
            if balance == 0 {
                self.imgCheck.isHidden = false
                monto = self.textNoPayment
                self.disableUI()
            }else {
                self.imgCheck.isHidden = true
                monto = formatToCountryCurrency(monto: balance)
            }
            break
        case .Internet:
            titleButton = self.textPayBill
            titleBalance = self.textTotalToPay
            if balance == 0 {
                self.imgCheck.isHidden = false
                monto = self.textNoPayment
                self.disableUI()
            }else {
                self.imgCheck.isHidden = true
                monto = formatToCountryCurrency(monto: balance)
            }
            break
        case .TodoClaro:
            titleButton = self.textPayBill
            titleBalance = self.textTotalToPay
            if balance == 0 {
                self.imgCheck.isHidden = false
                monto = self.textNoPayment
                self.disableUI()
            }else {
                self.imgCheck.isHidden = true
                monto = formatToCountryCurrency(monto: balance)
            }
            break
        case .LineaFija:
            titleButton = self.textPayBill
            titleBalance = self.textTotalToPay
            if balance == 0 {
                self.imgCheck.isHidden = false
                monto = self.textNoPayment
                self.disableUI()
            }else {
                self.imgCheck.isHidden = true
                monto = formatToCountryCurrency(monto: balance)
            }
            break
        default:
            break
        }
        
        self.lblBalanceTitle.text = titleBalance
        self.btnBalance.setTitle(titleButton, for: .normal)
        self.lblBalanceDescription.text = monto
        self.btnBalance.setTitle(titleButton, for: .normal)
        self.lblDate.text = self.textExpiration + " " + dateVigency
        
    }
    
    private func disableUI() {
        self.lblDate.isHidden = true
        self.btnBalance.backgroundColor = institutionalColors.claroLightGrayColor
        self.btnBalance.setTitleColor(institutionalColors.claroSelectionGrayColor, for: .normal)
        self.btnBalance.isUserInteractionEnabled = false
    }
    
    private func activeUI() {
        self.lblDate.isHidden = false
        self.btnBalance.backgroundColor = institutionalColors.claroRedColor
        self.btnBalance.setTitleColor(institutionalColors.claroWhiteColor, for: .normal)
        self.btnBalance.isUserInteractionEnabled = true
        self.imgCheck.isHidden = true
    }
    
    func deleteBottomGrecas() {
        for viewTmp in self.viewBorder.subviews {
            if viewTmp.tag == 2018 {
                viewTmp.removeFromSuperview()
            }
        }
    }
    
    //MARK: Action Button
    @IBAction func btnBalanceAction(sender: UIButton) {
        if false == SessionSingleton.sharedInstance.isNetworkConnected() {
            NotificationCenter.default.post(name: Observers.ObserverList.ShowOfflineMessage.name, object: nil);
            return;
        }
        var webId = ""
        switch self.typeAccount {
        case .MovilPospago:
            webId = "billingPayment"
            break
        case .MovilPrepago:
            webId = "reload"
            break
        case .Television:
            webId = "billingPayment"
            break
        case .LineaFija:
            webId = "billingPayment"
            break
        case .Internet:
            webId = "billingPayment"
            break
        case .TodoClaro:
            webId = "billingPayment"
            break
        default:
            webId = "billingPayment"
            break
        }
        
        self.delegate?.btnBalanceAction(webId: webId)
    }
}
