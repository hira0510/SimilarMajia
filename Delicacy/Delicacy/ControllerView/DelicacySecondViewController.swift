//
//  DelicacySecondViewController.swift
//  Delicacy
//
//  Copyright © 2020 1. All rights reserved.
//

import UIKit

class DelicacySecondViewController: UIViewController {

    @IBOutlet weak var sCollectionView: UICollectionView!

    var model: Info!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollection()
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.title = model.name
    }

    private func setupCollection() {
        sCollectionView.dataSource = self
        sCollectionView.delegate = self
        sCollectionView.register(DelicacyImageCell.nib, forCellWithReuseIdentifier: "DelicacyImageCell")
        sCollectionView.register(DelicacyLabelCell.nib, forCellWithReuseIdentifier: "DelicacyLabelCell")
        sCollectionView.register(DelicacyBlankReusableView.nib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "DelicacyBlankReusableView")
    }

    private func numberOfSections() -> Int {
        if model.image2 != "" && model.image3 != "" {
            return 4
        } else if model.image2 != "" || model.image3 != "" {
            return 3
        } else {
            return 2
        }
    }
}

// MARK: - UICollectionViewDelegate
extension DelicacySecondViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return numberOfSections()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == numberOfSections() - 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DelicacyLabelCell", for: indexPath) as! DelicacyLabelCell
            cell.delegate = self
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DelicacyImageCell", for: indexPath) as! DelicacyImageCell
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let image: [String] = [model.image1, model.image2, model.image3]
        if indexPath.section == numberOfSections() - 1 {
            let cell = cell as! DelicacyLabelCell
            cell.configCell(model: model)
        } else {
            let cell = cell as! DelicacyImageCell
            cell.configCell(img: image[indexPath.section])
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == numberOfSections() - 1 {
            return CGSize(width: UIScreen.main.bounds.width, height: 470)
        } else {
            return CGSize(width: UIScreen.main.bounds.width, height: 345)
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "DelicacyBlankReusableView", for: indexPath)
        return header
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 15)
    }
}

// MARK: - AddressProtocol
extension DelicacySecondViewController: LabelCollectionViewCellProtocol {
    func clickBtn(px: Double, py: Double) {
        let view = DelicacyAddressMapView(frame: UIScreen.main.bounds, px: model.px, py: model.py)
        self.view.addSubview(view)
    }
}
