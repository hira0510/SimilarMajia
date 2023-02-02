//
//  CoffeeMapView.swift
//  Delicacy
//
//  Copyright © 2020 1. All rights reserved.
//

import UIKit
import MapKit

class CoffeeMapView: UIView, MKMapViewDelegate {

    @IBOutlet var views: UIView!
    @IBOutlet weak var mapView: MKMapView!
    
    var mLongitude: Double = 0
    var mLatitude: Double = 0
    
    @IBAction func backBtn(_ sender: UIButton) {
        self.removeFromSuperview()
    }
    
    init(frame: CGRect, longitude: Double, latitude: Double) {
        super.init(frame: frame)
        self.mLongitude = longitude
        self.mLatitude = latitude
        subviewInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func subviewInit() {
        Bundle.main.loadNibNamed("CoffeeMapView", owner: self, options: nil)
        self.addSubview(views)
        views.translatesAutoresizingMaskIntoConstraints = false
        views.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        views.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        views.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        views.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        mapViewSetup()
    }
    
    private func mapViewSetup() {
        mapView.delegate = self
        let studioAnnotation = MKPointAnnotation()
        studioAnnotation.coordinate = CLLocationCoordinate2D(latitude: mLatitude, longitude: mLongitude)
        mapView.setCenter(studioAnnotation.coordinate, animated: true)
        mapView.addAnnotation(studioAnnotation)
    }
}
