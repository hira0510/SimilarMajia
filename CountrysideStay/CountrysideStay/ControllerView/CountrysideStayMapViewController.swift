//
//  CountrysideStayMapViewController.swift
//  CountrysideStay
//
//  Copyright © 2020 1. All rights reserved.
//

import UIKit
import MapKit

class CountrysideStayMapViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapViews: MKMapView!
 
    var latitude: String = ""
    var longitude: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapViewinit()
    }

    @IBAction func backBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    private func mapViewinit() {
        let py: Double = Double(latitude) ?? 0
        let px: Double = Double(longitude) ?? 0
        mapViews.delegate = self
        let studioAnnotation = MKPointAnnotation()
        studioAnnotation.coordinate = CLLocationCoordinate2D(latitude: py, longitude: px)
        mapViews.setCenter(studioAnnotation.coordinate, animated: true)
        mapViews.addAnnotation(studioAnnotation)
    }
}
