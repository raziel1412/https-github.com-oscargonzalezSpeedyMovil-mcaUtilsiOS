//
//  ListOptionsVC.swift
//  MiClaro
//
//  Created by Pilar del Rosario Prospero Zeferino on 10/15/18.
//  Copyright © 2018 am. All rights reserved.
//

import UIKit

public class OptionModel: NSObject{
    public var isSelectedOp: Bool?
    public var detailText: String?
    
    public init(isSelected: Bool, detailText: String) {
        super.init()
        self.isSelectedOp = isSelected
        self.detailText = detailText
    }
    
}

public class ListOptionsVC: UIViewController, UITableViewDelegate, UITableViewDataSource  {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imageBackground: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var optionsTableView: UITableView!
    @IBOutlet weak var acceptBtn: DesignableButton!
    @IBOutlet weak var cancelBtn: DesignableButton!
    var optionsArray = [OptionModel]()
    var indexSelected = 0
    var cancelSelector: Selector?
//    var acceptSelector: ((_ indexSelected:Int) -> Void)?
    var lastVC: UIViewController?
    var titleStr: String = ""
    var indexSelectedAction: (_ indexSelected: Int) -> Void = {_ in}
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.optionsTableView.allowsMultipleSelection = true
        self.optionsTableView.allowsMultipleSelectionDuringEditing = true
        self.optionsTableView.dataSource = self
        self.optionsTableView.delegate = self
        self.optionsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.optionsTableView.dataSource = self
        self.optionsTableView.delegate = self
        self.optionsTableView.estimatedRowHeight = 44.0
        self.optionsTableView.rowHeight = UITableViewAutomaticDimension
        self.titleLbl.text = titleStr
        acceptBtn.addTarget(self, action: #selector(acceptction), for: .touchUpInside)
        cancelBtn.addTarget(self, action: #selector(cancelAction), for: .touchUpInside)
//        if #available(iOS 11.0, *) {
//            imageBackground.insetsLayoutMarginsFromSafeArea = false
//        }
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        let heightComponents: CGFloat = CGFloat(self.optionsArray.count * 44) + 121.0
//        if heightComponents < containerView.frame.height {
//            let originY = (self.view.frame.height - heightComponents) / 2
//            containerView.frame = CGRect(x: containerView.frame.origin.x, y: originY, width: containerView.frame.width, height: heightComponents)
//        }
    }
    
    public static func show(inViewController: UIViewController, array: [OptionModel], title: String, indexSelected: Int, indexSelectedAction: @escaping (_ indexSelected: Int) -> Void) {
        let bundle = Bundle(for: ListOptionsVC.self)
        let popupVC = ListOptionsVC(nibName: "ListOptionsVC", bundle: bundle)
        popupVC.modalPresentationStyle = .overFullScreen
        popupVC.providesPresentationContextTransitionStyle = true;
        popupVC.definesPresentationContext = true;
        popupVC.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        popupVC.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        popupVC.lastVC = inViewController
        popupVC.optionsArray = array
        popupVC.indexSelected = indexSelected
        popupVC.titleStr = title
        popupVC.indexSelectedAction = indexSelectedAction
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        let vc = UIViewController()
        vc.view.backgroundColor = .clear
        window.rootViewController = vc
        window.windowLevel = UIWindowLevelAlert + 1
        window.makeKeyAndVisible()
        vc.present(popupVC, animated: true, completion: nil)
        //inViewController.present(popupVC, animated: true, completion: nil)
        
    }
    
    func acceptction() {
        self.dismiss(animated: true, completion: {
            self.indexSelectedAction(self.indexSelected)
        })
    }
    
    func cancelAction() {
        self.dismiss(animated: true, completion: {
            if self.cancelSelector != nil {
                self.lastVC?.perform(self.cancelSelector)
            }
        })
    }

}

//MARK: UITableViewDelegate, UITableViewDataSource
extension ListOptionsVC{
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.optionsArray.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let aOption = optionsArray[indexPath.row]
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.lineBreakMode = .byWordWrapping
        cell.textLabel?.sizeToFit()
        cell.textLabel?.text = aOption.detailText
        cell.textLabel?.font = UIFont(name: RobotoFontName.RobotoRegular.rawValue, size: 14.0)
        if indexSelected == indexPath.row {
            let selectBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 16, height: 16))
            selectBtn.cornerRadius = 8
            selectBtn.backgroundColor = institutionalColors.claroBlueColor
            selectBtn.setImage(mcaUtilsHelper.getImage(image: "ic_tick"), for: .normal)
            selectBtn.imageEdgeInsets = UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3)
            cell.accessoryView = selectBtn
        } else {
            let selectBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 16, height: 16))
            selectBtn.cornerRadius = 8
            selectBtn.backgroundColor = institutionalColors.claroWhiteColor
            selectBtn.borderColor = institutionalColors.claroBlueColor
            selectBtn.borderWidth = 1.0
            selectBtn.imageEdgeInsets = UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3)
            cell.accessoryView = selectBtn
        }
        cell.accessoryView?.isUserInteractionEnabled = false
        print("load cell")
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("did select")
        self.indexSelected = indexPath.row
        self.optionsTableView.reloadData()
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }
}
