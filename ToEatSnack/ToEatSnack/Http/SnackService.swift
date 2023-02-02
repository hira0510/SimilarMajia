//
//  SnackService.swift
//  Snack
//
//  Copyright © 2020 1. All rights reserved.
//
import UIKit
import Moya

enum SnackService {
    case getSnack
}

extension SnackService: TargetType {

    var baseURL: URL {
        return URL(string: "https://data.coa.gov.tw/Service/OpenData/ODwsv/ODwsvTravelFood.aspx")!
    }

    var path: String {
        switch self {
        case .getSnack:
            return ""
        }
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

    var headers: [String: String]? {
        return nil
    }
}
