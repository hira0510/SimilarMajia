//
//  CoffeeModel.swift
//  FunCoFFEE
//
//  Created by  on 2021/3/12.
//


import Foundation
import ObjectMapper

class CoffeeModel: Mappable {

    var id: String = ""
    var name: String = ""
    var url: String = ""
    var address: String = ""
    var latitude: String = ""
    var longitude: String = ""
    var mrt: String = ""
    var openTime: String = ""

    required init?(map: Map) {

    }

    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        url <- map["url"]
        address <- map["address"]
        latitude <- map["latitude"]
        longitude <- map["longitude"]
        mrt <- map["mrt"]
        openTime <- map["open_time"]
    }
}
