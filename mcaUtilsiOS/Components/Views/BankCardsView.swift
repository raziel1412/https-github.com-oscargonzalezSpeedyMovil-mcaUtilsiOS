//
//  BankCardsView.swift
//  mcaTopUpRefilliOS
//
//  Created by Ricardo Rodriguez De Los Santos on 2/14/19.
//  Copyright © 2019 Speedy Movil. All rights reserved.
//

import UIKit

public class BankCardsView: UIView, UITableViewDelegate, UITableViewDataSource {
    
    var bankCardList: [String] = [String]()

    var showAddCard: () -> Void = {}
    
    /* tabla con las tarjetas almacenadas
     */
    lazy var tableViewBankCard: UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: CGFloat(self.bankCardList.count * 100)))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(BankCardViewCell.classForCoder(), forCellReuseIdentifier: "cellId")
        tableView.estimatedRowHeight = 100.0
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.backgroundColor = UIColor.clear
        tableView.separatorColor = UIColor.clear
        tableView.allowsSelection = true
        tableView.showsVerticalScrollIndicator = false
        
        return tableView
    }()
    
    lazy var imageAddBankCard: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0 , y: self.tableViewBankCard.frame.maxY + 10, width: 16, height: 16))
        imageView.image = mcaUtilsHelper.getImage(image: "mas")
        let tap = UITapGestureRecognizer(target: self, action: #selector(showAddCardAction))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tap)
        
        return imageView
    }()
    
    lazy var labelAddBankCard: UILabel = {
        let label = UILabel(frame: CGRect(x: self.imageAddBankCard.frame.maxX + 5, y: self.tableViewBankCard.frame.maxY + 10, width: 100, height: 20))
        label.text = "Agregar Tarjeta"
        label.font = UIFont(name: RobotoFontName.RobotoBold.rawValue, size: CGFloat(14.0))
        label.textColor = institutionalColors.claroBlueColor
        let tap = UITapGestureRecognizer(target: self, action: #selector(showAddCardAction))
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(tap)
        
        return label
    }()

    public init(frame: CGRect,bankCardList : [String],showAddCard : @escaping () -> Void ) {
        super.init(frame: frame)
        self.showAddCard = showAddCard
        self.bankCardList = bankCardList
        self.addSubview(tableViewBankCard)
        self.addSubview(self.imageAddBankCard)
        self.addSubview(self.labelAddBankCard)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.bankCardList.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! BankCardViewCell
        let nameImage = indexPath.row == 1 ||  indexPath.row == 3 ? "masterdcard" : "visa"
        cell.imageBankCard.image = mcaUtilsHelper.getImage(image: nameImage)
        cell.selectionStyle = .none
        cell.cardContainerView.frame = CGRect(x: 0, y: 0, width: cell.frame.width - 20, height: cell.frame.height - 10)
        cell.checkButton.frame = CGRect(x: cell.cardContainerView.frame.width - 30, y: cell.cardContainerView.frame.height/2, width: 20, height: 20)
        cell.numberCardLabel.frame = CGRect(x: cell.cardContainerView.frame.width - 210, y: 10, width: 200, height: 20)
        
        return cell
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    public func showAddCardAction(){
        self.showAddCard()
    }
}
