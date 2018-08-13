//
//  NetworkLoader.swift
//  WeatherApp
//
//  Created by Наталия Семичева on 8/11/18.
//  Copyright © 2018 Наталия Семичева. All rights reserved.
//

import UIKit

enum LoadDataError : Error {
    case location
}

class NetworkLoader: NSObject {
    
    static let apiId = "0c4767fb9df9a5f2f3a72be22672fad7"
    static let site = "https://api.openweathermap.org/data/2.5/forecast"
    
    var locationProvider: LocationProviding
    
    override convenience init() {
        self.init(locationProviderr: GPSLocationProvider())
    }
    
    init(locationProviderr: LocationProviding) {
        locationProvider = locationProviderr
        super.init()
    }
    
    func loadData(successBlock: @escaping (WeatherModel) -> Void,
                  failureBlock: @escaping (Error) -> Void) {
        locationProvider.getLocation() { location in
            guard let location = location else {
                failureBlock(LoadDataError.location)
                return
            }
            let url = URL(string: "\(NetworkLoader.site)?lat=\(location.latitude)&lon=\(location.longitude)&appid=\(NetworkLoader.apiId)")
            
            let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
                if let error = error {
                    failureBlock(error)
                } else {
                    if let urlContent = data {
                        do {
                            let decoder = JSONDecoder()
                            let model = try decoder.decode(WeatherModel.self, from: urlContent)
                            successBlock(model)
                        } catch {
                            failureBlock(error)
                        }
                    }
                }
            }
            task.resume()
        }
    }
}
