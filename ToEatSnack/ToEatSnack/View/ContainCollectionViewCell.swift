//
//  ContainCollectionViewCell.swift
//  ToEatSnack
//
//  Created by Hira on 2020/5/27.
//  Copyright © 2020 1. All rights reserved.
//

import UIKit
import Kingfisher

class ContainCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var mImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var telLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    static var nib: UINib {
        return UINib(nibName: "ContainCollectionViewCell", bundle: nil)
    }

    func config(img: String, name: String, tel: String, address: String) {
        nameLabel.text = name
        addressLabel.text = address
        telLabel.text = tel

        if let url = URL(string: img) {
            DispatchQueue.main.async {
                UIImageView().kf.setImage(with: url, placeholder: UIImage(named: "bg"), options: nil, progressBlock: nil) { (result) in
                    switch result {
                    case .success(let success):
                        self.mImageView.image = success.image
                    case .failure(_):
                        break
                    }
                }
            }
        }
    }
}

