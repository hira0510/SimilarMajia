//
//  MovieScheduleMainViewController.swift
//  MovieSchedule
//
//  Copyright © 2020 1. All rights reserved.
//

import UIKit

class MovieScheduleMainViewController: UIViewController {

    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var sCollectionView: UICollectionView!
    
    private let viewModel = MovieScheduleMainViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestMovieScheduleData()
        setupCollection()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    private func requestMovieScheduleData() {
        viewModel.requestMovieScheduleData(success: { [weak self] in
            guard let `self` = self else { return }
            DispatchQueue.main.async {
                self.sCollectionView.reloadData()
                self.activityIndicatorView.stopAnimating()
                self.activityIndicatorView.isHidden = true
            }
        })
    }
    
    private func setupCollection() {
        sCollectionView.dataSource = self
        sCollectionView.delegate = self
        sCollectionView.register(MovieScheduleTopCollectionViewCell.nib, forCellWithReuseIdentifier: "MovieScheduleTopCollectionViewCell")
        sCollectionView.register(MovieScheduleMainCollectionViewCell.nib, forCellWithReuseIdentifier: "MovieScheduleMainCollectionViewCell")
    }
}

// MARK: - UICollectionViewDelegate
extension MovieScheduleMainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            let model = viewModel.whichModel()
            return model.count > 0 ? model.count : 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieScheduleTopCollectionViewCell", for: indexPath) as! MovieScheduleTopCollectionViewCell
            cell.delegate = self
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieScheduleMainCollectionViewCell", for: indexPath) as! MovieScheduleMainCollectionViewCell
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard viewModel.AlData.count > 0 else { return }
        if indexPath.section == 1 {
            let cell = cell as! MovieScheduleMainCollectionViewCell
            let model: MovieScheduleModel = viewModel.whichModel()[indexPath.item]
            cell.config(add: model.showInfo[0].location ?? "", title: model.title ?? "", id: model.UID ?? "")
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = UIStoryboard.init(name: "MovieSchedule", bundle: nil).instantiateViewController(withIdentifier: "MovieScheduleSecondViewController") as! MovieScheduleSecondViewController
        let model = viewModel.whichModel()[indexPath.item]
        vc.model = model
        self.navigationController?.pushViewController(vc, animated: true)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 {
            return CGSize(width: UIScreen.main.bounds.width, height: 80)
        } else {
            return CGSize(width: UIScreen.main.bounds.width, height: 40)
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == 1 {
            return UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
        } else {
            return UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
        }
    }
}

extension MovieScheduleMainViewController: MovieScheduleTopCollectionViewCellProtocol {
    
    func clickType(index: IndexPath) {
        viewModel.types = MovieScheduleType(rawValue: index.item)!
        sCollectionView.reloadData()
    }
    
    func clickFavorite() {
        let vc = UIStoryboard.init(name: "MovieSchedule", bundle: nil).instantiateViewController(withIdentifier: "MovieScheduleFavoriteViewController") as! MovieScheduleFavoriteViewController
        var models: [MovieScheduleModel] = []
        let ids = UserDefaults.standard.object(forKey: "favorite") as? [String] ?? []
        for (_, value) in viewModel.AlData.enumerated() {
            ids.forEach { (id) in
                if value.UID == id {
                    models.append(value)
                }
            }
        }
        vc.models = models
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
