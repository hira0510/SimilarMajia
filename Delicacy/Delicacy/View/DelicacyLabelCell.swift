//
//  DelicacyLabelCell.swift
//
//  Copyright © 2020 1. All rights reserved.
//

import UIKit

protocol LabelCollectionViewCellProtocol: class {
    func clickBtn(px: Double, py: Double)
}

class DelicacyLabelCell: UICollectionViewCell {

    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var telLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var addLbl: UILabel!
    @IBOutlet weak var addBtn: UIButton!
    
    internal weak var delegate: LabelCollectionViewCellProtocol?
    private var data: Info!
    
    static var nib: UINib {
        return UINib(nibName: "DelicacyLabelCell", bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func clickAddBtn(_ sender: UIButton) {
        delegate?.clickBtn(px: data.px, py: data.py)
    }
    
    func configCell(model: Info) {
        data = model
        nameLbl.text = model.name
        telLbl.text! += model.tel
        descriptionLbl.text! += model.description

        if model.add != "" {
            let attributedString = NSMutableAttributedString(string: "地址：" + model.add, attributes: [
                    .font: UIFont(name: "PingFangTC-Regular", size: 17.0)!,
                    .foregroundColor: UIColor.blue,
                    .kern: -0.33
            ])
            attributedString.addAttributes([
                    .font: UIFont(name: "PingFangTC-Regular", size: 17.0)!,
                    .foregroundColor: UIColor(red: 1, green: 130 / 255, blue: 0, alpha: 1),
                    .kern: -0.33
            ], range: NSRange(location: 0, length: 3))
            addLbl.attributedText = attributedString
            if model.px > 0 && model.py > 0 {
                addBtn.isUserInteractionEnabled = true
            } else {
                addBtn.isUserInteractionEnabled = false
            }
        } else {
            addBtn.isUserInteractionEnabled = false
        }
    }
}
