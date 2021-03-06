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
    let dateString: String
    
    enum CodingKeys: String, CodingKey {
        case weather = "weather"
        case degree = "main"
        case dateString = "dt_txt"
    }
    
    func convertStringToDate() -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd, HH:mm"
        
        guard let date = dateFormatterGet.date(from: dateString) else {
            return dateString
        }
        return dateFormatterPrint.string(from: date)
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
    
    func celcius() -> String {
        let celsiusDegree = Int(round(temp - 273.15))
        return "\(celsiusDegree) °C"
    }
}

struct City: Decodable, Encodable  {
    let name: String
}
