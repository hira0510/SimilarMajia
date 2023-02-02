//
//  HotelCollectionViewCell.swift
//  SearchHotel
//
//  Copyright © 2020 1. All rights reserved.
//

import UIKit
import Kingfisher

class HotelCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageV: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var addLbl: UILabel!
    @IBOutlet weak var telLbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    static var nib: UINib {
        return UINib(nibName: "HotelCollectionViewCell", bundle: nil)
    }

    internal func configCell(name: String, img: String, add: String, tel: String) {
        titleLbl.text = name
        telLbl.text = tel
        addLbl.text = add

        if let urls = URL(string: img) {
            DispatchQueue.main.async {
                UIImageView().kf.setImage(with: urls, placeholder: UIImage(named: "bgImage"), options: nil, progressBlock: nil) { (result) in
                    switch result {
                    case .success(let suc):
                        self.imageV.image = suc.image
                    case .failure(_): break
                    }
                }
            }
        }
    }
}
