//
//  ExhibitionMenuTopCell.swift
//  ExhibitionIntroduction
//
//  Created by Hira on 2020/5/26.
//  Copyright © 2020 1. All rights reserved.
//

import UIKit

protocol MenuTopProtocol: class {
    func didClickCell(indexPath: IndexPath)
}

class ExhibitionMenuTopCell: UICollectionViewCell {

    @IBOutlet weak var mCollection: UICollectionView!
    
    let title: [String] = ["全部", "北部", "中部", "南部", "東部", "其他"]
    weak var delegate: MenuTopProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollectionViewAndRegisterXib()
    }

    static var nib: UINib {
        return UINib(nibName: "ExhibitionMenuTopCell", bundle: nil)
    }
    
    private func setupCollectionViewAndRegisterXib() {
        mCollection.delegate = self
        mCollection.dataSource = self
        mCollection.register(ExhibitionMenuTopLittleCell.nib, forCellWithReuseIdentifier: "ExhibitionMenuTopLittleCell")
    }
}


extension ExhibitionMenuTopCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ExhibitionMenuTopLittleCell", for: indexPath) as! ExhibitionMenuTopLittleCell
        cell.config(title: title[indexPath.item])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didClickCell(indexPath: indexPath)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 70, height: 70)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 20, bottom: 3, right: 20)
    }
}
