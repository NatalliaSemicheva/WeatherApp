//
//  ImageService.swift
//  WeatherApp
//
//  Created by Наталия Семичева on 8/12/18.
//  Copyright © 2018 Наталия Семичева. All rights reserved.
//

import UIKit

class ImageService: NSObject {
    
    static func getImage(weatherDescription weather: String) -> UIImage{
        switch weather {
        case "Clear":
            return UIImage(named: "Sunny")!
        case "Clouds":
            return UIImage(named: "Clouds")!
        case "Rain":
            return UIImage(named: "Rain")!
        case "Thunderstorm":
            return UIImage(named: "Thunderstorm")!
        case "Snow":
            return UIImage(named: "Snow")!
        default:
            return UIImage(named: "Sun")!
        }
    }
}
