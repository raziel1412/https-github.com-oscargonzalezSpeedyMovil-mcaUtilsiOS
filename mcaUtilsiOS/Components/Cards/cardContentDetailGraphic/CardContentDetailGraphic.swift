//
//  CardContentDetailGraphic.swift
//  MiClaro
//
//  Created by Jonathan Abimael Cruz Orozco on 28/06/18.
//  Copyright © 2018 am. All rights reserved.
//

import UIKit

protocol CardContentDetailDelegate {
    func consumingOptionSelected()
    func detailPlanSelected()
    func saldoDataSelected()
    func showDescriptionPlan(messageDescriptionPlan: String)
}

class CardContentDetailGraphic: UIView {

    @IBOutlet weak var viewContent: UIView!
    @IBOutlet weak var btnConsuming: UIButton!
    @IBOutlet weak var btnSaldo: UIButton!
    @IBOutlet weak var btnPlanDetail: UIButton!
    @IBOutlet weak var viewContentGraphic: UIView!
    @IBOutlet weak var layoutHeightViewContent: NSLayoutConstraint!
    
    var viewParent: UIView!
    var arrayDataGraphic: [DataGraphicCard] = []
    var arrayDetailPlan: [(String, String)] = []
    private var saldosData: SaldoPromoMaster?
    
    private var typeAccount: TypeAccountService = .None
    private var viewDetailPlan: CardDetailDataTable!
    private var facturationData: CycleInformation?
    private var viewDetailPlanText: CardDetailDataText?
    private var viewDetailSaldo: CardDetailDataSaldo?
    private var viewSinBolsa: CardsSinBolsa?
    private var descriptionPlan: String = ""
    var delegate: CardContentDetailDelegate?
    
    init(frame: CGRect, typeAccount: TypeAccountService) {
        super.init(frame: frame)
        self.typeAccount = typeAccount
        self.instanceFromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.instanceFromNib()
    }
    
    private func instanceFromNib() {
        if let customView = Bundle.main.loadNibNamed("CardContentDetailGraphic", owner: self, options: nil)?.first as? UIView {
            viewParent = customView
            viewParent.frame = self.bounds
            viewParent.autoresizingMask = [.flexibleHeight, .flexibleWidth]
            addSubview(viewParent)
        }
    }
    
    func updateTypeAccount(typeAccount: TypeAccountService) {
        self.typeAccount = typeAccount
    }
    
    /// Identificar que tipo de vista mostrar
    func updateInterface(typeView: TypeDetailPlan) {
        switch typeView {
        case .Graphic:
            self.addDetailGraphicView()
            break
        case .Table:
            self.addPlanDetailView()
            break
        case .Text:
            self.addDescriptionPlanText()
            break
        case .SinBolsa:
            self.addDescriptionSinBolsa()
            break
        default:
            break
        }
        self.activeBtnConsuming()
    }
    
    /// Ocultar los botones de seleccion
    func hiddeButtonSelection() {
        self.btnConsuming.isHidden = true
        self.btnSaldo.isHidden = true
        self.btnPlanDetail.isHidden = true
    }
    
    //Mostrar la seccion de saldo
    func showSaldoSection(showSaldo: Bool) {
        self.btnSaldo.isHidden = !showSaldo
    }
    
    /// Saber cuantos elementos se deben mostrar
    func setDataGraphics(dataGraohic: [DataGraphicCard], facturationData: CycleInformation? = nil) {
        self.arrayDataGraphic.removeAll()
        self.arrayDataGraphic = dataGraohic
        self.facturationData = facturationData
        //Agregar los servicios de la cuenta
//        self.addDetailGraphicView()
    }
    
