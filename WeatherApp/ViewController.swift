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

class ViewController: UIViewController, CLLocationManagerDelegate, UITableViewDataSource, UITableViewDelegate {
    
    var weatherItems = [WeatherItem]()
    
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var weatherTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weatherTableView.delegate = self
        weatherTableView.dataSource = self
        
        let jsonPath = Bundle.main.path(forResource: "response", ofType: "json")
        let jsonData = try! Data(contentsOf: URL(fileURLWithPath: jsonPath!))
        let decoder = JSONDecoder()
        do {
            let weather = try decoder.decode(WeatherModel.self, from: jsonData)
            let loader = CacheLoader()
            loader.saveData(data: weather)
            showWeather(weatherModel: weather)
        }
        catch {
            cityLabel.text = "error"
        }
        let m = NetworkLoader()
        m.loadData(successBlock: { [unowned self] model in
            DispatchQueue.main.async {
                self.weatherItems = model.list
                self.showWeather(weatherModel: model)
                self.weatherTableView.reloadData()
            }
        }) { (error) in
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func showWeather(weatherModel model: WeatherModel) {
        cityLabel.text = model.city.name
        weatherLabel.text = "\(model.list[0].weather[0].description) \(model.list[0].degree.celcius())"
        weatherImage.image = ImageService.getImage(weatherDescription: model.list[0].weather[0].description)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherItem") ?? UITableViewCell(style: .subtitle, reuseIdentifier: "WeatherItem")
        let weatherItem = self.weatherItems[indexPath.row]
        cell.textLabel?.text = weatherItem.weather[0].description
        cell.detailTextLabel?.text = weatherItem.degree.celcius()
        
        return cell
    }
}

