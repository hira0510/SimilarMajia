//
//  ExhibitionMenuTopLittleCell.swift
//  ExhibitionIntroduction
//
//  Created by Hira on 2020/5/26.
//  Copyright © 2020 1. All rights reserved.
//

import UIKit

class ExhibitionMenuTopLittleCell: UICollectionViewCell {

    @IBOutlet weak var mImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bgView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    static var nib: UINib {
        return UINib(nibName: "ExhibitionMenuTopLittleCell", bundle: nil)
    }
    
    func config(title: String) {
        mImageView.layer.cornerRadius = mImageView.frame.height / 2
        bgView.layer.cornerRadius = bgView.frame.height / 2
        mImageView.image = UIImage(named: title)
        titleLabel.text = title
    }

}
