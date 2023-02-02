//
//  MenuCollectionReusableView.swift
//  Snack
//
//  Copyright © 2020 1. All rights reserved.
//

import UIKit

protocol HeaderProtocol: class {
    func didClickExpansionButton(tag: Int)
}

class MenuCollectionReusableView: UICollectionReusableView {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var expansionButton: UIButton!
    
    weak var delegate: HeaderProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    static var nib: UINib {
        return UINib(nibName: "MenuCollectionReusableView", bundle: Bundle(for: self))
    }
    
    @objc func didClickExpansionButton(sender: UIButton) {
        if expansionButton.image(for: .normal) == UIImage(named: "Image_close") {
            expansionButton.setImage(UIImage(named: "Image_more"), for: .normal)
        } else {
            expansionButton.setImage(UIImage(named: "Image_close"), for: .normal)
        }
        delegate?.didClickExpansionButton(tag: sender.tag)
    }
    
    func config(type: String, tag: Int, isOpen: Bool) {
        titleLabel.text = type
        expansionButton.addTarget(self, action: #selector(didClickExpansionButton), for: .touchUpInside)
        expansionButton.tag = tag
        if isOpen {
            expansionButton.setImage(UIImage(named: "Image_more"), for: .normal)
        } else {
            expansionButton.setImage(UIImage(named: "Image_close"), for: .normal)
        }
    }
}
