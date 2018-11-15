//
//  PopupDescriptionPlanViewController.swift
//  MiClaro
//
//  Created by Jonathan Abimael Cruz Orozco on 27/07/18.
//  Copyright © 2018 am. All rights reserved.
//

import UIKit

class PopupDescriptionPlanViewController: UIViewController {

    @IBOutlet weak var btnAccept: UIButton!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    
    /*********************** Constantes ***********************/
    let textConfiguration = SessionSingleton.sharedInstance.getGeneralConfig()
    /*********************** Constantes ***********************/
    
    private var titleText: String = ""
    private var descriptionText: String = ""
    private var titleButton: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        self.view.isOpaque = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.lblTitle.text = self.titleText
        self.lblDescription.text = self.descriptionText
        self.btnAccept.setTitle(self.titleButton, for: .normal)
        
        let tapView = UITapGestureRecognizer(target: self, action: #selector(hideView))
        self.view.addGestureRecognizer(tapView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setInformation(title: String, description: String) {
        self.titleText = title
        self.descriptionText = description
        self.titleButton = self.textConfiguration?.translations?.data?.generales?.acceptBtn ?? ""
    }
    
    @objc func hideView() {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func btnAcceptAction(sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
