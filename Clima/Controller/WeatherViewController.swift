//
//  ViewController.swift
//  Clima
//
//  Created by Aditya Virbhadra Vyavahare on 05/11/22.
//

import UIKit

class WeatherViewController: UIViewController {
    
    
    var weatherManager = WeatherManager()
    
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTextField.delegate = self //initialize the search bar
        weatherManager.delegate = self  //set the current class as delegate
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
