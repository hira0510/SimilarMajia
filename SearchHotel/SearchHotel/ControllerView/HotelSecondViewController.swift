//
//  HotelSecondViewController.swift
//  SearchHotel
//
//  Copyright © 2020 1. All rights reserved.
//

import UIKit

class HotelSecondViewController: UIViewController {

    @IBOutlet weak var collectionViews: UICollectionView!
    
    var model: Info!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollection()
    }

    @IBAction func clickBackButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    private func setupCollection() {
        collectionViews.dataSource = self
        collectionViews.delegate = self
        collectionViews.register(ImageCollectionViewCell.nib, forCellWithReuseIdentifier: "ImageCollectionViewCell")
        collectionViews.register(LabelCollectionViewCell.nib, forCellWithReuseIdentifier: "LabelCollectionViewCell")
        collectionViews.register(BlankCollectionReusableView.nib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "BlankCollectionReusableView")
    }
}

// MARK: - UICollectionViewDelegate
extension HotelSecondViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if model.picture2 != "" && model.picture3 != "" {
            return 4
        } else if model.picture2 != "" || model.picture3 != "" {
            return 3
        } else {
            return 2
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == collectionViews.numberOfSections - 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LabelCollectionViewCell", for: indexPath) as! LabelCollectionViewCell
            cell.delegate = self
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionViewCell", for: indexPath) as! ImageCollectionViewCell
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let image: [String] = [model.picture1, model.picture2, model.picture3]
        if indexPath.section == collectionViews.numberOfSections - 1 {
            let cell = cell as! LabelCollectionViewCell
            cell.configCell(model: model)
        } else {
            let cell = cell as! ImageCollectionViewCell
            cell.configCell(img: image[indexPath.section])
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == collectionViews.numberOfSections - 1 {
            return CGSize(width: UIScreen.main.bounds.width, height: 470)
        } else {
            return CGSize(width: UIScreen.main.bounds.width, height: 230)
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "BlankCollectionReusableView", for: indexPath)
        return header
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 15)
    }
}

// MARK: - AddressProtocol

extension HotelSecondViewController: AddressProtocol {
    func clickAddBtn(px: Double, py: Double) {
        let vc = UIStoryboard.init(name: "Hotel", bundle: nil).instantiateViewController(withIdentifier: "HotelMapViewController") as! HotelMapViewController
        vc.px = px
        vc.py = py
        present(vc, animated: true, completion: nil)
    }
}
