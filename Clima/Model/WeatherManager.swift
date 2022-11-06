//
//  WeatherManager.swift
//  Clima
//
//  Created by ヴィヤヴャハレ・アディティア on 06/11/22.
//

import Foundation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=5c0ef39b860cb549477270dd3147ad0f&units=metric" //Actual link ('q' is city name) fr fetching data frm openWeather server
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        //print(urlString)
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        /*4-step networking process
         1. Create a URL
         2. Create a URL session
         3. Give the session a task
         4. Start the task */
        
        //1. Create a URL
        if let url = URL(string: urlString) {
            
            //2. Create a URl session
            let session = URLSession(configuration: .default)
            
            //3. Give the sessiona task         Closure is used (anonymous function)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return //exit out of this function; don't continue
                }
                
                //if no errors
                if let safeData = data {
                    if let weather = self.parseJSON(safeData) {
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }
            
            //4. Sart the task
            task.resume()
        }
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            
            let weather = WeatherModel(conditionId: id, temperature: temp, cityName: name)
            return weather
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
