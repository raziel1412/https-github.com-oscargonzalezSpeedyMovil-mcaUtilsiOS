//
//  HomeContainerServiceView.swift
//  MiClaro
//
//  Created by Jonathan Abimael Cruz Orozco on 10/07/18.
//  Copyright © 2018 am. All rights reserved.
//

import UIKit

protocol HomeContainerServiceViewDelegate {
    func payBoleta(webID: String)
    func showDetailAccount(typeAccount: TypeAccountService)
}

class HomeContainerServiceView: UIView {
    @IBOutlet weak var viewContent: UIView!
    @IBOutlet weak var viewBorder: UIView!
    @IBOutlet weak var viewContentServiceDetail: UIView!
    @IBOutlet weak var lblAmountTitle: UILabel!
    @IBOutlet weak var lblTotalAmont: UILabel!
    @IBOutlet weak var btnPayBoleta: UIButton!
    @IBOutlet weak var imgIconCheck: UIImageView!
    @IBOutlet weak var lblHomeDescription: UILabel!

    /*********************** Constantes ***********************/
    let textConfiguration = SessionSingleton.sharedInstance.getGeneralConfig()
    /*********************** Constantes ***********************/
    var viewParent: UIView!
    var delegate: HomeContainerServiceViewDelegate?
    private var webIdAction: String = "billingPayment"
    /*********************** Textos de la interfaz ***********************/
    private var textNoPayment: String = ""
    private var textTotalToPay: String = ""
    private var textBalance: String = ""
    private var textPayBoleta: String = ""
    private var textReload: String = ""
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
        if let customView = Bundle.main.loadNibNamed("HomeContainerServiceView", owner: self, options: nil)?.first as? UIView {
            viewParent = customView
            viewParent.frame = self.bounds
            viewParent.autoresizingMask = [.flexibleHeight, .flexibleWidth]
            addSubview(viewParent)
            self.layoutIfNeeded()
            
            let sides = SideView(Left: true, Right: true, Top: true, Bottom: false)
            self.viewBorder.addBorder(sides: sides, color: institutionalColors.claroBorderBalanceView, thickness: 0.5)
            self.viewBorder.addBottomGrecas()
            
            self.setTextUI()
        }
    }
    
    private func setTextUI() {
        self.textNoPayment = self.textConfiguration?.translations?.data?.generales?.noPayment ?? ""
        self.textTotalToPay = self.textConfiguration?.translations?.data?.generales?.totalToPay ?? ""
        self.textBalance = self.textConfiguration?.translations?.data?.mobile?.balance ?? ""
        self.textPayBoleta = self.textConfiguration?.translations?.data?.generales?.payBill ?? ""
        self.textReload = self.textConfiguration?.translations?.data?.mobile?.topUpBtn ?? ""
        self.lblHomeDescription.text = self.textConfiguration?.translations?.data?.home?.homeDescription ?? "";
    }
    
    func setDataHomeServiceDetail(arrayHomeServices: [HomeServiceDetailModel]) {
        var totalAmount: Float = 0.0
        var posY: CGFloat = 0.0
        var isOnlyAccountPrepaid: Bool = true
        
//        case MovilPrepago
//        case MovilPospago
//        case Television
//        case TodoClaro
//        case Internet
//        case LineaFija
        
        var paint1movilPre: Bool = false
        var paint1movilPos: Bool = false
        var paint1Televition: Bool = false
        var paint1TodoClaro: Bool = false
        var paint1Internet: Bool = false
        var paint1LineaFija: Bool = false
        
        //Para identificar si existen solo cuentas de prepago
        for service in arrayHomeServices {
            if service.typeAccount != .MovilPrepago {
                isOnlyAccountPrepaid = false
            }
        }
        
        for service in arrayHomeServices {
            
            let frameView = CGRect(x: 0, y: posY, width: self.viewContentServiceDetail.bounds.width, height: 80)
            let serviceDetailView = HomeServiceDetailView(frame: frameView)
            serviceDetailView.setDataServices(dataService: service)
            serviceDetailView.delegate = self
            
            if isOnlyAccountPrepaid { //Es true si no trae otras cuentas distintas a una .MovilPrepago
                self.viewContentServiceDetail.addSubview(serviceDetailView)
                posY += 80
                totalAmount += service.amount
                serviceDetailView.lblAmount.text = formatToCountryCurrency(monto: totalAmount)
            }else {//trae otras cuentas ademas de prepago
                    switch service.typeAccount{
                    case .MovilPrepago:
                        if paint1movilPre == false{
                            self.viewContentServiceDetail.addSubview(serviceDetailView)
                            posY += 80
                            paint1movilPre = true
                            paint1movilPos = true
                        }
                    case .MovilPospago:
                        if paint1movilPos == false{
                            self.viewContentServiceDetail.addSubview(serviceDetailView)
                            posY += 80
                            paint1movilPos = true
                            paint1movilPre = true
                        }
                    case .Television :
                        if paint1Televition == false{
                            self.viewContentServiceDetail.addSubview(serviceDetailView)
                            posY += 80
                            paint1Televition = true
                        }
                    case .TodoClaro:
                        if paint1TodoClaro == false{
                            self.viewContentServiceDetail.addSubview(serviceDetailView)
                             posY += 80
                            paint1TodoClaro = true
                        }
                    case .Internet:
                        if paint1Internet == false{
                            self.viewContentServiceDetail.addSubview(serviceDetailView)
                            posY += 80
                            paint1Internet = true
                        }
                    case .LineaFija:
                        if paint1LineaFija == false{
                            self.viewContentServiceDetail.addSubview(serviceDetailView)
                            posY += 80
                            paint1LineaFija = true
                        }
                    case .None: break
                    case .Resumen: break
                    case .Suscripcion: break
                    }
                if service.typeAccount != .MovilPrepago {
                    totalAmount += service.amount
                }
            }
        }
        
        if totalAmount == 0 {
            self.disableUI(isOnlyPrepaidAccount: isOnlyAccountPrepaid)
        }else {
            self.enableUI(totalAmount: totalAmount, isOnlyPrepaidAccount: isOnlyAccountPrepaid)
        }
        
    }
    
    private func disableUI(isOnlyPrepaidAccount: Bool = false) {
        self.btnPayBoleta.isUserInteractionEnabled = false
        self.btnPayBoleta.backgroundColor = institutionalColors.claroLightGrayColor
        self.btnPayBoleta.setTitleColor(institutionalColors.claroSelectionGrayColor, for: .normal)
        self.btnPayBoleta.setTitle(self.textPayBoleta, for: .normal)
        self.imgIconCheck.isHidden = false
        self.lblTotalAmont.text = self.textNoPayment
        self.lblAmountTitle.text = self.textTotalToPay
        
        if isOnlyPrepaidAccount {
            self.btnPayBoleta.setTitle(self.textReload, for: .normal)
            self.lblAmountTitle.text = self.textBalance
            self.webIdAction = "reload"
        }
    }
    
    private func enableUI(totalAmount: Float, isOnlyPrepaidAccount: Bool = false) {
        self.btnPayBoleta.isUserInteractionEnabled = true
        self.btnPayBoleta.backgroundColor = institutionalColors.claroRedColor
        self.btnPayBoleta.setTitleColor(institutionalColors.claroWhiteColor, for: .normal)
        self.btnPayBoleta.setTitle(self.textPayBoleta, for: .normal)
        self.imgIconCheck.isHidden = true
        self.lblTotalAmont.text = formatToCountryCurrency(monto: totalAmount)
        self.lblAmountTitle.text = self.textTotalToPay

        if isOnlyPrepaidAccount {
            self.btnPayBoleta.setTitle(self.textReload, for: .normal)
            self.lblAmountTitle.text = self.textBalance
            self.webIdAction = "reload"
        }
    }
    
    @IBAction func btnPayBoleta(sender: UIButton) {
        self.delegate?.payBoleta(webID: self.webIdAction)
    }

}

extension HomeContainerServiceView: HomeServiceDetailViewDelegate {
    func showDetailAccount(typeAccount: TypeAccountService) {
        self.delegate?.showDetailAccount(typeAccount: typeAccount)
    }
}
