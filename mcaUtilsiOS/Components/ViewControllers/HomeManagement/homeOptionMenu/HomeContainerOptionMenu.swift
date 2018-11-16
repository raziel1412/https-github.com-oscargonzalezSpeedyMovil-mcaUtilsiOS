//
//  HomeContainerOptionMenu.swift
//  MiClaro
//
//  Created by Jonathan Abimael Cruz Orozco on 11/07/18.
//  Copyright © 2018 am. All rights reserved.
//

import UIKit

protocol HomeContainerOptionMenuDelegate {
    func showSectionOptionView(nameSection: String)
}

class HomeContainerOptionMenu: UIView {

    @IBOutlet weak var viewContent: UIView!
    
    /*********************** Constantes ***********************/
    let textConfiguration = SessionSingleton.sharedInstance.getGeneralConfig()
    /*********************** Constantes ***********************/
    /*********************** Variables ***********************/
    var viewParent: UIView!
    var delegate: HomeContainerOptionMenuDelegate?
    /*********************** Variables ***********************/
    /*********************** Textos de la interfaz ***********************/
    private var textMyProfile: String = ""
    private var textProfileDescription: String = ""
    private var textMyServices: String = ""
    private var textServicesDescription: String = ""

    private var textMyServicesCAC: String = ""
    private var textServicesDescriptionCAC: String = ""
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
        if let customView = Bundle.main.loadNibNamed("HomeContainerOptionMenu", owner: self, options: nil)?.first as? UIView {
            viewParent = customView
            viewParent.frame = self.bounds
            viewParent.autoresizingMask = [.flexibleHeight, .flexibleWidth]
            addSubview(viewParent)
            self.layoutIfNeeded()
            
            self.setTextUI()
        }
    }

    private func setTextUI() {
        self.textMyProfile = self.textConfiguration?.translations?.data?.profile?.title ?? ""
        self.textProfileDescription = self.textConfiguration?.translations?.data?.home?.profileDescription ?? ""
        self.textMyServices = self.textConfiguration?.translations?.data?.generales?.myService ?? ""
        self.textServicesDescription = self.textConfiguration?.translations?.data?.home?.servicesDescription ?? ""
        
        self.textMyServicesCAC = self.textConfiguration?.translations?.data?.home?.cacDateTitle ?? ""
        self.textServicesDescriptionCAC = self.textConfiguration?.translations?.data?.home?.cacDateDescription ?? ""
    }
    //Funcion que agrega en un array las opciones inferiores de la vista de INICIO y setea sus etiquetas
    func addOptionsMenu() {
        let perfilOption = HomeSelectOptionModel()
        perfilOption.setTitle(title: self.textMyProfile)
        perfilOption.setSubtitle(subtitle: self.textProfileDescription)
        perfilOption.setNameImage(nameImage: "ico_home_miperfil")
        
        let servicesOption = HomeSelectOptionModel()
        servicesOption.setTitle(title: self.textMyServices)
        servicesOption.setSubtitle(subtitle: self.textServicesDescription)
        servicesOption.setNameImage(nameImage: "ico_home_miscuentas")
        
        let agendarCACOption = HomeSelectOptionModel()
        agendarCACOption.setTitle(title: self.textMyServicesCAC)
        agendarCACOption.setSubtitle(subtitle: self.textServicesDescriptionCAC)
        agendarCACOption.setNameImage(nameImage: "icon_soporte_centros")
        
        let arrayOptions: [HomeSelectOptionModel] = [perfilOption, servicesOption, agendarCACOption]
        
        var posY: CGFloat = 0.0
        for option in arrayOptions {
            let frameOption = CGRect(x: 0, y: posY, width: self.viewContent.bounds.width, height: 100)
            let selectOptionView = HomeSelectOptionView(frame: frameOption)
            self.viewContent.addSubview(selectOptionView)
            selectOptionView.setDataOption(dataOption: option)
            selectOptionView.delegate = self
            
            posY += 100
        }
    }
}

extension HomeContainerOptionMenu: HomeSelectOptionViewDelegate {
    func showHomeOptionSelect(nameSection: String) {
        self.delegate?.showSectionOptionView(nameSection: nameSection)
    }
}
