//
//  ExhibitionMenuViewModel.swift
//  ExhibitionIntroduction
//
//  Created by Hira on 2020/5/25.
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

class ExhibitionMenuViewModel {
    private let exhibitionApi = ExhibitionAPI()

    internal var type: MenuType = .all

    internal var allData = BehaviorRelay<[ExhibitionModel]>(value: [])
    internal var northData: [ExhibitionModel] = []
    internal var westData: [ExhibitionModel] = []
    internal var eastData: [ExhibitionModel] = []
    internal var southData: [ExhibitionModel] = []
    internal var otherData: [ExhibitionModel] = []

    internal func requestData() -> Observable<Bool> {
        return exhibitionApi.fetchData().flatMap { [weak self] (model) -> Observable<Bool> in
            guard let `self` = self else { return Observable.just(false) }
            guard model.count > 0 else { return Observable.just(false) }
            self.allData.accept(model)
            for (i, _) in model.enumerated() {
                if model[i].info.count > 0 {
                    if model[i].info[0].location.contains("臺北") || model[i].info[0].location.contains("新北") || model[i].info[0].location.contains("台北") || model[i].info[0].location.contains("基隆") {
                        self.northData.append(model[i])
                    } else if model[i].info[0].location.contains("桃園") || model[i].info[0].location.contains("新竹") || model[i].info[0].location.contains("苗栗") || model[i].info[0].location.contains("彰化") || model[i].info[0].location.contains("臺中") || model[i].info[0].location.contains("台中") || model[i].info[0].location.contains("南投") {
                        self.westData.append(model[i])
                    } else if model[i].info[0].location.contains("宜蘭") || model[i].info[0].location.contains("台東") || model[i].info[0].location.contains("花蓮") || model[i].info[0].location.contains("臺東") {
                        self.eastData.append(model[i])
                    } else if model[i].info[0].location.contains("屏東") || model[i].info[0].location.contains("高雄") || model[i].info[0].location.contains("台南") || model[i].info[0].location.contains("臺南") || model[i].info[0].location.contains("嘉義") || model[i].info[0].location.contains("雲林") || model[i].info[0].location.contains("高雄") {
                        self.southData.append(model[i])
                    } else {
                        self.otherData.append(model[i])
                    }
                }
            }
            return Observable.just(true)
        }
    }

    func numberOfItemsInSection() -> ([ExhibitionModel], Int) {
        switch type {
        case .all:
            return (allData.value, allData.value.count)
        case .north:
            return (northData, northData.count)
        case .west:
            return (westData, westData.count)
        case .south:
            return (southData, southData.count)
        case .east:
            return (eastData, eastData.count)
        default:
            return (otherData, otherData.count)
        }
    }
}
