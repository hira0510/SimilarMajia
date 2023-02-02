//
//  ExhibitionMenuViewController.swift
//  ExhibitionIntroduction
//
//  Created by Hira on 2020/5/25.
//  Copyright © 2020 1. All rights reserved.
//

import UIKit
import RxSwift

class ExhibitionMenuViewController: UIViewController {

    @IBOutlet weak var mCollection: UICollectionView!

    private let viewModel: ExhibitionMenuViewModel = ExhibitionMenuViewModel()
    private var bag: DisposeBag! = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionViewAndRegisterXib()
        requestData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    private func setupCollectionViewAndRegisterXib() {
        mCollection.delegate = self
        mCollection.dataSource = self
        mCollection.register(ExhibitionMenuTopCell.nib, forCellWithReuseIdentifier: "ExhibitionMenuTopCell")
        mCollection.register(ExhibitionMenuCell.nib, forCellWithReuseIdentifier: "ExhibitionMenuCell")
    }

    func requestData() {
        viewModel.requestData().subscribe(onNext: { [weak self] (result) in
            guard let `self` = self else { return }
            self.mCollection.reloadData()
            print(result)
        }, onError: { (Error) in
            print(Error)
        }, onCompleted: {
            print("yaaaaaaaaa")
        }, onDisposed: nil).disposed(by: bag)
    }
}

extension ExhibitionMenuViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
//            return viewModel.allData.value.count > 0 ? viewModel.allData.value.count : 0
            return viewModel.numberOfItemsInSection().1
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ExhibitionMenuTopCell", for: indexPath) as! ExhibitionMenuTopCell
            cell.delegate = self
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ExhibitionMenuCell", for: indexPath) as! ExhibitionMenuCell
            guard viewModel.allData.value.count > 0 else { return cell }
            let model = viewModel.numberOfItemsInSection().0[indexPath.item]
            let locationName = model.info.count > 0 ? model.info[0].locationName : ""
            let address = model.info.count > 0 ? model.info[0].location : ""
            cell.config(name: model.title, location: locationName , address: address , image: model.imageUrl)
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard indexPath.section == 1 else { return }
        let vc = UIStoryboard.init(name: "Exhibition", bundle: nil).instantiateViewController(withIdentifier: "ExhibitionResultViewController") as! ExhibitionResultViewController
        let model = viewModel.numberOfItemsInSection().0
        guard model.count > 0 else { return }
        vc.model = model[indexPath.item]
        self.navigationController?.pushViewController(vc, animated: true)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            return CGSize(width: self.view.frame.width, height: 73)
        } else {
            return CGSize(width: self.view.frame.width, height: 200)
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
    }
}

extension ExhibitionMenuViewController: MenuTopProtocol {
    func didClickCell(indexPath: IndexPath) {
        viewModel.type = MenuType(rawValue: indexPath.item)!
        mCollection.reloadData()
    }
}
