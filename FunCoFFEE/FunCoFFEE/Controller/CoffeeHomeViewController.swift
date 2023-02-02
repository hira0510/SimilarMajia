//
//  CoffeeHomeViewController.swift
//  FunCoFFEE
//
//

import UIKit
import RxSwift

class CoffeeHomeViewController: UIViewController {

    @IBOutlet weak var mCollectionView: UICollectionView!

    private let viewModel = CoffeeViewModel()
    private var bag: DisposeBag! = DisposeBag()

    deinit {
        bag = nil
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollection()
        request()
    }

    private func setupCollection() {
        mCollectionView.dataSource = self
        mCollectionView.delegate = self
        mCollectionView.register(CoffeeCell.nib, forCellWithReuseIdentifier: "CoffeeCell")
    }

    func request() {
        viewModel.requestCoffeeData().subscribe(onNext: { [weak self] (result) in
            guard let `self` = self else { return }
            guard result else { return }
            self.mCollectionView.reloadData()
        }, onError: { (error) in
            print(error)
        }).disposed(by: bag)
    }
}

extension CoffeeHomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.coffeeModel.value.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CoffeeCell", for: indexPath) as! CoffeeCell
        guard viewModel.coffeeModel.value.count > 0 else { return cell }
        let model = viewModel.coffeeModel.value[indexPath.item]
        cell.configCell(model: model)
        cell.delegate = self
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 200)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
    }
}

extension CoffeeHomeViewController: CoffeeCellProtocol {
    func clickUrl(url: String) {
        guard let urls = URL(string: url) else { return }
        UIApplication.shared.open(urls, options: [:], completionHandler: nil)
    }
    
    func clickMap(longitude: String, latitude: String) {
        let view = CoffeeMapView(frame: UIScreen.main.bounds, longitude: Double(longitude) ?? 0.0, latitude: Double(latitude) ?? 0.0)
        self.view.addSubview(view)
    }
}
