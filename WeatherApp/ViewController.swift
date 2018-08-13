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

class ViewController: UIViewController, CLLocationManagerDelegate, UITableViewDelegate, UITableViewDataSource {
    
    var weatherItems = [WeatherItem]()
    let cacheLoader = CacheLoader()
    
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var weatherTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weatherTableView.delegate = self
        weatherTableView.dataSource = self
        let cellXib = UINib.init(nibName: "WeatherItemCellTableViewCell", bundle: nil)
        weatherTableView.register(cellXib, forCellReuseIdentifier: "WeatherItem")
        
        guard let weather = cacheLoader.loadData() else {
            updateData()
            return
        }
        showWeather(weatherModel: weather)
        weatherItems = weather.list
        weatherTableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func updateData(){
        let networkLoader = NetworkLoader()
        networkLoader.loadData(successBlock: { [unowned self] model in
            DispatchQueue.main.async {
                self.weatherItems = model.list
                self.showWeather(weatherModel: model)
                self.weatherTableView.reloadData()
                self.cacheLoader.saveData(data: model)
            }
        }) { (error) in
            let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherItem") as! WeatherItemCellTableViewCell
        cell.layer.borderColor = UIColor.init(red: 148/255, green: 82/255, blue: 81/255, alpha: 1.0).cgColor
        cell.layer.borderWidth = 0.3
        cell.backgroundColor = UIColor.init(white: 0, alpha: 0)

        let weatherItem = self.weatherItems[indexPath.row]
        cell.dateLabel?.text = weatherItem.convertStringToDate()
        cell.degreeLabel?.text = weatherItem.degree.celcius()
        cell.weatherImage?.image = ImageService.getImage(weatherDescription: weatherItem.weather[0].description)
        return cell
    }
}

