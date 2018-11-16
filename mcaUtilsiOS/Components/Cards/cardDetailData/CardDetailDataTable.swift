//
//  CardDetailDataTable.swift
//  MiClaro
//
//  Created by Jonathan Abimael Cruz Orozco on 02/07/18.
//  Copyright © 2018 am. All rights reserved.
//

import UIKit

class CardDetailDataTable: UIView {
    /*********************** Componentes de la interfaz ***********************/
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var tbPlanDetail: UITableView!
    /*********************** Componentes de la interfaz ***********************/
    
    var viewParent: UIView!
    var arrayDetailPlan: [(String, String)] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.instanceFromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.instanceFromNib()
    }
    
    private func instanceFromNib() {
        if let customView = Bundle.main.loadNibNamed("CardDetailDataTable", owner: self, options: nil)?.first as? UIView {
            viewParent = customView
            viewParent.frame = self.bounds
            viewParent.autoresizingMask = [.flexibleHeight, .flexibleWidth]
            addSubview(viewParent)
        }
    }
    
    func setDataInformation(detailPlan: [(String, String)]) {
        self.arrayDetailPlan = detailPlan
        self.showInfoTableView()
    }
    
    private func showInfoTableView() {
        let nib = UINib(nibName: "CardDetailDataTableCell", bundle: nil)
        self.tbPlanDetail.register(nib, forCellReuseIdentifier: "detailPlanCell")
        self.tbPlanDetail.estimatedRowHeight = 50.0
        self.tbPlanDetail.rowHeight = UITableViewAutomaticDimension
        self.tbPlanDetail.delegate = self
        self.tbPlanDetail.dataSource = self
    }
}

extension CardDetailDataTable: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayDetailPlan.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailPlanCell", for: indexPath) as! CardDetailDataTableCell
        cell.lblNameService.text = self.arrayDetailPlan[indexPath.row].0 //Title
        cell.lblConsumingData.text = self.arrayDetailPlan[indexPath.row].1 //Description
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
}
