//
//  DelicacyMainViewModel.swift
//  Delicacy
//
//  Copyright © 2020 1. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

enum DelicacyType: Int {
    case Al = 0
    case Nt = 1
    case Wt = 2
    case St = 3
    case Et = 4
    case Ot = 5
}

class DelicacyMainViewModel {

    let delicacyApi = DelicacyAPI()
    var AlData = BehaviorRelay<[Info]>(value: [])
    var NtData: [Info] = []
    var StData: [Info] = []
    var EtData: [Info] = []
    var WtData: [Info] = []
    var OtData: [Info] = []
    var types: DelicacyType = .Al


    func requestDelicacyData() -> Observable<Bool> {
        return delicacyApi.fetchDelicacyModel().flatMap { [weak self] (model) -> Observable<Bool> in
            guard let `self` = self else { return Observable.just(false) }
            guard model.head?.infos?.info.count ?? 0 > 0 else { return Observable.just(false) }
            let datas: [Info] = (model.head?.infos?.info)!
            self.AlData.accept(datas)

            for (i, _) in datas.enumerated() {
                if datas[i].name != "" {
                    if datas[i].add.contains("彰化") || datas[i].add.contains("台中") || datas[i].add.contains("苗栗") || datas[i].add.contains("桃園") || datas[i].add.contains("臺中") || datas[i].add.contains("新竹") || datas[i].add.contains("南投") {
                        self.WtData.append(datas[i])
                    } else if datas[i].add.contains("基隆") || datas[i].add.contains("新北") || datas[i].add.contains("台北") || datas[i].add.contains("臺北") {
                        self.NtData.append(datas[i])
                    } else if datas[i].add.contains("台南") || datas[i].add.contains("臺南") || datas[i].add.contains("屏東") || datas[i].add.contains("高雄") || datas[i].add.contains("嘉義") || datas[i].add.contains("雲林") {
                        self.StData.append(datas[i])
                    } else if datas[i].add.contains("臺東") || datas[i].add.contains("台東") || datas[i].add.contains("花蓮") || datas[i].add.contains("宜蘭") {
                        self.EtData.append(datas[i])
                    } else {
                        self.OtData.append(datas[i])
                    }
                }
            }
            return Observable.just(true)
        }
    }

    func whichModel() -> [Info] {
        switch types {
        case .Al:
            return AlData.value
        case .Nt:
            return NtData
        case .Et:
            return EtData
        case .St:
            return StData
        case .Wt:
            return WtData
        default:
            return OtData
        }
    }
}
