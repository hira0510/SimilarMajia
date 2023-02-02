//
//  ViewController.swift
//  SearchHotel
//
//  Copyright © 2020 1. All rights reserved.
//

import UIKit
import RxSwift

class HotelViewController: UIViewController {

    @IBOutlet weak var collectionViews: UICollectionView!

    private let viewModel = HotelViewModel()
    private var bag: DisposeBag! = DisposeBag()

    deinit {
        bag = nil
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollection()
        resqustHotelDataToObject()
    }

    private func resqustHotelDataToObject() {
        viewModel.requestHotelData().subscribe(onNext: { [weak self] (result) in
            guard let `self` = self else { return }
            guard result else { return }
            self.collectionViews.reloadData()
            print("ok")
        }, onError: { (error) in
            print(error)
        }).disposed(by: bag)
    }

    private func setupCollection() {
        collectionViews.dataSource = self
        collectionViews.delegate = self
        collectionViews.register(SearchCollectionViewCell.nib, forCellWithReuseIdentifier: "SearchCollectionViewCell")
        collectionViews.register(HotelCollectionViewCell.nib, forCellWithReuseIdentifier: "HotelCollectionViewCell")
    }
}

// MARK: - UICollectionViewDelegate
extension HotelViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            let model = viewModel.whileModel()
            return model.count > 0 ? model.count : 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCollectionViewCell", for: indexPath) as! SearchCollectionViewCell
            cell.delegate = self
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HotelCollectionViewCell", for: indexPath) as! HotelCollectionViewCell
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard viewModel.hotelSequence.value.count > 0 else { return }
        if indexPath.section == 1 {
            let cell = cell as! HotelCollectionViewCell
            let model: Info = viewModel.whileModel()[indexPath.item]
            cell.configCell(name: model.name, img: model.picture1, add: model.add, tel: model.tel)
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = UIStoryboard.init(name: "Hotel", bundle: nil).instantiateViewController(withIdentifier: "HotelSecondViewController") as! HotelSecondViewController
        let model = viewModel.whileModel()[indexPath.item]
        vc.model = model
        present(vc, animated: true, completion: nil)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 {
            return CGSize(width: UIScreen.main.bounds.width, height: 80)
        } else {
            return CGSize(width: UIScreen.main.bounds.width, height: 100)
        }
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

// MARK: - SearchCollectionViewCellProtocol
extension HotelViewController: SearchCollectionViewCellProtocol {

    func clickCell(indexPath: IndexPath) {
        viewModel.types = DataType(rawValue: indexPath.item)!
        collectionViews.reloadData()
    }

    func search(title: String) {
        viewModel.searchData = []
        let model = viewModel.whileModel()
        viewModel.types = DataType(rawValue: 6)!
        for (i, v) in model.enumerated() {
            if model[i].add.contains(title) {
                viewModel.searchData.append(v)
            } else if model[i].name.contains(title){
                viewModel.searchData.append(v)
            }
        }
        collectionViews.reloadData()
    }
}
