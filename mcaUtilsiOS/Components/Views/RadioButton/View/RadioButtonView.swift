//
//  RadioButtonView.swift
//  MiClaro
//
//  Created by Jonathan Abimael Cruz Orozco on 18/08/17.
//  Copyright © 2017 am. All rights reserved.
//

import UIKit
import Cartography

public struct RadioButtonOption {
    public var bugCode: String = ""
    public var description:String = ""
    public var check: Bool = false
    
    public init(bugCode: String, description: String, check: Bool) {
         self.bugCode = bugCode
         self.description = description
         self.check = check
    }
}

 public protocol RadioButtonViewDelegate {
     func radioButtonSingleOptionSelected(option: RadioButtonOption)
}

public class RadioButtonView: UIView {
    
    /********************************* Variables *********************************/
    public var titleCard:String = ""
    public var arrayOptions:[RadioButtonOption] = []
    public var arrayOptionsSelected:[RadioButtonOption] = []
    public var multipleSelection:Bool = false
    public var ubicationCheck:ubicationRadioButton!
    public var delegate: RadioButtonViewDelegate? = nil
    
    /********************************* Visual elements *********************************/
    public var lblTitle: BlackTitleLabel!
    public var tblOptions: UITableView!
    
    /// Constructor para la creación del componente RadioButton
    /// - Parameter titleCard: Titulo a mostrar en la vista de radioButton
    /// - Parameter arrayOptions: Listado de opciones a mostrar en la vista de RadioButton *bugcode*, *description* y *check*
    /// - Parameter size: Tamaño de la vista radioButton
    public init(titleCard: String, arrayOptions: [RadioButtonOption], size: CGSize) {
        super.init(frame: CGRect(origin: CGPoint(x: 0.0, y: 0.0), size: size))
        
        self.titleCard = titleCard
        self.arrayOptions = arrayOptions
        
        /********************************* Create visual elements *********************************/
        lblTitle = BlackTitleLabel()
        lblTitle.font = UIFont(name: RobotoFontName.RobotoBold.rawValue, size: 14.0)
        lblTitle.text = self.titleCard
        lblTitle.backgroundColor = UIColor.white
        lblTitle.textAlignment = .left
        
        tblOptions = UITableView()
        tblOptions.delegate = self
        tblOptions.dataSource = self
        tblOptions.backgroundColor = UIColor.white
        tblOptions.separatorStyle = .none
        tblOptions.sectionFooterHeight = 0
        tblOptions.allowsSelection = true
        tblOptions.register(RadioButtonViewCell.self, forCellReuseIdentifier: "cell")
        tblOptions.rowHeight = UITableViewAutomaticDimension
        tblOptions.isScrollEnabled = false
        tblOptions.isUserInteractionEnabled = true
        }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Public functions
    /// Establecer la posición de cada componente visual dentro del **View**
    public func setPosition() {
        
        self.addSubview(lblTitle)
        
        constrain(self, lblTitle) { (view1, view2) in
            view2.top == view1.top + 10
            view2.width == view1.width
            view2.centerX == view1.centerX
            view2.leading == view1.leading + 10
        }
        
        self.addSubview(tblOptions)
        constrain(self, lblTitle, tblOptions) { (view, view1, view2) in
            view2.top == view1.bottom + 10
            view2.width == view.width
            view2.centerX == view.centerX
            view2.bottom == view.bottom - 10
        }
    }
    
}
