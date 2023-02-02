//
//  ExhibitionService.swift
//  ExhibitionIntroduction
//
//  Created by Hira on 2020/5/25.
//  Copyright © 2020 1. All rights reserved.
//
import UIKit
import Moya

enum ExhibitionService {
    case getExhibition
}

extension ExhibitionService: TargetType {

    var baseURL: URL {
        return URL(string: "https://cloud.culture.tw/frontsite/trans/SearchShowAction.do?method=doFindTypeJ&category=6")!
    }

    var path: String {
        switch self {
        case .getExhibition:
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
