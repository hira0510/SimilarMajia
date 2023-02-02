//
//  ExhibitionMenuCell.swift
//  ExhibitionIntroduction
//
//  Created by Hira on 2020/5/25.
//  Copyright © 2020 1. All rights reserved.
//

import UIKit
import Kingfisher

class ExhibitionMenuCell: UICollectionViewCell {

    @IBOutlet weak var mImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var noImageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    static var nib: UINib {
        return UINib(nibName: "ExhibitionMenuCell", bundle: nil)
    }
    
    func config(name: String, location: String, address: String, image: String) {
        nameLabel.text = name
        locationLabel.text = location
        addressLabel.text = address
        
        if image == "" {
            mImage.image = UIImage(named: "landing")
            noImageLabel.isHidden = false
        } else {
            if let url = URL(string: image) {
                DispatchQueue.main.async {
                    UIImageView().kf.setImage(with: url, placeholder: UIImage(named: "landing"), options: nil, progressBlock: nil) { (result) in
                        switch result {
                        case .success(let success):
                            self.noImageLabel.isHidden = true
                            self.mImage.image = success.image
                        case .failure(_):
                            self.noImageLabel.isHidden = false
                            break
                        }
                    }
                }
            }
        }
    }
}
