//
//  DelicacyMainCollectionViewCell.swift
//  Delicacy
//
//  Copyright © 2020 1. All rights reserved.
//

import UIKit
import Kingfisher

class DelicacyMainCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var sImageView: UIImageView!
    @IBOutlet weak var sLabel: UILabel!
    @IBOutlet weak var addLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    private var id: String = ""
    private var isFavorite: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        sImageView.layer.cornerRadius = 10
        bgView.layer.cornerRadius = 10
    }
    
    static var nib: UINib {
        return UINib(nibName: "DelicacyMainCollectionViewCell", bundle: nil)
    }
    
    @IBAction func clickFavorite(_ sender: UIButton) {
        isFavorite = !isFavorite
        isFavorite ? favoriteButton.setImage(UIImage(named: "Favorites choose"), for: .normal) : favoriteButton.setImage(UIImage(named: "Favorites"), for: .normal)
        var favoriteData = UserDefaults.standard.object(forKey: "favorite") as? [String] ?? []
        if isFavorite {
            favoriteData.append(id)
        } else {
            for i in 0..<favoriteData.count {
                if favoriteData[i] == self.id {
                    favoriteData.remove(at: i)
                    break
                }
            }
        }
        UserDefaults.standard.set(favoriteData, forKey: "favorite")
        print(UserDefaults.standard.object(forKey: "favorite") as? [String] ?? [])
    }
    
    func config(add: String, title: String, image: String, id: String) {
        sLabel.text = title
        addLabel.text = add
        self.id = id
        
        if let url = URL(string: image) {
            DispatchQueue.main.async {
                UIImageView().kf.setImage(with: url, placeholder: UIImage(named: "bg2"), options: nil, progressBlock: nil) { (result) in
                    switch result {
                    case .success(let success):
                        self.sImageView.image = success.image
                    case .failure:
                        self.sImageView.image = UIImage(named: "bg2")
                    }
                }
            }
        } else {
            self.sImageView.image = UIImage(named: "bg2")
        }
        
        let favoriteData = UserDefaults.standard.array(forKey: "favorite") as? [String]
        
        guard favoriteData?.count ?? 0 > 0 else {
            isFavorite = false
            favoriteButton.setImage(UIImage(named: "Favorites"), for: .normal)
            return
        }
        for i in 0..<(favoriteData?.count ?? 0) {
            if favoriteData?[i] == id {
                isFavorite = true
                favoriteButton.setImage(UIImage(named: "Favorites choose"), for: .normal)
                break
            } else {
                isFavorite = false
                favoriteButton.setImage(UIImage(named: "Favorites"), for: .normal)
            }
        }
    }
}
