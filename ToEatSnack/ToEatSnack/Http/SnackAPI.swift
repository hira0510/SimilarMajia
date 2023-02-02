//
//  SnackAPI.swift
//  Snack
//
//  Copyright © 2020 1. All rights reserved.
//

import UIKit
import Moya
import ObjectMapper
import RxSwift

class SnackAPI {
    let mainQueue = MainScheduler.instance
    let backQueue = SerialDispatchQueueScheduler.init(qos: .background)
    let provider = MoyaProvider<SnackService>()

    func fetchData() -> Observable<[SnackModel]> {
        return provider.rx.request(.getSnack).asObservable().mapArray(SnackModel.self).subscribeOn(backQueue).observeOn(mainQueue)
    }
}
