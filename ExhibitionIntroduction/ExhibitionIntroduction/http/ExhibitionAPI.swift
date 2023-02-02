//
//  ExhibitionAPI.swift
//  ExhibitionIntroduction
//
//  Created by Hira on 2020/5/25.
//  Copyright © 2020 1. All rights reserved.
//

import UIKit
import Moya
import ObjectMapper
import RxSwift

class ExhibitionAPI {
    let mainQueue = MainScheduler.instance
    let backQueue = SerialDispatchQueueScheduler.init(qos: .background)
    let provider = MoyaProvider<ExhibitionService>()

    func fetchData() -> Observable<[ExhibitionModel]> {
        return provider.rx.request(.getExhibition).asObservable().mapArray(ExhibitionModel.self).subscribeOn(backQueue).observeOn(mainQueue)
    }
}
