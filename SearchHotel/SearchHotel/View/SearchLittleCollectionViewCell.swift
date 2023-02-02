//
//  SearchLittleCollectionViewCell.swift
//  

import UIKit

class SearchLittleCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        bgView.layer.cornerRadius = 15
    }
    
    static var nib: UINib {
        return UINib(nibName: "SearchLittleCollectionViewCell", bundle: nil)
    }

    func configCell(title: String) {
        titleLabel.text = title
    }
}
