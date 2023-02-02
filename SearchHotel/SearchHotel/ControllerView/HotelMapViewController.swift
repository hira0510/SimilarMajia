//
//  HotelMapViewController.swift
//  SearchHotel
//
//  Copyright © 2020 1. All rights reserved.
//

import UIKit
import MapKit

class HotelMapViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapViews: MKMapView!

    var px: Double = 0
    var py: Double = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        mapViewinit()
    }

    @IBAction func backBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    private func mapViewinit() {
        mapViews.delegate = self
        let studioAnnotation = MKPointAnnotation()
        studioAnnotation.coordinate = CLLocationCoordinate2D(latitude: py, longitude: px)
        mapViews.setCenter(studioAnnotation.coordinate, animated: true)
        mapViews.addAnnotation(studioAnnotation)
    }
}
