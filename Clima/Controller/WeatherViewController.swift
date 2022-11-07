//
//  ViewController.swift
//  Clima
//
//  Created by Aditya Virbhadra Vyavahare on 05/11/22.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {
    
    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.requestWhenInUseAuthorization()    //user permission for location access
        locationManager.delegate = self
        locationManager.requestLocation()   //requests one-time delivery of users current location; in case of navigation/fitness app where location is to be continully tracked, use startUpdatingLocation()

        searchTextField.delegate = self //initialize the search bar
        weatherManager.delegate = self  //set the current class as delegate
    }
    
    
    @IBAction func getLocationPressed(_ sender: UIButton) {
        locationManager.requestLocation()
    }
}

//MARK: - UITextFieldDelegate

extension WeatherViewController: UITextFieldDelegate {
    @IBAction func searchPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
        //print(searchTextField.text!)    //fetch text data from search bar
    }
    
    //asks the delegate whether to process the return command given by user via the keyboard
    func textFieldShouldReturn(_ textField: UITextField)  -> Bool {
        searchTextField.endEditing(true)
        //print(searchTextField.text!)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if searchTextField.text != "" {
            searchTextField.placeholder = "Search"  //reset placeholder to 'Search'
            return true
        } else {
            searchTextField.placeholder = "Type city name here" //modify placeholder if user did not enter any name
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        //use user I/P to fetch weather data.
        if let city = searchTextField.text {
            weatherManager.fetchWeather(cityName: city)
        }
    }
}

//MARK: - WeatherManagerDelegate

extension WeatherViewController: WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        DispatchQueue.main.async {
            self.temperatureLabel.text = weather.temperatureString
            self.conditionImageView.image = UIImage(systemName: weather.conditionName)
            self.cityLabel.text = weather.cityName
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}

//MARK: - CLLocationManagerDelegate

extension WeatherViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {      //get the last location from the array of locations, last is used to get the most accurate one
            locationManager.stopUpdatingLocation()  //Stop the process of getting location once the data is fetched
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            
            weatherManager.fetchWeather(lat: lat, lon: lon)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
