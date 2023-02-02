//
//  AddressMapView.swift
//  MovieSchedule
//
//  Copyright © 2020 1. All rights reserved.
//

import UIKit
import MapKit

class AddressMapView: UIView, MKMapViewDelegate {

    @IBOutlet var views: UIView!
    @IBOutlet weak var mapView: MKMapView!
    
    var px: Double = 0
    var py: Double = 0
    
    @IBAction func backBtn(_ sender: UIButton) {
        self.removeFromSuperview()
    }
    
    init(frame: CGRect, px: Double, py: Double) {
        super.init(frame: frame)
        self.px = px
        self.py = py
        subviewInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func subviewInit() {
        Bundle.main.loadNibNamed("AddressMapView", owner: self, options: nil)
        self.addSubview(views)

        views.translatesAutoresizingMaskIntoConstraints = false
        views.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        views.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        views.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        views.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        mapViewInit()
    }
    
    private func mapViewInit() {
        mapView.delegate = self
        let studioAnnotation = MKPointAnnotation()
        studioAnnotation.coordinate = CLLocationCoordinate2D(latitude: py, longitude: px)
        mapView.setCenter(studioAnnotation.coordinate, animated: true)
        mapView.addAnnotation(studioAnnotation)
    }
}
