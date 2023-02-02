//
//  HotelVIewModel.swift
//  SearchHotel
//
//  Copyright © 2020 1. All rights reserved.
//

import RxCocoa
import RxSwift
import Foundation

enum DataType: Int {
    case all = 0
    case N = 1
    case W = 2
    case S = 3
    case E = 4
    case other = 5
    case search = 6
}

class HotelViewModel {
    
    private let hotelApi = HotelAPI()
    internal var hotelSequence = BehaviorRelay<[Info]>(value: [])
    internal var types: DataType = .all
    internal var NData: [Info] = []
    internal var WData: [Info] = []
    internal var SData: [Info] = []
    internal var EData: [Info] = []
    internal var otherData: [Info] = []
    internal var searchData: [Info] = []
    
    func requestHotelData() -> Observable<Bool> {
        return hotelApi.fetchHotelModel().flatMap { [weak self] (model) -> Observable<Bool> in
            guard let `self` = self else { return Observable.just(false) }
            guard model.xmlHead?.infos?.info.count ?? 0 > 0 else { return Observable.just(false) }
            let data: [Info] = (model.xmlHead?.infos?.info)!
            self.hotelSequence.accept(data)
            
            for (i, _) in data.enumerated() {
                if data[i].name != "" {
                    if data[i].add.contains("基隆") || data[i].add.contains("新北") || data[i].add.contains("台北") || data[i].add.contains("臺北") {
                        self.NData.append(data[i])
                    } else if data[i].add.contains("彰化") || data[i].add.contains("台中") || data[i].add.contains("苗栗") || data[i].add.contains("桃園") || data[i].add.contains("臺中") || data[i].add.contains("新竹") || data[i].add.contains("南投") {
                        self.WData.append(data[i])
                    } else if data[i].add.contains("臺東") || data[i].add.contains("台東") || data[i].add.contains("花蓮") || data[i].add.contains("宜蘭") {
                        self.EData.append(data[i])
                    } else if data[i].add.contains("台南") || data[i].add.contains("臺南") || data[i].add.contains("屏東") || data[i].add.contains("高雄") || data[i].add.contains("嘉義") || data[i].add.contains("雲林") {
                        self.SData.append(data[i])
                    } else {
                        self.otherData.append(data[i])
                    }
                }
            }
            return Observable.just(true)
        }
    }
    
    func whileModel() -> [Info] {
        switch types {
        case .all:
            return hotelSequence.value
        case .N:
            return NData
        case .E:
            return EData
        case .S:
            return SData
        case .W:
            return WData
        case .search:
            return searchData
        default:
            return otherData
        }
    }
}
