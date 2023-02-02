//
//  DelicacyBlankReusableView.swift
//  

import UIKit

class DelicacyBlankReusableView: UICollectionReusableView {

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    static var nib: UINib {
        return UINib(nibName: "DelicacyBlankReusableView", bundle: Bundle(for: self))
    }
}
