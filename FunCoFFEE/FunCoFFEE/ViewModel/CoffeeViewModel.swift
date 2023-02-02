//
//  CoffeeViewModel.swift
//  FunCoFFEE
//
//  Created by  on 2021/3/12.
//

import UIKit
import RxCocoa
import RxSwift

class CoffeeViewModel {
    
    let coffeeApi = CoffeeAPI()
    var coffeeModel = BehaviorRelay<[CoffeeModel]>(value: [])

    func requestCoffeeData() -> Observable<Bool> {
        return coffeeApi.resultGetCoffee().flatMap { [weak self] (model) -> Observable<Bool> in
            guard let `self` = self else { return Observable.just(false) }
            self.coffeeModel.accept(model)
            return Observable.just(true)
        }
    }
}
