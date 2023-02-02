//
//  MovieScheduleAPI.swift
//  MovieSchedule
//
//  Copyright © 2020 1. All rights reserved.MovieSchedule
//
import UIKit

class MovieScheduleAPI {
    
    var some : [() -> Void] = []
    var countrysideData: [MovieScheduleModel] = []
    
    let address = "https://cloud.culture.tw/frontsite/trans/SearchShowAction.do?method=doFindTypeJ&category=8"
    
    func urlRequest(some : @escaping ([MovieScheduleModel]) -> Void) {
        if let url = URL(string: address) {
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    print("error:\(error.localizedDescription)")
                } else if let response = response as? HTTPURLResponse , let data = data {
                    print("----\(response.statusCode)----")
                    let decoder = JSONDecoder()
                    if let dataArray = try? decoder.decode([MovieScheduleModel].self , from: data) {
                        print("----api請求ok----")
                        self.countrysideData = dataArray
                        some(self.countrysideData)
                    } else {
                        print("no")
                    }
                }
            }
            task.resume()
        }
    }
}
