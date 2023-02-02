//
//  SnackModel.swift
//  Snack
//
//  Copyright © 2020 1. All rights reserved.
//

import Foundation
import ObjectMapper

class SnackModel: Mappable {
    
    var name: String = ""
    var address: String = ""
    var tel: String = ""
    var introduce: String = ""
    var picURL: String = ""
    var longitude: String = ""
    var latitude: String = ""
    var webUrl: String = ""

    required init?(map: Map) {

    }

    func mapping(map: Map) {
        name <- map["Name"]
        address <- map["Address"]
        tel <- map["Tel"]
        introduce <- map["HostWords"]
        picURL <- map["PicURL"]
        latitude <- map["Latitude"]
        longitude <- map["Longitude"]
        webUrl <- map["Url"]
    }
}
