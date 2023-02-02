//
//  TopLittleCollectionViewCell.swift
//  MovieSchedule
//
//  Copyright © 2020 1. All rights reserved.
//

import UIKit

class TopLittleCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var btmView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    static var nib: UINib {
        return UINib(nibName: "TopLittleCollectionViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        btmView.layer.cornerRadius = 3
    }
    
    func config(title: String, isSelect: Bool) {
        titleLabel.text = title
        btmView.backgroundColor = isSelect ? UIColor(red: 91 / 255, green: 58/255, blue: 165/255, alpha: 1) : UIColor.clear
    }
}
