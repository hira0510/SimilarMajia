//
//  LabelCollectionViewCell.swift
//  CountrysideStay
//
//  Copyright © 2020 1. All rights reserved.
//

import UIKit

protocol AddressProtocol: class {
    func clickAddBtn(latitude: String, longitude: String)
}

class LabelCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var telLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var urlLbl: UILabel!
    @IBOutlet weak var addLbl: UILabel!
    @IBOutlet weak var addBtn: UIButton!

    internal weak var delegate: AddressProtocol?
    private var data: CountrysideStayModel!

    static var nib: UINib {
        return UINib(nibName: "LabelCollectionViewCell", bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    @IBAction func clickAddBtn(_ sender: UIButton) {
        delegate?.clickAddBtn(latitude: data.Latitude, longitude: data.Longitude)
    }

    func configCell(model: CountrysideStayModel) {
        data = model
        nameLbl.text! += model.Name
        telLbl.text! += model.Tel
        descriptionLbl.text! += model.HostWords

        if model.Address != "" {
            addLbl.attributedText = attributedString(text: "地址", add: model.Address)
            if model.Longitude != "" {
                addBtn.isUserInteractionEnabled = true
            } else {
                addBtn.isUserInteractionEnabled = false
            }
        } else {
            addBtn.isUserInteractionEnabled = false
        }
        
        if model.Url != "" {
            urlLbl.attributedText = attributedString(text: "網址", add: model.Url)
        }
        
        let MyTouch = UITapGestureRecognizer()
        MyTouch.addTarget(self, action: #selector(myView_Touch))
        urlLbl.addGestureRecognizer(MyTouch)
    }

    private func attributedString(text: String, add: String) -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(string: "\(text)：\(add)", attributes: [
                .font: UIFont(name: "PingFangTC-Regular", size: 17.0)!,
                .foregroundColor: UIColor.blue,
                .kern: -0.33
        ])
        attributedString.addAttributes([
                .font: UIFont(name: "PingFangTC-Regular", size: 17.0)!,
                .foregroundColor: UIColor(red: 117 / 255, green: 255 / 255, blue: 130 / 255, alpha: 1),
                .kern: -0.33
        ], range: NSRange(location: 0, length: 3))
        return attributedString
    }

    @objc func myView_Touch() {
        guard let url = URL(string: data.Url) else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}