    private func addDetailGraphicView() {
        self.removeDetailGraphicView()
        
        var posY: CGFloat = 0.0
        if(self.arrayDataGraphic.count == 0 && typeAccount == .MovilPrepago){
            let frameCardSinbolsa = CGRect(x: 0, y: posY, width: self.bounds.width, height: 110)
            let viewSinBolsa = CardsSinBolsa(frame: frameCardSinbolsa)
            self.viewContentGraphic.addSubview(viewSinBolsa)
            posY += 110
        }else{
            for data in self.arrayDataGraphic {
                //si aqui el data el feature remainding viene 0 mostrar sin bolsa
                if data.featureReminderQuantity == 0.0 {
                    let frameCardSinbolsa = CGRect(x: 0, y: posY, width: self.bounds.width, height: 110)
                    let viewSinBolsa = CardsSinBolsa(frame: frameCardSinbolsa)
                    //Aqui poner el texto de la bolsa
                    viewSinBolsa.setDataInfo(data: data)
                    self.viewContentGraphic.addSubview(viewSinBolsa)
                    posY += 110
                }else{
                    let frameCardGraphic = CGRect(x: 0, y: posY, width: self.bounds.width, height: 140)
                    let viewGraphic = CardDetailDataGraphic(frame: frameCardGraphic)
                    viewGraphic.delegate = self
                    viewGraphic.setDataGraphic(data: data)
                    self.viewContentGraphic.addSubview(viewGraphic)
                    posY += viewGraphic.getHeightView()
                }
            }
            
            if self.facturationData != nil {
                let frameFacturation = CGRect(x: 0, y: posY, width: self.bounds.width, height: 110)
                let facturationView = CardFacturationView(frame: frameFacturation)
                self.viewContentGraphic.addSubview(facturationView)
                facturationView.setDataInfo(data: self.facturationData!)
                posY += 110
            }
        }
        // actualizar la altura del view
        self.layoutHeightViewContent.constant = posY
        self.updateDimensions()
    }
    
    func setDataPlanDetail(detailPlan: PlanDetailCard) {
        self.arrayDetailPlan.removeAll()
        self.arrayDetailPlan = detailPlan.arrayServiceDescription
        self.descriptionPlan = detailPlan.planDescription
    }
    
    private func addPlanDetailView() {
        //Altura que ocupa una celda
        var posY: CGFloat = 50.0
        for _ in  0..<self.arrayDetailPlan.count {
            posY += 50.0
        }
        // actualizar la altura del view
        self.layoutHeightViewContent.constant = posY
        self.updateDimensions()
        
        self.removeDetailGraphicView()
        let frameCardTable = CGRect(x: 0, y: 0, width: self.bounds.width, height: self.layoutHeightViewContent.constant)
        self.viewDetailPlan = CardDetailDataTable(frame: frameCardTable)
        self.viewContentGraphic.addSubview(self.viewDetailPlan)
        self.viewDetailPlan.setDataInformation(detailPlan: self.arrayDetailPlan)
    }
    
    private func addDescriptionPlanText() {
        self.removeDetailGraphicView()
        let font = UIFont(name: RobotoFontName.RobotoRegular.rawValue, size: CGFloat(16.0))
        let height = self.descriptionPlan.heightWithConstrainedWidth(width: self.bounds.width, font: font!)
        
        self.layoutHeightViewContent.constant = height + 90.0
        self.updateDimensions()
        
        let frameDescPlan = CGRect(x: 0, y: 0, width: self.bounds.width, height: height + 80)
        self.viewDetailPlanText = CardDetailDataText(frame: frameDescPlan)
        self.viewDetailPlanText?.backgroundColor = UIColor.yellow
        self.viewContentGraphic.addSubview(self.viewDetailPlanText!)
        self.viewContentGraphic.backgroundColor = UIColor.blue
        self.viewDetailPlanText?.setTextDescription(description: self.descriptionPlan)
    }
    
    private func addDescriptionSinBolsa() {
        self.removeDetailGraphicView()
        
        let frameDescPlan = CGRect(x: 0, y: 0, width: self.bounds.width, height: 110)
        self.viewSinBolsa = CardsSinBolsa(frame: frameDescPlan)
        self.viewSinBolsa?.backgroundColor = UIColor.yellow
        self.viewContentGraphic.addSubview(self.viewSinBolsa!)
        self.viewContentGraphic.backgroundColor = UIColor.blue
//        self.viewSinBolsa?.setTextDescription(description: self.descriptionPlan)
        
        self.layoutHeightViewContent.constant = (self.viewSinBolsa?.getHeightView())!
        self.updateDimensions()
    }
    
