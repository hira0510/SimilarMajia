//
//  SearchCollectionViewCell.swift
//  SearchHotel
//
//  Copyright © 2020 1. All rights reserved.
//

import UIKit

protocol SearchCollectionViewCellProtocol: class {
    func clickCell(indexPath: IndexPath)
    func search(title: String)
}

class SearchCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var collectionViews: UICollectionView!
    
    private let titles: [String] = ["全部", "北部", "中部", "南部", "東部", "其他"]
    internal weak var delegate: SearchCollectionViewCellProtocol?

    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollection()
    }
    
    static var nib: UINib {
        return UINib(nibName: "SearchCollectionViewCell", bundle: nil)
    }
    
    private func setupCollection() {
        collectionViews.dataSource = self
        collectionViews.delegate = self
        collectionViews.register(SearchLittleCollectionViewCell.nib, forCellWithReuseIdentifier: "SearchLittleCollectionViewCell")
        searchTextField.delegate = self
        searchTextField.enablesReturnKeyAutomatically = true
    }
}

// MARK: - UICollectionViewDelegate
extension SearchCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchLittleCollectionViewCell", for: indexPath) as! SearchLittleCollectionViewCell
        cell.configCell(title: titles[indexPath.item])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.clickCell(indexPath: indexPath)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 60, height: 25)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 5, bottom: 1, right: 5)
    }
}

// MARK: - UITextFieldDelegate
extension SearchCollectionViewCell: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        delegate?.search(title: textField.text ?? "")
        return true
    }
}
