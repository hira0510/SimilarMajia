//
//  DelicacyMainViewController.swift
//  Delicacy
//
//  Copyright © 2020 1. All rights reserved.
//

import UIKit
import RxSwift

class DelicacyMainViewController: UIViewController {

    @IBOutlet weak var sCollectionView: UICollectionView!
    
    private let viewModel = DelicacyMainViewModel()
    private var bag: DisposeBag! = DisposeBag()

    deinit {
        bag = nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resqustDelicacyData()
        setupCollection()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    private func resqustDelicacyData() {
        viewModel.requestDelicacyData().subscribe(onNext: { [weak self] (result) in
            guard let `self` = self else { return }
            guard result else { return }
            self.sCollectionView.reloadData()
            print("ok")
        }, onError: { (error) in
            print(error)
        }).disposed(by: bag)
    }
    
    private func setupCollection() {
        sCollectionView.dataSource = self
        sCollectionView.delegate = self
        sCollectionView.register(DelicacyTopCollectionViewCell.nib, forCellWithReuseIdentifier: "DelicacyTopCollectionViewCell")
        sCollectionView.register(DelicacyMainCollectionViewCell.nib, forCellWithReuseIdentifier: "DelicacyMainCollectionViewCell")
    }
}

// MARK: - UICollectionViewDelegate
extension DelicacyMainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

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
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DelicacyTopCollectionViewCell", for: indexPath) as! DelicacyTopCollectionViewCell
            cell.delegate = self
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DelicacyMainCollectionViewCell", for: indexPath) as! DelicacyMainCollectionViewCell
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard viewModel.AlData.value.count > 0 else { return }
        if indexPath.section == 1 {
            let cell = cell as! DelicacyMainCollectionViewCell
            let model: Info = viewModel.whichModel()[indexPath.item]
            cell.config(add: model.add, title: model.name, image: model.image1, id: model.id)
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = UIStoryboard.init(name: "Delicacy", bundle: nil).instantiateViewController(withIdentifier: "DelicacySecondViewController") as! DelicacySecondViewController
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

extension DelicacyMainViewController: DelicacyTopCollectionViewCellProtocol {
    
    func clickType(index: IndexPath) {
        viewModel.types = DelicacyType(rawValue: index.item)!
        sCollectionView.reloadData()
    }
    
    func clickFavorite() {
        let vc = UIStoryboard.init(name: "Delicacy", bundle: nil).instantiateViewController(withIdentifier: "DelicacyFavoriteViewController") as! DelicacyFavoriteViewController
        var models: [Info] = []
        let ids = UserDefaults.standard.object(forKey: "favorite") as? [String] ?? []
        for (_, value) in viewModel.AlData.value.enumerated() {
            ids.forEach { (id) in
                if value.id == id {
                    models.append(value)
                }
            }
        }
        vc.models = models
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
