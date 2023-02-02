//
//  introduceViewController.swift
//  ToEatSnack
//
//  Copyright © 2020 1. All rights reserved.
//

import UIKit
import Kingfisher

class introduceViewController: UIViewController {

    @IBOutlet weak var mImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var introduceLabel: UILabel!
    @IBOutlet weak var telLabel: UILabel!
    @IBOutlet weak var addressButton: UIButton!
    @IBOutlet weak var webUrlButton: UIButton!

    var snackModel: SnackModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    @IBAction func backBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func clickAddressBtn(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Snack", bundle: nil).instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
        vc.py = Double(snackModel.latitude) ?? 0
        vc.px = Double(snackModel.longitude) ?? 0
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func clickWebBtn(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Snack", bundle: nil).instantiateViewController(withIdentifier: "ToWebViewController") as! ToWebViewController
        vc.urls = snackModel.webUrl
        present(vc, animated: true, completion: nil)
    }
    
    private func setupUI() {
        nameLabel.text = snackModel.name
        introduceLabel.text = "介紹：\(snackModel.introduce)"
        telLabel.text = "電話：\(snackModel.tel)"
        addressButton.setAttributedTitle(setTitle(title: "地址：\(snackModel.address)"), for: .normal)
        webUrlButton.setAttributedTitle(setTitle(title: "網址：\(snackModel.webUrl)"), for: .normal)
        if snackModel.webUrl == "" {
            webUrlButton.isUserInteractionEnabled = false
        }
        if snackModel.latitude == "" {
            addressButton.isUserInteractionEnabled = false
        }
        if let url = URL(string: snackModel.picURL) {
            DispatchQueue.main.async {
                UIImageView().kf.setImage(with: url, placeholder: UIImage(named: "bg"), options: nil, progressBlock: nil) { (result) in
                    switch result {
                    case .success(let success):
                        self.mImage.image = success.image
                    case .failure(_): break
                    }
                }
            }
        }
    }

    func setTitle(title: String) -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(string: title, attributes: [
                .font: UIFont(name: "PingFangTC-Regular", size: 18.0)!,
                .foregroundColor: UIColor(red: 0, green: 100 / 255, blue: 1, alpha: 1),
                .kern: -0.41
        ])
        attributedString.addAttributes([
                .font: UIFont(name: "PingFangTC-Regular", size: 18.0)!,
                .foregroundColor: UIColor(red: 0, green: 93 / 255, blue: 93 / 255, alpha: 1),
                .kern: -0.33
        ], range: NSRange(location: 0, length: 3))
        return attributedString
    }
}
