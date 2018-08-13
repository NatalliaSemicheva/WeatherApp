//
//  LocationProviding.swift
//  WeatherApp
//
//  Created by Наталия Семичева on 8/13/18.
//  Copyright © 2018 Наталия Семичева. All rights reserved.
//

import Foundation

protocol LocationProviding {
    func getLocation(onFinish:(@escaping (Location?) -> (Void)))
}
