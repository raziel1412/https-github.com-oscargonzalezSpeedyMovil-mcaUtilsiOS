//
//  cardContentSummaryDetailView.swift
//  MiClaro
//
//  Created by Jonathan Abimael Cruz Orozco on 09/07/18.
//  Copyright © 2018 am. All rights reserved.
//

import UIKit

protocol CardContentSummaryDelegate {
    func showDetailAccount(typeAccount: TypeAccountService, serviceName: String)
}

class cardContentSummaryDetailView: UIView {

    @IBOutlet weak var viewContent: UIView!
    @IBOutlet weak var viewBorder: UIView!
    @IBOutlet weak var viewContentDetailSummary: UIView!
    /*@IBOutlet weak var lblTotalAmount: UILabel!
    @IBOutlet weak var btnPay: UIButton!*/
    
    private var arraySummary: [CardsSummaryModel] = []
    
    var viewParent: UIView!
    var delegate: CardContentSummaryDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.instanceFromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.instanceFromNib()
    }
    
    private func instanceFromNib() {
        if let customView = Bundle.main.loadNibNamed("cardContentSummaryDetailView", owner: self, options: nil)?.first as? UIView {
            viewParent = customView
            viewParent.frame = self.bounds
            viewParent.autoresizingMask = [.flexibleHeight, .flexibleWidth]
            addSubview(viewParent)
            self.layoutIfNeeded()
            
            let sides = SideView(Left: true, Right: true, Top: true, Bottom: false)
            self.viewBorder.addBorder(sides: sides, color: institutionalColors.claroBorderBalanceView, thickness: 0.5)
            self.viewBorder.addBottomGrecas()
        }
    }
    
    func setSummaryData(arraySummary: [CardsSummaryModel]) {
        self.arraySummary = arraySummary
        self.addViewDetailSummary()
    }
    
    /*CAMBIO EN LA FUNCIONALIDAD POR ESA RAZON SE COMENTO EL MÉTODO*/
    /*private func setTotalAmount() {
        let totalAmount = self.getTotalAmount()
        self.lblTotalAmount.text = formatToCountryCurrency(monto: totalAmount)
    }*/
    
    ///Realizar suma total
    /*NOTA:  No se debe sumar las cuentas prepago si existen cuentas de post pago*/
    /*private func getTotalAmount() -> Float{
        var hasPrepago = false
        var hasPospago = false
        var sumarPrepago = false
        
        for summary in self.arraySummary {
            if summary.typeAccount == .MovilPrepago {
                hasPrepago = true
            }
            if summary.typeAccount == .MovilPospago {
                hasPospago = true
            }
        }
        
        if hasPrepago && !hasPospago {
            sumarPrepago = true
        }
        
        //Realizar la suma
        var totalAmount: Float = 0.0
        for summary in self.arraySummary {
            let amountTmp = summary.amount
            if summary.typeAccount != .MovilPrepago || sumarPrepago {
                totalAmount += amountTmp
            }
        }
        
        return totalAmount
    }*/
    
    func addViewDetailSummary() {
        var posYsummary: CGFloat = 0.0
        for summary in arraySummary {
            let frameSummary = CGRect(x: 0, y: posYsummary, width: self.viewContentDetailSummary.bounds.width, height: 130)
            let summaryItem = CardSummaryDetailView(frame: frameSummary)
            summaryItem.setDataSummary(summary: summary)
            summaryItem.delegate = self
            self.viewContentDetailSummary.addSubview(summaryItem)
            
            posYsummary += summaryItem.frame.height
        }
    }
    
    func getHeightView() -> CGFloat {
        return self.frame.height
    }
}

extension cardContentSummaryDetailView: CardSummaryDetailDelegate {
    func showDetailAccount(typeAccount: TypeAccountService, serviceName: String) {
        self.delegate?.showDetailAccount(typeAccount: typeAccount, serviceName: serviceName)
    }
}
