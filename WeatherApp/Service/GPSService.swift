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
    
    static let shared = GPSService()
    
    let locationManager: CLLocationManager
    var locationRequests: Array<(CLLocationCoordinate2D?) -> (Void)> = Array()
    
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
    
    func getCoordinates(onFinish:(@escaping (CLLocationCoordinate2D?) -> (Void))) {
        if (hasLocationPermission()) {
            onFinish(locationManager.location?.coordinate)
        } else {
            locationRequests.append(onFinish)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            locationRequests.forEach { (onFinish) in
                onFinish(locationManager.location?.coordinate)
            }
        }
    }
    
}
