//
//  SnackViewModel.swift
//  ToEatSnack
//
//  Copyright © 2020 1. All rights reserved.
//

import RxCocoa
import RxSwift
import Foundation

enum MenuType: Int {
    case all = 0
    case north = 1
    case west = 2
    case south = 3
    case east = 4
    case other = 5
}

class SnackViewModel {

    private let snackApi = SnackAPI()
    internal var allData = BehaviorRelay<[SnackModel]>(value: [])
    internal var northData: [SnackModel] = []
    internal var westData: [SnackModel] = []
    internal var southData: [SnackModel] = []
    internal var eastData: [SnackModel] = []
    internal var otherData: [SnackModel] = []
    internal var type: MenuType = .all
    internal var isOpen: [Bool] = [false, false, false, false, false, false]

    internal func requestSnackModel() -> Observable<Bool> {
        return snackApi.fetchData().flatMap { [weak self] (model) -> Observable<Bool> in
            guard let `self` = self else { return Observable.just(false) }
            guard model.count > 0 else { return Observable.just(false) }
            self.allData.accept(model)
            for (i, _) in model.enumerated() {
                if model[i].name != "" {
                    if model[i].address.contains("臺北") || model[i].address.contains("新北") || model[i].address.contains("台北") || model[i].address.contains("基隆") {
                        self.northData.append(model[i])
                    } else if model[i].address.contains("桃園") || model[i].address.contains("新竹") || model[i].address.contains("苗栗") || model[i].address.contains("彰化") || model[i].address.contains("臺中") || model[i].address.contains("台中") || model[i].address.contains("南投") {
                        self.westData.append(model[i])
                    } else if model[i].address.contains("宜蘭") || model[i].address.contains("台東") || model[i].address.contains("花蓮") || model[i].address.contains("臺東") {
                        self.eastData.append(model[i])
                    } else if model[i].address.contains("屏東") || model[i].address.contains("高雄") || model[i].address.contains("台南") || model[i].address.contains("臺南") || model[i].address.contains("嘉義") || model[i].address.contains("雲林") || model[i].address.contains("高雄") {
                        self.southData.append(model[i])
                    } else {
                        self.otherData.append(model[i])
                    }
                }
            }
            return Observable.just(true)
        }
    }
}
