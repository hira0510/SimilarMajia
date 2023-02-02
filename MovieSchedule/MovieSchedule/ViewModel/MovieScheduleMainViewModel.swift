//
//  MovieScheduleMainViewModel.swift
//  MovieSchedule
//
//  Copyright © 2020 1. All rights reserved.
//

import Foundation

enum MovieScheduleType: Int {
    case Al = 0
    case Nt = 1
    case Wt = 2
    case St = 3
    case Et = 4
    case Ot = 5
}

class MovieScheduleMainViewModel {

    let movieScheduleAPI = MovieScheduleAPI()
    var AlData: [MovieScheduleModel] = []
    var NtData: [MovieScheduleModel] = []
    var StData: [MovieScheduleModel] = []
    var EtData: [MovieScheduleModel] = []
    var WtData: [MovieScheduleModel] = []
    var OtData: [MovieScheduleModel] = []
    var types: MovieScheduleType = .Al


    func requestMovieScheduleData(success: @escaping () -> Void) {
        movieScheduleAPI.urlRequest(some: { [weak self] (model) in
            guard let `self` = self else { return }
            let datas: [MovieScheduleModel] = model
            self.AlData = datas

            for (i, _) in datas.enumerated() {
                guard datas[i].showInfo.count > 0 else { return }
                if datas[i].title != "" {
                    if datas[i].showInfo[0].location!.contains("彰化") || datas[i].showInfo[0].location!.contains("台中") || datas[i].showInfo[0].location!.contains("苗栗") || datas[i].showInfo[0].location!.contains("桃園") || datas[i].showInfo[0].location!.contains("臺中") || datas[i].showInfo[0].location!.contains("新竹") || datas[i].showInfo[0].location!.contains("南投") {
                        self.WtData.append(datas[i])
                    } else if datas[i].showInfo[0].location!.contains("基隆") || datas[i].showInfo[0].location!.contains("新北") || datas[i].showInfo[0].location!.contains("台北") || datas[i].showInfo[0].location!.contains("臺北") {
                        self.NtData.append(datas[i])
                    } else if datas[i].showInfo[0].location!.contains("台南") || datas[i].showInfo[0].location!.contains("臺南") || datas[i].showInfo[0].location!.contains("屏東") || datas[i].showInfo[0].location!.contains("高雄") || datas[i].showInfo[0].location!.contains("嘉義") || datas[i].showInfo[0].location!.contains("雲林") {
                        self.StData.append(datas[i])
                    } else if datas[i].showInfo[0].location!.contains("臺東") || datas[i].showInfo[0].location!.contains("台東") || datas[i].showInfo[0].location!.contains("花蓮") || datas[i].showInfo[0].location!.contains("宜蘭") {
                        self.EtData.append(datas[i])
                    } else {
                        self.OtData.append(datas[i])
                    }
                }
            }
            success()
        })
    }

    func whichModel() -> [MovieScheduleModel] {
        switch types {
        case .Al:
            return AlData
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
