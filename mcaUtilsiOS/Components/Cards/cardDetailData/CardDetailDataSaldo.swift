//
//  CardDetailDataSaldo.swift
//  MiClaro
//
//  Created by Jonathan Abimael Cruz Orozco on 04/09/18.
//  Copyright © 2018 am. All rights reserved.
//

import UIKit

class CardDetailDataSaldo: UIView {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var lblTitleMaestro: UILabel!
    @IBOutlet weak var lblDateMaestro: UILabel!
    @IBOutlet weak var lblSaldoMaestro: UILabel!
    @IBOutlet weak var lblTitlePromocional: UILabel!
    @IBOutlet weak var lblDatePromocional: UILabel!
    @IBOutlet weak var lblSaldoPromocional: UILabel!
    
    var viewParent: UIView!
    
    /*********************** Constantes ***********************/
    private let textConfiguration = SessionSingleton.sharedInstance.getGeneralConfig()
    private var textAntesDe: String = ""
    /*********************** Constantes ***********************/
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.instanceFromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.instanceFromNib()
    }
    
    private func instanceFromNib() {
        if let customView = Bundle.main.loadNibNamed("CardDetailDataSaldo", owner: self, options: nil)?.first as? UIView {
            viewParent = customView
            viewParent.frame = self.bounds
            viewParent.autoresizingMask = [.flexibleHeight, .flexibleWidth]
            addSubview(viewParent)
            
            self.setTextUI()
        }
    }
    
    private func setTextUI() {
        self.textAntesDe = textConfiguration?.translations?.data?.generales?.paidBefore ?? ""
        lblTitlePromocional.text = "Saldo Promocional:"
        lblTitleMaestro.text = "Saldo Maestro:"
    }
    
    func setDataSaldo(data: SaldoPromoMaster) {
        if data.dateMaestro != "" && data.datePromocional != "" {
            let dateTmp = convertShortStringDateToDate(stringDate: data.dateMaestro)
            let newDate = getStringDate(date: dateTmp!)
            lblDateMaestro.text = self.textAntesDe + " " + newDate
            lblSaldoMaestro.text = formatToCountryCurrency(strMonto: data.saldoMaestro)
            
            lblDatePromocional.text = self.textAntesDe + " " + data.datePromocional
            lblSaldoPromocional.text =  formatToCountryCurrency(strMonto: data.saldoPromocional)
        }else {
            lblDateMaestro.text = "Sin información"
            lblSaldoMaestro.text = "Sin información"
            
            lblDatePromocional.text = "Sin información"
            lblSaldoPromocional.text =  "Sin información"
        }
        
    }
    
    func getHeightView() -> CGFloat {
        return self.bounds.height
    }

}
