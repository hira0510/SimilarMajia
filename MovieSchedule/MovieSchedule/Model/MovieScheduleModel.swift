//
//  MovieScheduleModel.swift
//  MovieSchedule
//
//  Copyright © 2020 1. All rights reserved.
//
import Foundation

class MovieScheduleModel: Decodable {

    var UID: String?
    var title: String?
    var showInfo: [MovieScheduleShowInfo]
    var startDate: String?
    var endDate: String?
    var descriptionFilterHtml: String?
}

class MovieScheduleShowInfo: Decodable {
    var location: String?
    var locationName: String?
    var latitude: String?
    var longitude: String?
}
