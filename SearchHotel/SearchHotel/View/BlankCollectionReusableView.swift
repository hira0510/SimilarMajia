//
//  BlankCollectionReusableView.swift
//  
//
//  Created by Hira on 2020/5/28.
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
