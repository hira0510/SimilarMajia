//
//  HotelModel.swift
//  SearchHotel
//
//  Copyright © 2020 1. All rights reserved.
//
import Foundation
import ObjectMapper

class HotelModel: Mappable {

    var xmlHead: XmlHead?

    required init?(map: Map) {

    }

    func mapping(map: Map) {
        xmlHead <- map["XML_Head"]
    }
}

class XmlHead: Mappable {

    var infos: Infos?

    required init?(map: Map) {

    }

    func mapping(map: Map) {
        infos <- map["Infos"]
    }
}

class Infos: Mappable {

    var info: [Info] = []

    required init?(map: Map) {

    }

    func mapping(map: Map) {
        info <- map["Info"]
    }
}

class Info: Mappable {

    var name: String = ""
    var description: String = ""
    var add: String = ""
    var tel: String = ""
    var picture1: String = ""
    var picture2: String = ""
    var picture3: String = ""
    var px: Double = 0
    var py: Double = 0
    var money: String = ""
    var serviceInfo: String = ""
    var parkinginfo: String = ""

    required init?(map: Map) {

    }

    func mapping(map: Map) {
        name <- map["Name"]
        description <- map["Description"]
        add <- map["Add"]
        tel <- map["Tel"]
        picture1 <- map["Picture1"]
        picture2 <- map["Picture2"]
        picture3 <- map["Picture3"]
        px <- map["Px"]
        py <- map["Py"]
        money <- map["Spec"]
        serviceInfo <- map["Serviceinfo"]
        parkinginfo <- map["Parkinginfo"]
    }
}