    private func addDescriptionSaldo() {
        self.removeDetailGraphicView()
        let frameDescSaldo = CGRect(x: 0, y: 0, width: self.bounds.width, height: 140)
        self.viewDetailSaldo = CardDetailDataSaldo(frame: frameDescSaldo)
        self.viewContentGraphic.addSubview(self.viewDetailSaldo!)
        if self.saldosData != nil {
            self.viewDetailSaldo?.setDataSaldo(data: self.saldosData!)
        }
        // actualizar la altura del view
        self.layoutHeightViewContent.constant = (self.viewDetailSaldo?.getHeightView())!
        self.updateDimensions()
    }
    
    func setDataSaldos(data: SaldoPromoMaster) {
        self.saldosData = data
    }
    
    private func removeDetailGraphicView() {
        for view in self.viewContentGraphic.subviews {
            view.removeFromSuperview()
        }
    }
    
    /// Funcion para obtener la altura de la view contenedor
    func getHeightContentDetailGraphic() -> CGFloat {
        self.updateDimensions()
        return self.layoutHeightViewContent.constant
    }
    
    /// Funcion para actualizar el tamaño del view
    private func updateDimensions() {
        let newFrame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: self.bounds.width, height: self.layoutHeightViewContent.constant + 55.0)
        self.frame = newFrame
    }
    
    private func activeBtnConsuming() {
        self.btnConsuming.backgroundColor = institutionalColors.claroWhiteColor
        self.btnConsuming.setTitleColor(institutionalColors.claroBlueColor, for: .normal)
        self.btnPlanDetail.backgroundColor = institutionalColors.claroButtonDetailGraphicSelect
        self.btnPlanDetail.setTitleColor(institutionalColors.claroTextColor, for: .normal)
        self.btnSaldo.backgroundColor = institutionalColors.claroButtonDetailGraphicSelect
        self.btnSaldo.setTitleColor(institutionalColors.claroTextColor, for: .normal)
    }
    //MARK: Button actions
    @IBAction func btnConsumingAction(sender: UIButton) {
        self.activeBtnConsuming()
        self.addDetailGraphicView()
        self.delegate?.consumingOptionSelected()
    }
    
    @IBAction func btnPlanDetailAction(sender: UIButton) {
        
        self.btnConsuming.backgroundColor = institutionalColors.claroButtonDetailGraphicSelect
        self.btnConsuming.setTitleColor(institutionalColors.claroTextColor, for: .normal)
        self.btnPlanDetail.backgroundColor = institutionalColors.claroWhiteColor
        self.btnPlanDetail.setTitleColor(institutionalColors.claroBlueColor, for: .normal)
        self.btnSaldo.backgroundColor = institutionalColors.claroButtonDetailGraphicSelect
        self.btnSaldo.setTitleColor(institutionalColors.claroTextColor, for: .normal)
        if self.typeAccount == .MovilPospago {
            self.addDescriptionPlanText()
        }else {
            self.addPlanDetailView()
        }
        self.delegate?.detailPlanSelected()
    }
    
    @IBAction func btnSaldoAction(sender: UIButton) {
        self.delegate?.detailPlanSelected()
        self.btnConsuming.backgroundColor = institutionalColors.claroButtonDetailGraphicSelect
        self.btnConsuming.setTitleColor(institutionalColors.claroTextColor, for: .normal)
        self.btnPlanDetail.backgroundColor = institutionalColors.claroButtonDetailGraphicSelect
        self.btnPlanDetail.setTitleColor(institutionalColors.claroTextColor, for: .normal)
        self.btnSaldo.backgroundColor = institutionalColors.claroWhiteColor
        self.btnSaldo.setTitleColor(institutionalColors.claroBlueColor, for: .normal)
        self.addDescriptionSaldo()
        
        self.delegate?.saldoDataSelected()
    }
}

extension CardContentDetailGraphic: CardDetailDataGraphicDelegate {
    func showDescriptionPlan(messageDescriptionPlan: String) {
        self.delegate?.showDescriptionPlan(messageDescriptionPlan: messageDescriptionPlan)
    }
}
