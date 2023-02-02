//
//  ImageCollectionViewCell.swift
//  
//
//  Created by Hira on 2020/5/28.
//

import UIKit
import Kingfisher

class ImageCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageV: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    static var nib: UINib {
        return UINib(nibName: "ImageCollectionViewCell", bundle: nil)
    }

    internal func configCell(img: String) {
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
