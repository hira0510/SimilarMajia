//
//  ImageCollectionViewCell.swift
//  
//
//  Created by Hira on 2020/5/28.
//

import UIKit

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
            
            self.imageV.alpha = 0.3
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
