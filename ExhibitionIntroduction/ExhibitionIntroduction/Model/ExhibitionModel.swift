//
//  ExhibitionModel.swift
//  ExhibitionIntroduction
//
//  Created by Hira on 2020/5/25.
//  Copyright © 2020 1. All rights reserved.
//

import Foundation
import ObjectMapper

class ExhibitionModel: Mappable {
    
    var title: String = ""
    var info: [ShowInfo] = []
    var description: String = ""
    var imageUrl: String = ""
    var sourceWebPromote: String = ""

    required init?(map: Map) {

    }

    func mapping(map: Map) {
        title <- map["title"]
        info <- map["showInfo"]
        description <- map["descriptionFilterHtml"]
        imageUrl <- map["imageUrl"]
        sourceWebPromote <- map["sourceWebPromote"]
    }
}

class ShowInfo: Mappable {
    
    var time: String = ""
    var location: String = ""
    var locationName: String = ""
    var endTime: String = ""

    required init?(map: Map) {

    }

    func mapping(map: Map) {
        time <- map["time"]
        location <- map["location"]
        locationName <- map["locationName"]
        endTime <- map["endTime"]
    }
}
