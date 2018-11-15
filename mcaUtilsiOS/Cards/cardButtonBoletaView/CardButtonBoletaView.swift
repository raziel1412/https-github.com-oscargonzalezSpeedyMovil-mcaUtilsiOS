//
//  CardButtonBoletaView.swift
//  MiClaro
//
//  Created by Jonathan Abimael Cruz Orozco on 06/07/18.
//  Copyright © 2018 am. All rights reserved.
//

import UIKit

protocol CardButtonBoletaViewDelegate {
    func actionActiveBoleta()
    func actionSendBoleta()
    func actionDownloadBoleta()
}

class CardButtonBoletaView: UIView {

    @IBOutlet weak var viewContent: UIView!
    @IBOutlet weak var viewBorder: UIView!
    @IBOutlet weak var btnActiveBoleta: UIButton!
    @IBOutlet weak var btnSendBoleta: UIButton!
    @IBOutlet weak var btnDownloadBoleta: UIButton!
    @IBOutlet weak var lblActiveBoleta: UILabel!
    @IBOutlet weak var lblSendBoleta: UILabel!
    @IBOutlet weak var lblDownloadBoleta: UILabel!
   
    /*********************** Constantes ***********************/
    private let textConfiguration = SessionSingleton.sharedInstance.getGeneralConfig()
    /*********************** Constantes ***********************/
    /*********************** Textos de la interfaz ***********************/
    private var activeBoleta: String = ""
    private var sendBoleta: String = ""
    private var downloadBoleta: String = ""
    /*********************** Textos de la interfaz ***********************/
    
    var viewParent: UIView!
    var delegate: CardButtonBoletaViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.instanceFromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.instanceFromNib()
    }
    
    private func instanceFromNib() {
        if let customView = Bundle.main.loadNibNamed("CardButtonBoletaView", owner: self, options: nil)?.first as? UIView {
            viewParent = customView
            viewParent.frame = self.bounds
            viewParent.autoresizingMask = [.flexibleHeight, .flexibleWidth]
            addSubview(viewParent)
            
            let sides = SideView(Left: true, Right: true, Top: false, Bottom: false)
            self.viewBorder.addBorder(sides: sides, color: institutionalColors.claroBorderBalanceView, thickness: 0.5)
            
            self.setTextUI()
        }
    }
    
    private func setTextUI() {
        self.activeBoleta = self.textConfiguration?.translations?.data?.billing?.activatePaperless ?? ""
        self.sendBoleta = self.textConfiguration?.translations?.data?.billing?.sendBill ?? ""
        self.downloadBoleta = self.textConfiguration?.translations?.data?.billing?.downloadBill ?? ""
    }
    
    func setTextView() {
        self.lblActiveBoleta.isUserInteractionEnabled = true
        self.lblSendBoleta.isUserInteractionEnabled = true
        self.lblDownloadBoleta.isUserInteractionEnabled = true
        let tapGestureActive = UITapGestureRecognizer(target: self, action: #selector(showViewBoleta))
        let tapGestureSend = UITapGestureRecognizer(target: self, action: #selector(showViewBoleta))
        let tapGestureDownload = UITapGestureRecognizer(target: self, action: #selector(showViewBoleta))
        
        self.lblActiveBoleta.text = self.activeBoleta
        self.lblSendBoleta.text = self.sendBoleta
        self.lblDownloadBoleta.text = self.downloadBoleta
        
        self.lblActiveBoleta.addGestureRecognizer(tapGestureActive)
        self.lblSendBoleta.addGestureRecognizer(tapGestureSend)
        self.lblDownloadBoleta.addGestureRecognizer(tapGestureDownload)
    }
    
    @objc private func showViewBoleta() {
        self.delegate?.actionActiveBoleta()
    }
    
    //MARK: Button Action
    @IBAction func btnActiveBoletaAction(sender: UIButton) {
        self.delegate?.actionActiveBoleta()
    }
    
    @IBAction func btnSendBoletaAction(sender: UIButton) {
        self.delegate?.actionSendBoleta()
    }
    
    @IBAction func btnDownloadBoletaAction(sender: UIButton) {
        self.delegate?.actionDownloadBoleta()
    }
}
