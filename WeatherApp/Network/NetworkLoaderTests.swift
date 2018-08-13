//
//  NetworkLoaderTests.swift
//  WeatherApp
//
//  Created by Наталия Семичева on 8/13/18.
//  Copyright © 2018 Наталия Семичева. All rights reserved.
//

import XCTest

class NetworkLoaderTests: XCTestCase {
    
    var networkLoader: NetworkLoader!
    var locationProvider: LocationProviderSpy!
    
    override func setUp() {
        super.setUp()
        locationProvider = LocationProviderSpy()
        networkLoader = NetworkLoader(locationProviderr: locationProvider)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testGetLocationCalled() {
        var successReturned = false
        var failureReturned = false
        
        networkLoader.loadData(successBlock: { (weatherModel) in
            successReturned = true
        }) { (error) in
            failureReturned = true
        }
        
        XCTAssert(locationProvider.getLocationCalled != nil)
        XCTAssert(locationProvider.getLocationCalled!)
        
        XCTAssert(successReturned == false)
        XCTAssert(failureReturned == true)
    }
    
    
}
