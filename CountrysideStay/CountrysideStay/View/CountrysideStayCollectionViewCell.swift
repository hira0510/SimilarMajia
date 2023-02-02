//
//  CountrysideStayCollectionViewCell.swift
//  CountrysideStay
//
//  Copyright © 2020 1. All rights reserved.
//

import UIKit

class CountrysideStayCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageV: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var addLbl: UILabel!
    @IBOutlet weak var telLbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    static var nib: UINib {
        return UINib(nibName: "CountrysideStayCollectionViewCell", bundle: nil)
    }

    internal func configCell(name: String, img: String, add: String, tel: String) {
        titleLbl.text = name
        telLbl.text = tel
        addLbl.text = add
        self.imageV.alpha = 0.5

        if let urls = URL(string: img) {
            DispatchQueue.main.async {
                UIImageView().kf.setImage(with: urls, placeholder: UIImage(named: "bg"), options: nil, progressBlock: nil) { (result) in
                    switch result {
                    case .success(let suc):
                        self.imageV.image = suc.image
                        self.imageV.alpha = 1
                    case .failure(_): break
                    }
                }
            }
        }
    }
}
