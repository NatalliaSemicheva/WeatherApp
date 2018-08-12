//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by Наталия Семичева on 8/11/18.
//  Copyright © 2018 Наталия Семичева. All rights reserved.
//

import UIKit

struct WeatherModel: Decodable, Encodable {
    let city: City
    let list: [WeatherItem]
}

struct WeatherItem: Decodable, Encodable {
    let degree: Temperature
    let weather: [WeatherDescription]
    
    enum CodingKeys: String, CodingKey {
        case weather = "weather"
        case degree = "main"
    }
}

struct WeatherDescription: Decodable, Encodable  {
    let description: String
    
    enum CodingKeys: String, CodingKey {
        case description = "main"
    }
}

struct Temperature: Decodable, Encodable  {
    let temp: Double
}

struct City: Decodable, Encodable  {
    let name: String
}
