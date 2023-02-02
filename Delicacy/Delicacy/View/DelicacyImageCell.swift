//
//  DelicacyImageCell.swift
//  

import UIKit
import Kingfisher

class DelicacyImageCell: UICollectionViewCell {

    @IBOutlet weak var imageV: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    static var nib: UINib {
        return UINib(nibName: "DelicacyImageCell", bundle: nil)
    }

    internal func configCell(img: String) {
        if let urls = URL(string: img) {
            DispatchQueue.main.async {
                UIImageView().kf.setImage(with: urls, placeholder: UIImage(named: "bg2"), options: nil, progressBlock: nil) { (result) in
                    switch result {
                    case .success(let suc):
                        self.imageV.image = suc.image
                    case .failure(_):
                        self.imageV.image = UIImage(named: "bg2")
                    }
                }
            }
        } else {
            self.imageV.image = UIImage(named: "bg2")
        }
    }
}
