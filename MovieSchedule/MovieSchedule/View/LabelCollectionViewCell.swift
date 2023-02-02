//
//  LabelCollectionViewCell.swift
//
//  Copyright © 2020 1. All rights reserved.
//

import UIKit

protocol LabelCollectionViewCellProtocol: AnyObject {
    func clickBtn(px: Double, py: Double)
}

class LabelCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var addLbl: UILabel!
    @IBOutlet weak var localLbl: UILabel!
    @IBOutlet weak var addBtn: UIButton!
    
    internal weak var delegate: LabelCollectionViewCellProtocol?
    private var data: MovieScheduleModel!
    
    static var nib: UINib {
        return UINib(nibName: "LabelCollectionViewCell", bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func clickAddBtn(_ sender: UIButton) {
        delegate?.clickBtn(px: Double(data.showInfo[0].location ?? "") ?? 0, py: Double(data.showInfo[0].latitude ?? "") ?? 0)
    }
    
    func configCell(model: MovieScheduleModel) {
        data = model
        nameLbl.text = model.title
        timeLbl.text! += (model.startDate ?? "") + "~" + (model.endDate ?? "")
        descriptionLbl.text! += model.descriptionFilterHtml ?? ""
        localLbl.text! += model.showInfo[0].locationName ?? ""

        if model.showInfo[0].location != "" {
            let attributedString = NSMutableAttributedString(string: "地址：" + (model.showInfo[0].location ?? ""), attributes: [
                    .font: UIFont(name: "PingFangTC-Regular", size: 17.0)!,
                    .foregroundColor: UIColor.blue,
                    .kern: -0.33
            ])
            attributedString.addAttributes([
                    .font: UIFont(name: "PingFangTC-Regular", size: 17.0)!,
                    .foregroundColor: UIColor(red: 91 / 255, green: 58 / 255, blue: 165 / 255, alpha: 1),
                    .kern: -0.33
            ], range: NSRange(location: 0, length: 3))
            addLbl.attributedText = attributedString
            if data.showInfo[0].location != "" && data.showInfo[0].location != "" {
                addBtn.isUserInteractionEnabled = true
            } else {
                addBtn.isUserInteractionEnabled = false
            }
        } else {
            addBtn.isUserInteractionEnabled = false
        }
    }
}
