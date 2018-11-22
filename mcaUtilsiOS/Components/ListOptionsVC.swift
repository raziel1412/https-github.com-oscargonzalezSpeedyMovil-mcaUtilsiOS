//
//  ListOptionsVC.swift
//  MiClaro
//
//  Created by Pilar del Rosario Prospero Zeferino on 10/15/18.
//  Copyright © 2018 am. All rights reserved.
//

import UIKit

public class OptionModel: NSObject{
    var isSelectedOp: Bool?
    var detailText: String?
    
    init(isSelected: Bool, detailText: String) {
        super.init()
        self.isSelectedOp = isSelected
        self.detailText = detailText
    }
    
}

public class ListOptionsVC: UIViewController {

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
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.optionsTableView.allowsMultipleSelection = true
        self.optionsTableView.allowsMultipleSelectionDuringEditing = true
        self.optionsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.optionsTableView.delegate = self
        self.optionsTableView.dataSource = self
        self.optionsTableView.estimatedRowHeight = 44.0
        self.optionsTableView.rowHeight = UITableViewAutomaticDimension
        self.titleLbl.text = titleStr
        acceptBtn.addTarget(self, action: #selector(acceptction), for: .touchUpInside)
        cancelBtn.addTarget(self, action: #selector(cancelAction), for: .touchUpInside)
    }
    
    static func show(inViewController: UIViewController, array: [OptionModel], title: String, indexSelected: Int) {
        let popupVC = ListOptionsVC(nibName: "ListOptionsVC", bundle: nil)
        popupVC.modalPresentationStyle = .overFullScreen
        popupVC.providesPresentationContextTransitionStyle = true;
        popupVC.definesPresentationContext = true;
        popupVC.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        popupVC.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        popupVC.lastVC = inViewController
        popupVC.optionsArray = array
        popupVC.indexSelected = indexSelected
        popupVC.titleStr = title
        inViewController.present(popupVC, animated: true, completion: nil)
    }
    
    func acceptction() {
        self.dismiss(animated: true, completion: {
                self.lastVC?.indexSelected(selected: self.indexSelected)
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
extension ListOptionsVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
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
            selectBtn.setImage(UIImage(named: "ic_tick"), for: .normal)
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("did select")
        self.indexSelected = indexPath.row
        self.optionsTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }
}
