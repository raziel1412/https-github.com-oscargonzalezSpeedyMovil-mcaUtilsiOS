//
//  NewUpdateAlertViewController.swift
//  MiClaro
//
//  Created by Pilar del Rosario Prospero Zeferino on 8/8/18.
//  Copyright © 2018 am. All rights reserved.
//

import UIKit
import mcaManageriOS

public class NewUpdateAlertViewController: UIViewController {
    
    @IBOutlet weak var headerImg: UIImageView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var subtitleLbl: UILabel!
    @IBOutlet weak var separatorImg: UIImageView!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var updateBtn: UIButton!
    @IBOutlet weak var skipBtn: UIButton!
    var heightTitle: CGFloat?
    var heightSubt: CGFloat?
    var heightDesc: CGFloat?
    var conf: GeneralConfig?
    var alertData : AlertInfo?
    var urlString: String?

    override public func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3);
        initComponents()
        // Do any additional setup after loading the view.
    }
    
    override public func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        titleLbl.sizeToFit()
        subtitleLbl.sizeToFit()
        descriptionLbl.sizeToFit()
        updateFrames()
    }

    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initComponents() {
        conf = mcaManagerSession.getGeneralConfig()
        updateBtn.addTarget(self, action: #selector(self.updateAction), for: .touchUpInside)
        skipBtn.addTarget(self, action: #selector(self.skipAction), for: .touchUpInside)
        updateBtn.borderColor = institutionalColors.claroBlueColor
        updateBtn.backgroundColor = institutionalColors.claroRedColor
        skipBtn.setTitleColor(institutionalColors.claroBlueColor, for: .normal)
        updateBtn.setTitleColor(institutionalColors.claroNavTitleColor, for: .normal)
        headerImg.image = UIImage.init(named: "ic_avatar")
        
        if let forceUpdate = conf?.newUpdateAvailable?.forcedUpdate{
            mcaManagerSession.setCanUpdateApp(canUpdateApp: forceUpdate)
            if forceUpdate {
                titleLbl.text = conf?.translations?.data?.newUpdateAvailableTexts?.updateForcedTitle ?? "Actualice la aplicación"
                subtitleLbl.text = conf?.translations?.data?.newUpdateAvailableTexts?.updateForcedDescription ?? "Actualice su aplicación a la nueva versión"
                descriptionLbl.text = conf?.translations?.data?.newUpdateAvailableTexts?.updateForcedDescription2 ?? "Nueva actualización disponible para mejorar su experienca"
                skipBtn.isHidden = true
                
            } else {
                titleLbl.text = conf?.translations?.data?.newUpdateAvailableTexts?.updateOptionalTitle ?? "Actualizace la aplicación"
                subtitleLbl.text = conf?.translations?.data?.newUpdateAvailableTexts?.updateOptionalDescription ?? "Actualice su aplicación a la nueva versión"
                descriptionLbl.text = conf?.translations?.data?.newUpdateAvailableTexts?.updateOptionalDescription2 ?? "Nueva actualización disponible para mejorar su experienca"
                skipBtn.isHidden = false
            }
            
        } else {
            mcaManagerSession.setCanUpdateApp(canUpdateApp: false)
            skipBtn.isHidden = false
        }
        
        AnalyticsInteractionSingleton.sharedInstance.ADBTrackView(viewName: "Alerta", detenido: false, mensaje: self.descriptionLbl.text)
        
        //Set values from file config
        urlString = conf?.newUpdateAvailable?.itunesURL ?? "https://itunes.apple.com/cl/app/mi-claro/id1319458144?mt=8"
        updateBtn.setTitle(conf?.translations?.data?.newUpdateAvailableTexts?.newUpdateAvailableNow ?? "Actualizar ahora", for: .normal)
        
        
        let stringValue = descriptionLbl.text
        let attrString = NSMutableAttributedString(string: stringValue!)
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 5
        style.minimumLineHeight = 5
        let attrs: [String: Any] = [NSFontAttributeName: UIFont(name: RobotoFontName.RobotoRegular.rawValue, size: 15)!, NSParagraphStyleAttributeName:style]
        attrString.addAttribute(NSParagraphStyleAttributeName, value: style, range: NSRange(location: 0, length: stringValue!.count))
        
        attrString.addAttributes(attrs, range: NSRange(location: 0, length: stringValue!.count))
        descriptionLbl.attributedText = attrString
        
        titleLbl.sizeToFit()
        subtitleLbl.sizeToFit()
        descriptionLbl.sizeToFit()
        heightTitle = titleLbl.frame.height
        heightSubt = subtitleLbl.frame.height
        heightDesc = descriptionLbl.frame.height
    }
    
    func updateFrames() {
        
        let margin: CGFloat = 18
        let marginText: CGFloat = 30
        let space: CGFloat = 20
        let shortSpace: CGFloat = 10
        let minSpace: CGFloat = 5
        let longspace: CGFloat = 25
        var valueY: CGFloat = 30
        
        subtitleLbl.textAlignment = .center
        titleLbl.textAlignment = .center
        descriptionLbl.textAlignment = .center
        let widthContainer = self.view.frame.width - (margin * 2)
        
        headerImg.frame = CGRect(x: (widthContainer-100)/2, y: valueY, width: 100, height: 100)
        valueY = headerImg.frame.maxY + shortSpace
        
        titleLbl.frame = CGRect(x: marginText, y: valueY, width: widthContainer-(marginText*2), height: heightTitle!)
        valueY = titleLbl.frame.maxY + minSpace
        
        subtitleLbl.frame = CGRect(x: marginText, y: valueY, width: widthContainer-(marginText*2), height: heightSubt!)
        valueY = subtitleLbl.frame.maxY + shortSpace
        
        separatorImg.frame = CGRect(x: (widthContainer-80)/2, y: valueY, width: 80, height: 2)
        valueY = separatorImg.frame.maxY + shortSpace
        
        descriptionLbl.frame = CGRect(x: marginText, y: valueY, width: widthContainer-(marginText*2), height: descriptionLbl.frame.height)
        valueY = descriptionLbl.frame.maxY + longspace
        
        updateBtn.frame = CGRect(x: margin, y: valueY, width: widthContainer-(margin*2), height: 40)
        valueY = updateBtn.frame.maxY + space
        
        if !skipBtn.isHidden {
            skipBtn.frame = CGRect(x: margin, y: valueY, width: widthContainer-(margin*2), height: 40)
            valueY = skipBtn.frame.maxY + space
        }
        
        containerView.frame = CGRect(x: margin, y: (self.view.frame.height-valueY)/2, width: widthContainer, height: valueY)
        
    }
    
    func updateAction() {
        let url = URL(string: urlString!)
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url!) {(result) in
                print("opened")
                self.dismiss(animated: true,
                             completion: nil)
            }
        }
    }
    func skipAction() {
        self.dismiss(animated: true,
                     completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
