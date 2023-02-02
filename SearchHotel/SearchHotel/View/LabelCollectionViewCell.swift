//
//  LabelCollectionViewCell.swift
//  SearchHotel
//
//  Copyright © 2020 1. All rights reserved.
//

import UIKit

protocol AddressProtocol: class {
    func clickAddBtn(px: Double, py: Double)
}

class LabelCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var telLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var moneyLbl: UILabel!
    @IBOutlet weak var serviceInfoLbl: UILabel!
    @IBOutlet weak var parkingSpaceLbl: UILabel!
    @IBOutlet weak var addLbl: UILabel!
    @IBOutlet weak var addBtn: UIButton!
    
    internal weak var delegate: AddressProtocol?
    private var data: Info!
    
    static var nib: UINib {
        return UINib(nibName: "LabelCollectionViewCell", bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func clickAddBtn(_ sender: UIButton) {
        delegate?.clickAddBtn(px: data.px, py: data.py)
    }
    
    func configCell(model: Info) {
        data = model
        nameLbl.text! = model.name
        telLbl.text! += model.tel
        descriptionLbl.text! += model.description
        moneyLbl.text! += model.money
        serviceInfoLbl.text! += model.serviceInfo
        parkingSpaceLbl.text! += model.parkinginfo

        if model.add != "" {
            addLbl.attributedText = attributedString(add: model.add)
            if model.px > 0 && model.py > 0 {
                addBtn.isUserInteractionEnabled = true
            } else {
                addBtn.isUserInteractionEnabled = false
            }
        } else {
            addBtn.isUserInteractionEnabled = false
        }
    }

    private func attributedString(add: String) -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(string: "地址：\(add)", attributes: [
                .font: UIFont(name: "PingFangTC-Regular", size: 17.0)!,
                .foregroundColor: UIColor.blue,
                .kern: -0.33
        ])
        attributedString.addAttributes([
                .font: UIFont(name: "PingFangTC-Regular", size: 17.0)!,
                .foregroundColor: UIColor(red: 91 / 255, green: 58 / 255, blue: 165 / 255, alpha: 1),
                .kern: -0.33
        ], range: NSRange(location: 0, length: 3))
        return attributedString
    }
}
