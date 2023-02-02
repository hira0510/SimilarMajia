//
//  MapViewController.swift
//  ToEatSnack
//
//  Copyright © 2020 1. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!

    var px: Double = 0
    var py: Double = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        subviewinit()
    }

    @IBAction func backBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    private func subviewinit() {
        mapView.delegate = self
        let studioAnnotation = MKPointAnnotation()
        studioAnnotation.coordinate = CLLocationCoordinate2D(latitude: py, longitude: px)
        mapView.setCenter(studioAnnotation.coordinate, animated: true)
        mapView.addAnnotation(studioAnnotation)
    }
}
