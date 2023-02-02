//
//  CountrysideStayViewModel.swift
//  CountrysideStay
//
//  Created by Hira on 2021/4/1.
//

import UIKit

enum CountrysideType: Int {
    case all = 0
    case N = 1
    case W = 2
    case S = 3
    case E = 4
    case other = 5
    case search = 6
}

class CountrysideStayViewModel: NSObject {
    private let countrysideStayRequest = CountrysideStayRequest()
    internal var countrysideSequence: [CountrysideStayModel] = []
    internal var types: CountrysideType = .all
    internal var NData: [CountrysideStayModel] = []
    internal var WData: [CountrysideStayModel] = []
    internal var SData: [CountrysideStayModel] = []
    internal var EData: [CountrysideStayModel] = []
    internal var otherData: [CountrysideStayModel] = []
    internal var searchData: [CountrysideStayModel] = []

    func requestCountrysideStayData(success: @escaping () -> Void) {
        countrysideStayRequest.urlRequest(some: { [weak self] (model) in
            guard let `self` = self else { return }
            guard model.count > 0 else { return }
            let data: [CountrysideStayModel] = model
            self.countrysideSequence = model

            for (i, _) in data.enumerated() {
                if data[i].Name != "" {
                    if data[i].City.contains("基隆") || data[i].City.contains("新北") || data[i].City.contains("台北") || data[i].City.contains("臺北") {
                        self.NData.append(data[i])
                    } else if data[i].City.contains("彰化") || data[i].City.contains("台中") || data[i].City.contains("苗栗") || data[i].City.contains("桃園") || data[i].City.contains("臺中") || data[i].City.contains("新竹") || data[i].City.contains("南投") {
                        self.WData.append(data[i])
                    } else if data[i].City.contains("臺東") || data[i].City.contains("台東") || data[i].City.contains("花蓮") || data[i].City.contains("宜蘭") {
                        self.EData.append(data[i])
                    } else if data[i].City.contains("台南") || data[i].City.contains("臺南") || data[i].City.contains("屏東") || data[i].City.contains("高雄") || data[i].City.contains("嘉義") || data[i].City.contains("雲林") {
                        self.SData.append(data[i])
                    } else {
                        self.otherData.append(data[i])
                    }
                }
            }
            success()
        })
    }

    func whileModel() -> [CountrysideStayModel] {
        switch types {
        case .all:
            return countrysideSequence
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
