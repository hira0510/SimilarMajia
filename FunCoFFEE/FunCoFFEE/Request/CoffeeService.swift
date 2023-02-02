//
//
// CoffeeService 建立時間：2019/3/25 6:41 PM
//
// 使用的Swift版本：4.0
//
// Copyright © 2019 . All rights reserved.


import Foundation
import Moya

enum CoffeeService {
    case getCoffee
}

extension CoffeeService: TargetType {
    
    var baseURL: URL {
        return URL(string: "https://cafenomad.tw/api/v1.2/cafes/taipei")!
    }
    
    var path: String {
        return ""
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        return .requestPlain
    }
    
    var headers: [String : String]? {
        return [:]
    }
}
