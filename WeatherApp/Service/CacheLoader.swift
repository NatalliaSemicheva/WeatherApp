//
//  WeatherLoader.swift
//  WeatherApp
//
//  Created by Наталия Семичева on 8/11/18.
//  Copyright © 2018 Наталия Семичева. All rights reserved.
//

import UIKit

class CacheLoader: NSObject {
    
    func cachesDirectory() -> URL {
        let paths = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)
        return paths[0]
    }
    func datafilePath() -> URL {
        return cachesDirectory().appendingPathComponent("WeatherApp.plist")
    }
    
    func saveData(data model: WeatherModel){
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(model)
            try data.write(to: datafilePath(), options: Data.WritingOptions.atomic)
        } catch {
            print("Error encoding!")
        }
    }
    
    func loadData() -> WeatherModel? {
        let path = datafilePath()
        if let data = try? Data(contentsOf: path){
            let decoder = PropertyListDecoder()
            do {
                return try decoder.decode(WeatherModel.self, from: data)
            } catch {
                print("Error decoding!")
            }
        }
        return nil
    }
}
