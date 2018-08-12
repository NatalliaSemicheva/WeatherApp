//
//  GPSService.swift
//  WeatherApp
//
//  Created by Наталия Семичева on 8/12/18.
//  Copyright © 2018 Наталия Семичева. All rights reserved.
//

import UIKit
import CoreLocation

class GPSService: NSObject, CLLocationManagerDelegate {
    let locationManager = CLLocationManager()
    
    func getCoordinates() -> CLLocationCoordinate2D? {
        
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
        guard let locationValue: CLLocationCoordinate2D = locationManager.location?.coordinate else { return nil }
        
        return locationValue
    }
}
