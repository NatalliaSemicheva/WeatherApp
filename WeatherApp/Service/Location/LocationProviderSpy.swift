//
//  LocationProviderSpy.swift
//  WeatherApp
//
//  Created by Наталия Семичева on 8/13/18.
//  Copyright © 2018 Наталия Семичева. All rights reserved.
//

import UIKit

class LocationProviderSpy: NSObject, LocationProviding {
    
    var getLocationCalled: Bool?
    var getLocationOnFinishBlock: ((Location?) -> (Void))?
    
    var returnedLocation: Location?
 
    // MARK: - LocationProviding
    func getLocation(onFinish: @escaping ((Location?) -> (Void))) {
        getLocationCalled = true
        getLocationOnFinishBlock = onFinish
        
        onFinish(returnedLocation)
    }
}
