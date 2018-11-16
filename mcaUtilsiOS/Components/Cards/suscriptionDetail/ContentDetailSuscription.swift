//
//  ContentDetailSuscription.swift
//  MiClaro
//
//  Created by Jonathan Abimael Cruz Orozco on 14/09/18.
//  Copyright © 2018 am. All rights reserved.
//

import UIKit

protocol ContentDetailSuscriptionDelegate {
    func eraseSubscrip(detailSubscrip: CardSuscriptionModel)
}

class ContentDetailSuscription: UIView, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tbContentDetail: UITableView!
    @IBOutlet weak var btnBefore: UIButton!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var lblCurrentPage: UILabel!
    
    private var arrayDataSuscription: [CardSuscriptionModel] = []
    public var arrayTmpSuscription: [CardSuscriptionModel] = []
    
    private var currentItems: Int = 0
    private var currentPage: Int = 1
    private var totalPages: Int = 0
    private let itemsForPage: Int = 5
    
    private var isHistorycTable = false
    
    var delegate: ContentDetailSuscriptionDelegate?
    
    let textConfiguration = SessionSingleton.sharedInstance.getGeneralConfig()
    
    var viewParent: UIView!
    
    init(frame: CGRect , arrayDataSuscription: [CardSuscriptionModel], isHistorycTable: Bool) {
        super.init(frame: frame)
  
        self.isHistorycTable = isHistorycTable
    
        self.arrayDataSuscription = arrayDataSuscription
        self.instanceFromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.instanceFromNib()
    }
    
    private func instanceFromNib() {
        if let customView = Bundle.main.loadNibNamed("ContentDetailSuscription", owner: self, options: nil)?.first as? UIView {
            viewParent = customView
            viewParent.frame = self.bounds
            viewParent.autoresizingMask = [.flexibleHeight, .flexibleWidth]
            addSubview(viewParent)
            self.setTotalOfPages()
            self.showInfoTableView()
        }
    }
    
    private func showInfoTableView() {
        tbContentDetail.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tbContentDetail.rowHeight = UITableViewAutomaticDimension
        tbContentDetail.separatorStyle = .none
        tbContentDetail.delegate = self
        tbContentDetail.dataSource = self
        
        if self.currentPage == 1 {
            self.btnBefore.isHidden = true
        }
        
    }
    
    //Se calcula el numero de paguinas de las suscripciones
    func setTotalOfPages() {
        
        if self.arrayDataSuscription.count > self.itemsForPage {
            if (self.arrayDataSuscription.count % self.itemsForPage) == 0 {
                self.totalPages = self.arrayDataSuscription.count / self.itemsForPage
            }else {
                self.totalPages = self.arrayDataSuscription.count / self.itemsForPage
                self.totalPages += 1
            }
        }else {
            self.totalPages = 1
        }
        
        self.updateArrayTmpSuscription()
        self.updateTextPage()
    }
    
    func updateTextPage() {
        //Realizar el reload table para mostrar la nueva información
        if totalPages == 1{
            self.btnBefore.isHidden = true
            self.btnNext.isHidden = true
            self.lblCurrentPage.text = ""
        }else{
            self.lblCurrentPage.text = "\(self.currentPage) de \(self.totalPages)"
            self.btnBefore.isHidden = false
            self.btnNext.isHidden = false
            if self.currentPage == 1{
                self.btnBefore.isHidden = true
            }
            if self.currentPage == totalPages{
                self.btnNext.isHidden = true
            }
        }
        
    }
    
    private func updateArrayTmpSuscription() {
        self.arrayTmpSuscription.removeAll()
        
        //Para saber apartir de que index comenzar
        var startIndex = (self.currentPage - 1) * self.itemsForPage
        var elements = 0
        
        for indexSus in 0..<self.arrayDataSuscription.count {
            if elements < 5 && startIndex <= indexSus {
                self.arrayTmpSuscription.append(self.arrayDataSuscription[startIndex])
                elements += 1
                startIndex += 1
            }
        }
        
        self.tbContentDetail.reloadData()
    }
    
    //MARK: Button Action
    @IBAction func btnBeforeAction(sender: UIButton) {
        self.updateCountPage(pressNext: false)
    }
    
    @IBAction func btnNextAction(sender: UIButton) {
        self.updateCountPage(pressNext: true)
    }
    
    /// Función para actualizar el contador de páginas y las celdas a mostrar
    private func updateCountPage(pressNext: Bool) {
        if self.totalPages == 1 {
            self.btnBefore.isHidden = true
            self.btnNext.isHidden = true
        }
        if pressNext { // se presiono el botón de siguiente
            self.currentPage += 1
            if self.currentPage == self.totalPages { // Es la primer página
                self.btnBefore.isHidden = false
                self.btnNext.isHidden = true
            }
        }else { // se presiono el botón de anterior
            self.currentPage -= 1
            if self.currentPage == 1 { // es la última página
                self.btnNext.isHidden = false
                self.btnBefore.isHidden = true
            }
        }
        
        self.updateArrayTmpSuscription()
        self.updateTextPage()
    }
    
    /// Saber cuantos elementos se deben mostrar
    func setDataSuscriptions(suscription: [CardSuscriptionModel], isHistorycTable: Bool) {
        
        self.isHistorycTable = isHistorycTable
        self.currentPage = 1
        self.arrayDataSuscription.removeAll()
        self.arrayDataSuscription = suscription
        self.setTotalOfPages()
        self.showInfoTableView()
        self.tbContentDetail.reloadData()
    }
    
    //MARK: Table View
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayTmpSuscription.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell")!

        let viewSN = DetailSuscriptionView(frame: CGRect(x: 0, y: 0, width: self.frame.width-20, height: 140))
        viewSN.delegate = self
        let detail = arrayTmpSuscription[indexPath.row]
        viewSN.lblTitle.text = detail.serviceName
        viewSN.lblStatusText.text = textConfiguration?.translations?.data?.subscriptions?.subscriptionsState ?? ""
        var textButton = ""
        if detail.status == 0{
            viewSN.btnCustom.isHidden = true
            viewSN.lblStatusDesc.text = textConfiguration?.translations?.data?.subscriptions?.subscriptionsInactive ?? ""
            viewSN.lblStatusDesc.textColor = institutionalColors.claroLightGrayColor
        }else{
            if isHistorycTable == true{
                  textButton = textConfiguration?.translations?.data?.subscriptions?.subscriptionsLock ?? ""
            }else{
                  textButton = textConfiguration?.translations?.data?.subscriptions?.subscriptionsDelete ?? ""
            }
            viewSN.btnCustom.isHidden = false
            viewSN.btnCustom.tag = indexPath.row
            viewSN.btnCustom.setTitle(textButton, for: .normal)
            viewSN.lblStatusDesc.text = textConfiguration?.translations?.data?.subscriptions?.subscriptionsActive ?? ""
            viewSN.lblStatusDesc.textColor = #colorLiteral(red: 0.2696761787, green: 0.7004202008, blue: 0.415515244, alpha: 1)
        }
        
        let numCorto = textConfiguration?.translations?.data?.subscriptions?.subscriptionsShortNumber ?? ""
        viewSN.lblNumberShort.text = "\(numCorto) \(detail.shortNumber)"
        
        let fecha = textConfiguration?.translations?.data?.subscriptions?.subscriptionsDate ?? ""
        if detail.subscriptionDate == "" {
            viewSN.lblDate.text = "\(fecha) No Disponible"
        }else{
            viewSN.lblDate.text = "\(fecha) \(detail.subscriptionDate)"
        }
    
        let sides = SideView(Left: true, Right: true, Top: true, Bottom: true)
        viewSN.viewBorder.addBorder(sides: sides, color: institutionalColors.claroBorderBalanceView, thickness: 1.5)
        cell.contentView.addSubview(viewSN)
        return cell
    }
}
//MARK: CardContentDetailDelegate
extension ContentDetailSuscription: DetailSuscriptionDelegate {
    func eraseSubscrip(index: Int) {
        let detailSubscrip = arrayTmpSuscription[index]
        self.delegate?.eraseSubscrip(detailSubscrip: detailSubscrip)
    }
}
