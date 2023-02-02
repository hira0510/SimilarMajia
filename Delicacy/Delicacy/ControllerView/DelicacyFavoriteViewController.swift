//
//  DelicacyFavoriteViewController.swift
//  Delicacy
//
//  Created by Hira on 2020/6/1.
//  Copyright © 2020 1. All rights reserved.
//

import UIKit

class DelicacyFavoriteViewController: UIViewController {

    @IBOutlet weak var sCollectionView: UICollectionView!

    var models: [Info] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollection()
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.title = "收藏"
    }

    private func setupCollection() {
        sCollectionView.dataSource = self
        sCollectionView.delegate = self
        sCollectionView.register(DelicacyMainCollectionViewCell.nib, forCellWithReuseIdentifier: "DelicacyMainCollectionViewCell")
    }
}

// MARK: - UICollectionViewDelegate
extension DelicacyFavoriteViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models.count > 0 ? models.count : 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DelicacyMainCollectionViewCell", for: indexPath) as! DelicacyMainCollectionViewCell
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard models.count > 0 else { return }
        let cell = cell as! DelicacyMainCollectionViewCell
        let model: Info = models[indexPath.item]
        cell.config(add: model.add, title: model.name, image: model.image1, id: model.id)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = UIStoryboard.init(name: "Delicacy", bundle: nil).instantiateViewController(withIdentifier: "DelicacySecondViewController") as! DelicacySecondViewController
        let model: Info = models[indexPath.item]
        vc.model = model
        self.navigationController?.pushViewController(vc, animated: true)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 80)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
    }
}
