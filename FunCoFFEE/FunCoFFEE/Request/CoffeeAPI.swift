//
//
// CoffeeAPI 建立時間：2019/3/25 6:51 PM
//
// 使用的Swift版本：4.0
//
// Copyright © 2019 . All rights reserved.


import Foundation
import RxSwift
import Moya
import ObjectMapper

class CoffeeAPI {

    let provider = MoyaProvider<CoffeeService>()
    let mainQueue = MainScheduler.instance
    let backQueue = SerialDispatchQueueScheduler.init(qos: .background)
    
    /// 請求專題頁資料
    ///
    /// - Parameter ID: 專題期數
    /// - Returns: 回傳TopicListModel
    func resultGetCoffee() -> Observable<[CoffeeModel]> {
        return provider.rx.request(.getCoffee).asObservable().mapArray(CoffeeModel.self).subscribeOn(backQueue).observeOn(mainQueue)
    }
}
