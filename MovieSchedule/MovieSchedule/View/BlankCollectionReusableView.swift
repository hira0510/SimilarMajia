//
//  BlankCollectionReusableView.swift
//  

import UIKit

class BlankCollectionReusableView: UICollectionReusableView {

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    static var nib: UINib {
        return UINib(nibName: "BlankCollectionReusableView", bundle: Bundle(for: self))
    }
}
