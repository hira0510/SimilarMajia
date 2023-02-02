//
//  MovieScheduleTopCollectionViewCell.swift
//  MovieSchedule
//
//  Copyright © 2020 1. All rights reserved.
//

import UIKit

protocol MovieScheduleTopCollectionViewCellProtocol: class {
    func clickType(index: IndexPath)
    func clickFavorite()
}

class MovieScheduleTopCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var sCollectionView: UICollectionView!
    
    weak var delegate: MovieScheduleTopCollectionViewCellProtocol?
    let title = ["全部", "北部", "中部", "南部", "東部", "其他"]
    var isSelect = [true, false, false, false, false, false]
    
    static var nib: UINib {
        return UINib(nibName: "MovieScheduleTopCollectionViewCell", bundle: nil)
    }

    @IBAction func clickFavorite(_ sender: UIButton) {
        delegate?.clickFavorite()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollection()
    }
    
    private func setupCollection() {
        sCollectionView.dataSource = self
        sCollectionView.delegate = self
        sCollectionView.register(TopLittleCollectionViewCell.nib, forCellWithReuseIdentifier: "TopLittleCollectionViewCell")
    }
}

// MARK: - UICollectionViewDelegate
extension MovieScheduleTopCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TopLittleCollectionViewCell", for: indexPath) as! TopLittleCollectionViewCell
        cell.config(title: title[indexPath.item], isSelect: isSelect[indexPath.item])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        for (i, _) in isSelect.enumerated() {
            isSelect[i] = false
        }
        isSelect[indexPath.item] = true
        delegate?.clickType(index: indexPath)
        sCollectionView.reloadData()
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 90, height: 40)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
}
