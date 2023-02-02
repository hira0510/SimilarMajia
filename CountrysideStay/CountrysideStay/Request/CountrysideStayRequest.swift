//
//  CountrysideStayRequest.swift
//  CountrysideStay
//
//  Created by Hira on 2021/4/1.
//

import UIKit

class CountrysideStayRequest {
    
    var some : [() -> Void] = []
    var countrysideData: [CountrysideStayModel] = []
    
    let address = "https://data.coa.gov.tw/Service/OpenData/ODwsv/ODwsvTravelStay.aspx"
    
    func urlRequest(some : @escaping ([CountrysideStayModel]) -> Void) {
        if let url = URL(string: address) {
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    print("error:\(error.localizedDescription)")
                } else if let response = response as? HTTPURLResponse , let data = data {
                    print("----\(response.statusCode)----")
                    let decoder = JSONDecoder()
                    if let dataArray = try? decoder.decode([CountrysideStayModel].self , from: data) {
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
