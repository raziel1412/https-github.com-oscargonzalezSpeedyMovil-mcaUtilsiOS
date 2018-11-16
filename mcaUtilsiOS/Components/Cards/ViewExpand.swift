//
//  ViewExpand.swift
//  MiClaro
//
//  Created by Jonathan Abimael Cruz Orozco on 27/11/17.
//  Copyright © 2017 am. All rights reserved.
//

import UIKit

protocol ViewExpandDelegate {
    func btnExpandAction(tagView: Int, expandView: Bool, indxService : Int, accountID: String)
}

struct ViewExpandData {
    var titleText: String = ""
    var descriptionText: String = ""
    var indexData: Int = 0
}

class ViewExpand: UIView {

    //Delegate
    var delegate: ViewExpandDelegate?
    
    //Variables
    var titleView: String = ""
    var arrayText: [ViewExpandData]!
    var viewExpandResume: Bool = true
    var isExpanded: Bool = false
    var accountID: String = ""
    
    //Interface value
    var lblTitle: BlackBodyLabel!
    var btnExpand: UIButton!
    
    lazy var indxService : Int = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.green
        
        interfaceView()
    }
    
    /// init
    /// Parameter frame: dimensiones del view para expandir
    /// Parameter arrayExpand: arreglo para identificar los view expandibles
    /// Parameter indxService: indice del servicio asociado
    init(frame: CGRect, arrayExpand: [ViewExpandData], indxService : Int = 0) {
        super.init(frame: frame)
        self.arrayText = arrayExpand
        self.indxService = indxService;
        self.backgroundColor = institutionalColors.claroLightGrayColorExpandView
        
        interfaceView()
    }
    
    /// init
    /// Parameter frame: dimensiones del view para expandir
    /// Parameter typeCard: Tipo de card elegida
    /// Parameter indxService: indice del servicio asociado
    init(frame: CGRect, typeCard: TypeCardView, indxService : Int = 0, titleView: String = "", idAccount: String = "") {
        super.init(frame: frame)
//        self.singleViewExpand = infoViewExpand
        self.backgroundColor = institutionalColors.claroLightGrayColorExpandView
        self.indxService = indxService
        self.interfaceSingleViewExpand(title: titleView)
        self.accountID =  idAccount != "" ? idAccount : ""
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /// inicializar los componentes visuales de view
    func interfaceView() {
        let padding: CGFloat = 10.0
        let dimensionButton: CGFloat = 30.0

        if self.arrayText.count < 1 {
            updateHeightView(newHeight: 0)

            return;
        }
        
        lblTitle = BlackBodyLabel()
        lblTitle.frame = CGRect(x: padding, y: 10.0, width: self.bounds.width / 2.0, height: 20.0)
        lblTitle.textColor = institutionalColors.claroBlueColor
        lblTitle.textAlignment = .left
        lblTitle.text = self.arrayText.first?.titleText ?? "" //Recordar que la primer posición siempre será para el titulo
        lblTitle.font = UIFont(name: RobotoFontName.RobotoRegular.rawValue, size: CGFloat(12.0))
        btnExpand = UIButton(frame: CGRect(x: self.bounds.width - (dimensionButton + padding * 1.5) - 10, y: 5.0, width: dimensionButton, height: dimensionButton))
        btnExpand.titleLabel?.font = UIFont.fontAwesome(ofSize: 14)
        btnExpand.setTitle(String.fontAwesomeIcon(name: .plus), for: UIControlState.normal)
        btnExpand.setTitle(String.fontAwesomeIcon(name: .plus), for: UIControlState.selected)
        btnExpand.setTitleColor(institutionalColors.claroBlueColor, for: UIControlState.normal)
        btnExpand.setTitleColor(institutionalColors.claroBlueColor, for: UIControlState.selected)
        btnExpand.addTarget(self, action: #selector(ViewExpand.actionExpandPush), for: .touchUpInside)
        
        self.addSubview(lblTitle)
        self.addSubview(btnExpand)
        
        var posYlastLabel: CGFloat = lblTitle.frame.maxY
        let widthLabel: CGFloat = self.bounds.width / 2 - (padding * 2.0)
        let heightLabel: CGFloat = 20.0
        
        for index in 1 ..< arrayText.count {
            if "AccountID" == arrayText[index].titleText {
                continue;
            }
            let lblTmpTitle = BlackBodyLabel()
            lblTmpTitle.frame = CGRect(x: padding, y: posYlastLabel, width: widthLabel , height: heightLabel)
            lblTmpTitle.textAlignment = .left
            if 2 == index {
                lblTmpTitle.textColor = institutionalColors.claroBlackColor
            } else {
                lblTmpTitle.textColor = institutionalColors.claroTextColor
            }
            lblTmpTitle.text = arrayText[index].titleText
            lblTmpTitle.font = UIFont(name: RobotoFontName.RobotoLight.rawValue, size: CGFloat(12.0))
            lblTmpTitle.sizeToFit()
            
            let lblTmpDesc = BlackBodyLabel()
            lblTmpDesc.frame = CGRect(x: widthLabel + padding * 2, y: posYlastLabel, width: widthLabel, height: heightLabel)
            lblTmpDesc.textAlignment = .left
            if 2 == index {
                lblTmpDesc.textColor = institutionalColors.claroBlackColor
            } else {
                lblTmpDesc.textColor = institutionalColors.claroTextColor
            }
            lblTmpDesc.text = arrayText[index].descriptionText
            lblTmpDesc.font = UIFont(name: RobotoFontName.RobotoLight.rawValue, size: CGFloat(12.0))
            lblTmpDesc.sizeToFit()
            
            self.addSubview(lblTmpTitle)
            self.addSubview(lblTmpDesc)
            
            posYlastLabel = posYlastLabel + lblTmpDesc.bounds.height + 5.0
        }
        
        updateHeightView(newHeight: posYlastLabel)
    }
    /// En caso de solo ser una única opcion expandible se inicializa con este método.
    func interfaceSingleViewExpand(title: String = "") {
        let padding: CGFloat = 10.0
        let dimensionButton: CGFloat = 30.0
        lblTitle = BlackBodyLabel()
        lblTitle.frame = CGRect(x: padding, y: 10.0, width: self.bounds.width / 2.0, height: 20.0)
        lblTitle.textColor = institutionalColors.claroBlueColor
        lblTitle.textAlignment = .left
        lblTitle.font = UIFont(name: RobotoFontName.RobotoRegular.rawValue, size: CGFloat(14.0));
        lblTitle.text = title != "" ? title : "Ver detalles de tu plan"
        
        btnExpand = UIButton(frame: CGRect(x: self.bounds.width - (dimensionButton + padding * 1.5) - 10 , y: 5.0, width: dimensionButton, height: dimensionButton))
        btnExpand.titleLabel?.font = UIFont.fontAwesome(ofSize: 14)
        btnExpand.setTitle(String.fontAwesomeIcon(name: .plus), for: UIControlState.normal)
        btnExpand.setTitle(String.fontAwesomeIcon(name: .plus), for: UIControlState.selected)
        btnExpand.setTitleColor(institutionalColors.claroBlueColor, for: UIControlState.normal)
        btnExpand.setTitleColor(institutionalColors.claroBlueColor, for: UIControlState.selected)
        btnExpand.addTarget(self, action: #selector(ViewExpand.actionExpandPush), for: .touchUpInside)
        
        self.addSubview(lblTitle)
        self.addSubview(btnExpand)
        
        let posYlastLabel: CGFloat = lblTitle.frame.maxY + 10.0
        updateHeightView(newHeight: posYlastLabel)
    }
    /// Actualizar la altura del view
    /// Parameter newHeight: nueva altura del view
    func updateHeightView(newHeight: CGFloat) {
        let heightContentView = newHeight//heightContentView + newHeight
        print("HEIGHT VIEW EXPAND \(heightContentView), POSY : \(self.frame.origin.y)")
        self.frame = CGRect(x: 10.0, y: self.frame.origin.y, width: self.frame.width - 20.0, height: heightContentView)
    }
    
    /// Funcion para cambiar el icono del botón cuando este se expande o se contrae
    func changeIconButton() {
        self.isExpanded = !self.isExpanded
        if self.isExpanded {
            btnExpand.setTitle(String.fontAwesomeIcon(name: .minus), for: UIControlState.normal)
            btnExpand.setTitle(String.fontAwesomeIcon(name: .minus), for: UIControlState.selected)
        }else {
            btnExpand.setTitle(String.fontAwesomeIcon(name: .plus), for: UIControlState.normal)
            btnExpand.setTitle(String.fontAwesomeIcon(name: .plus), for: UIControlState.selected)
        }
    }
    
    //MARK: Action Button
    /// Detectar la acción del botón para expandir u ocultar y cambiar el icono del botón *+* o *-*
    @objc func actionExpandPush() {
        self.changeIconButton()
        self.delegate?.btnExpandAction(tagView: self.tag, expandView: self.isExpanded, indxService: self.indxService, accountID: self.accountID)
    }

}
