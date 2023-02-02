//
//  SnackMainViewController.swift
//  ToEatSnack
//
//  Copyright © 2020 1. All rights reserved.
//

import UIKit
import RxSwift

class SnackMainViewController: UIViewController {

    @IBOutlet weak var mCollectionView: UICollectionView!

    private let viewModel: SnackViewModel = SnackViewModel()
    private var bag: DisposeBag! = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionViewAndRegisterXib()
        requestData()
    }

    private func setupCollectionViewAndRegisterXib() {
        mCollectionView.delegate = self
        mCollectionView.dataSource = self
        mCollectionView.register(ContainCollectionViewCell.nib, forCellWithReuseIdentifier: "ContainCollectionViewCell")
        mCollectionView.register(MenuCollectionReusableView.nib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "MenuCollectionReusableView")

    }

    func requestData() {
        viewModel.requestSnackModel().subscribe(onNext: { [weak self] (result) in
            guard let `self` = self else { return }
            self.mCollectionView.reloadData()
            print(result)
        }, onError: { (Error) in
            print(Error)
        }, onCompleted: {
            print("yaaaaaaaaa")
        }, onDisposed: nil).disposed(by: bag)
    }
}

extension SnackMainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 6
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var model: [SnackModel] = []
        switch section {
        case 0:
            model = viewModel.allData.value
        case 1:
            model = viewModel.northData
        case 2:
            model = viewModel.westData
        case 3:
            model = viewModel.southData
        case 4:
            model = viewModel.eastData
        default:
            model = viewModel.otherData
        }
        return viewModel.isOpen[section] ? model.count : 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContainCollectionViewCell", for: indexPath) as! ContainCollectionViewCell
        switch indexPath.section {
        case 0:
            let model = viewModel.allData.value[indexPath.item]
            cell.config(img: model.picURL, name: model.name, tel: model.tel, address: model.address)
        case 1:
            let model = viewModel.northData[indexPath.item]
            cell.config(img: model.picURL, name: model.name, tel: model.tel, address: model.address)
        case 2:
            let model = viewModel.westData[indexPath.item]
            cell.config(img: model.picURL, name: model.name, tel: model.tel, address: model.address)
        case 3:
            let model = viewModel.southData[indexPath.item]
            cell.config(img: model.picURL, name: model.name, tel: model.tel, address: model.address)
        case 4:
            let model = viewModel.eastData[indexPath.item]
            cell.config(img: model.picURL, name: model.name, tel: model.tel, address: model.address)
        default:
            let model = viewModel.otherData[indexPath.item]
            cell.config(img: model.picURL, name: model.name, tel: model.tel, address: model.address)
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = UIStoryboard.init(name: "Snack", bundle: nil).instantiateViewController(withIdentifier: "introduceViewController") as! introduceViewController
        var model: SnackModel
        switch indexPath.section {
        case 0:
            model = viewModel.allData.value[indexPath.item]
        case 1:
            model = viewModel.northData[indexPath.item]
        case 2:
            model = viewModel.westData[indexPath.item]
        case 3:
            model = viewModel.southData[indexPath.item]
        case 4:
            model = viewModel.eastData[indexPath.item]
        default:
            model = viewModel.otherData[indexPath.item]
        }
        vc.snackModel = model
        present(vc, animated: true, completion: nil)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width - 20, height: 170)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }

    func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        guard viewModel.allData.value.count > 0 else { return }
        let header = view as! MenuCollectionReusableView
        header.delegate = self
        viewModel.type = MenuType(rawValue: indexPath.section)!
        switch viewModel.type {
        case .all:
            header.config(type: "全部", tag: indexPath.section, isOpen: viewModel.isOpen[indexPath.section])
        case .north:
            header.config(type: "北部", tag: indexPath.section, isOpen: viewModel.isOpen[indexPath.section])
        case .west:
            header.config(type: "中部", tag: indexPath.section, isOpen: viewModel.isOpen[indexPath.section])
        case .south:
            header.config(type: "南部", tag: indexPath.section, isOpen: viewModel.isOpen[indexPath.section])
        case .east:
            header.config(type: "東部", tag: indexPath.section, isOpen: viewModel.isOpen[indexPath.section])
        default:
            header.config(type: "其他", tag: indexPath.section, isOpen: viewModel.isOpen[indexPath.section])
        }
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "MenuCollectionReusableView", for: indexPath)
        return header
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - 20, height: 40)
    }
}

extension SnackMainViewController: HeaderProtocol {

    func didClickExpansionButton(tag: Int) {
        for (i, _) in viewModel.isOpen.enumerated() {
            if i == tag {
                viewModel.isOpen[i] = !viewModel.isOpen[i]
                mCollectionView.reloadSections(IndexSet(integer: tag))
                break
            }
        }
    }
}
