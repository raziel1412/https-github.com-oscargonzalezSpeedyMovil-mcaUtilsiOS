//
//  HomePromoImageView.swift
//  MiClaro
//
//  Created by Jonathan Abimael Cruz Orozco on 11/07/18.
//  Copyright © 2018 am. All rights reserved.
//

import UIKit

protocol HomePromoImageViewDelegate {
    func showPromotionWeb(url: String)
}

class HomePromoImageView: UIView {

    @IBOutlet weak var viewContent: UIView!
    @IBOutlet weak var imgPromotion: UIImageView!
    
    var viewParent: UIView!
    private var urlPromotion: String = ""
    var delegate: HomePromoImageViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.instanceFromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.instanceFromNib()
    }
    
    private func instanceFromNib() {
        if let customView = Bundle.main.loadNibNamed("HomePromoImageView", owner: self, options: nil)?.first as? UIView {
            viewParent = customView
            viewParent.frame = self.bounds
            viewParent.autoresizingMask = [.flexibleHeight, .flexibleWidth]
            addSubview(viewParent)
            self.layoutIfNeeded()
        }
    }
    
    func setDataInfo(dataPromo: Promos) {
        self.imgPromotion.isUserInteractionEnabled = true
        let tapImage = UITapGestureRecognizer(target: self, action: #selector(showPromoLink))
        self.imgPromotion.addGestureRecognizer(tapImage)
        self.urlPromotion = dataPromo.linkUrl
        self.downloadImage(urlImage: dataPromo.imgUrl)
    }
    
    @objc private func showPromoLink() {
        self.delegate?.showPromotionWeb(url: self.urlPromotion)
    }
    
    private func downloadImage(urlImage: String) {
        let remoteImageURL = URL(string: urlImage)!
        print("Download Started")
        getDataFromUrl(url: remoteImageURL) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? remoteImageURL.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() {
                self.imgPromotion.image = UIImage(data: data)
                print("Size Image \(String(describing: self.imgPromotion.image?.size))")
            }
        }
    }

    private func getDataFromUrl(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            completion(data, response, error)
            }.resume()
    }
}
