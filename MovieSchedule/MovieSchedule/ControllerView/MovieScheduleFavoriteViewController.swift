//
//  MovieScheduleFavoriteViewController.swift
//  MovieSchedule
//
//  Created by Hira on 2020/6/1.
//  Copyright © 2020 1. All rights reserved.
//

import UIKit

class MovieScheduleFavoriteViewController: UIViewController {

    @IBOutlet weak var sCollectionView: UICollectionView!

    var models: [MovieScheduleModel] = []

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
        sCollectionView.register(MovieScheduleMainCollectionViewCell.nib, forCellWithReuseIdentifier: "MovieScheduleMainCollectionViewCell")
    }
}

// MARK: - UICollectionViewDelegate
extension MovieScheduleFavoriteViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models.count > 0 ? models.count : 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieScheduleMainCollectionViewCell", for: indexPath) as! MovieScheduleMainCollectionViewCell
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard models.count > 0 else { return }
        let cell = cell as! MovieScheduleMainCollectionViewCell
        let model: MovieScheduleModel = models[indexPath.item]
        cell.config(add: model.showInfo[0].location ?? "", title: model.title ?? "", id: model.UID ?? "")
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = UIStoryboard.init(name: "MovieSchedule", bundle: nil).instantiateViewController(withIdentifier: "MovieScheduleSecondViewController") as! MovieScheduleSecondViewController
        let model: MovieScheduleModel = models[indexPath.item]
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
