//
//  GPSLocationProvider.swift
//  WeatherApp
//
//  Created by Наталия Семичева on 8/12/18.
//  Copyright © 2018 Наталия Семичева. All rights reserved.
//

import UIKit
import CoreLocation

class GPSLocationProvider: NSObject, LocationProviding, CLLocationManagerDelegate {
    
    static let shared = GPSLocationProvider()
    
    let locationManager: CLLocationManager
    var locationRequests: Array<(Location?) -> (Void)> = Array()
    
    override init() {
        locationManager = CLLocationManager()
        super.init()
        self.configureLocationManager()
    }
    
    func configureLocationManager() {
        locationManager.delegate = self
        if CLLocationManager.locationServicesEnabled() {
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    func hasLocationPermission() -> Bool {
        let authorizationStatus = CLLocationManager.authorizationStatus()
        return (authorizationStatus == .authorizedWhenInUse || authorizationStatus == .authorizedAlways)
    }
    
    func requestLocationPermission() {
        if hasLocationPermission() == false {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            locationRequests.forEach { (onFinish) in
                onFinish(location(forCoordinate: locationManager.location?.coordinate))
            }
        }
    }
    
    func location(forCoordinate coordinate:CLLocationCoordinate2D?) -> Location? {
        if let coordinate = coordinate {
            return Location(latitude: coordinate.latitude, longitude: coordinate.longitude)
        } else {
            return nil
        }
    }
    
    // MARK: - LocationProviding
    
    func getLocation(onFinish:(@escaping (Location?) -> (Void))) {
        if (hasLocationPermission()) {
            onFinish(location(forCoordinate: locationManager.location?.coordinate))
        } else {
            locationRequests.append(onFinish)
        }
    }
    
}
