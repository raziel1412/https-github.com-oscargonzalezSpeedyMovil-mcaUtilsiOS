//
//  HomeHeaderView.swift
//  MiClaro
//
//  Created by Jonathan Abimael Cruz Orozco on 10/07/18.
//  Copyright © 2018 am. All rights reserved.
//

import UIKit

class HomeHeaderView: UIView {

    @IBOutlet weak var viewContent: UIView!
    @IBOutlet weak var lblNameUser: UILabel!
    @IBOutlet weak var iconAvatar: UIImageView!
    
    var viewParent: UIView!
    
    /*********************** Constantes ***********************/
    let textConfiguration = SessionSingleton.sharedInstance.getGeneralConfig()
    /*********************** Constantes ***********************/
    /*********************** Textos de la interfaz ***********************/
    private var textCommonHeader: String = ""
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
        if let customView = Bundle.main.loadNibNamed("HomeHeaderView", owner: self, options: nil)?.first as? UIView {
            viewParent = customView
            viewParent.frame = self.bounds
            viewParent.autoresizingMask = [.flexibleHeight, .flexibleWidth]
            addSubview(viewParent)
            self.setTextUI()
        }
    }
    
    private func setTextUI() {
        self.textCommonHeader = self.textConfiguration?.translations?.data?.generales?.commonHeader ?? ""
    }
    
    func setNameUser() {
        let infoUser = SessionSingleton.sharedInstance.getCurrentSession()
        let nameUser = infoUser?.retrieveProfileInformationResponse?.personalDetailsInformation?.accountUserFirstName ?? ""
        self.lblNameUser.text = NSString(format: "¡%@ %@!", self.textCommonHeader, nameUser) as String
        
        let nameImage = SessionSingleton.sharedInstance.getNameImagePerfil()
        
        if SessionSingleton.sharedInstance.checkImageExists(fileName: nameImage){
            let path = URL.urlInDocumentsDirectory(with: nameImage).path
            let image = UIImage(contentsOfFile: path)
            
            if(image != nil){
//                iconAvatar.image = SessionSingleton.sharedInstance.resizeImage(image: image!, targetSize: CGSize(width: iconAvatar.frame.size.width, height: iconAvatar.frame.size.height));
                iconAvatar.image = SessionSingleton.sharedInstance.resizeImage(image: image!, targetSize: CGSize(width: 120.0*2, height: 120.0*2));

                iconAvatar.contentMode = .scaleAspectFill
                iconAvatar.layer.cornerRadius = iconAvatar.frame.size.width/2
                iconAvatar.clipsToBounds = true
                
            }
        }
        
    }

}
