//
//  ViewController.swift
//  WeatherApp
//
//  Created by Наталия Семичева on 8/11/18.
//  Copyright © 2018 Наталия Семичева. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let jsonPath = Bundle.main.path(forResource: "response", ofType: "json")
        let jsonData = try! Data(contentsOf: URL(fileURLWithPath: jsonPath!))
        let decoder = JSONDecoder()
        do {
            let weather = try decoder.decode(WeatherModel.self, from: jsonData)
            let loader = CacheLoader()
            loader.saveData(data: weather)
            label.text = weather.city.name
        }
        catch {
            label.text = "error"
        }
        let m = NetworkLoader()
        m.loadData(successBlock: { [unowned self] model in
            DispatchQueue.main.async {
                self.label.text = model.city.name
            }
        }) { (error) in
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

