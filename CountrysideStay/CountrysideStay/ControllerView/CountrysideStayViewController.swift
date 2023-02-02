//
//  ViewController.swift
//  CountrysideStay
//
//  Copyright © 2020 1. All rights reserved.
//

import UIKit

class CountrysideStayViewController: UIViewController {

    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var collectionViews: UICollectionView!

    let viewModel = CountrysideStayViewModel()
    static var countrysideModel: [CountrysideStayModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollection()
        resqustCountrysideStayToObject()
    }

    private func resqustCountrysideStayToObject() {
        viewModel.requestCountrysideStayData(success: { [weak self] in
            guard let `self` = self else { return }
            DispatchQueue.main.async {
                self.collectionViews.reloadData()
                self.activityIndicatorView.stopAnimating()
                self.activityIndicatorView.isHidden = true
            }
        })
    }

    private func setupCollection() {
        collectionViews.dataSource = self
        collectionViews.delegate = self
        collectionViews.register(SearchCollectionViewCell.nib, forCellWithReuseIdentifier: "SearchCollectionViewCell")
        collectionViews.register(CountrysideStayCollectionViewCell.nib, forCellWithReuseIdentifier: "CountrysideStayCollectionViewCell")
    }
}

// MARK: - UICollectionViewDelegate
extension CountrysideStayViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

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
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CountrysideStayCollectionViewCell", for: indexPath) as! CountrysideStayCollectionViewCell
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard viewModel.countrysideSequence.count > 0 else { return }
        if indexPath.section == 1 {
            let cell = cell as! CountrysideStayCollectionViewCell
            let model: CountrysideStayModel = viewModel.whileModel()[indexPath.item]
            cell.configCell(name: model.Name, img: model.Photo, add: model.Address, tel: model.Tel)
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = UIStoryboard.init(name: "CountrysideStay", bundle: nil).instantiateViewController(withIdentifier: "CountrysideStaySecondViewController") as! CountrysideStaySecondViewController
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
extension CountrysideStayViewController: SearchCollectionViewCellProtocol {

    func clickCell(indexPath: IndexPath) {
        viewModel.types = CountrysideType(rawValue: indexPath.item)!
        collectionViews.reloadData()
    }

    func search(title: String) {
        viewModel.searchData = []
        let model = viewModel.whileModel()
        viewModel.types = CountrysideType(rawValue: 6)!
        for (i, v) in model.enumerated() {
            if model[i].Address.contains(title) {
                viewModel.searchData.append(v)
            } else if model[i].Name.contains(title){
                viewModel.searchData.append(v)
            }
        }
        collectionViews.reloadData()
    }
}
