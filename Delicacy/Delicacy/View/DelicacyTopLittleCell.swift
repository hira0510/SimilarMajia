//
//  DelicacyTopLittleCell.swift
//  Delicacy
//
//  Copyright © 2020 1. All rights reserved.
//

import UIKit

class DelicacyTopLittleCell: UICollectionViewCell {

    @IBOutlet weak var btmView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    static var nib: UINib {
        return UINib(nibName: "DelicacyTopLittleCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        btmView.layer.cornerRadius = 3
    }
    
    func config(title: String, isSelect: Bool) {
        titleLabel.text = title
        btmView.backgroundColor = isSelect ? UIColor(red: 1, green: 130/255, blue: 0, alpha: 1) : UIColor.clear
    }
}
