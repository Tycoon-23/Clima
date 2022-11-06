//
//  WeatherManager.swift
//  Clima
//
//  Created by ヴィヤヴャハレ・アディティア on 06/11/22.
//

import Foundation

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=5c0ef39b860cb549477270dd3147ad0f&units=metric" //Actual link ('q' is city name) fr fetching data frm openWeather server
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        //print(urlString)
        performRequest(urlString: urlString)
    }
    
    func performRequest(urlString: String) {
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
                    print(error!)
                    return //exit out of this function; don't continue
                }
                
                //if no errors
                if let safeData = data {
                    parseJSON(weatherData: safeData)
                }
            }
            
            //4. Sart the task
            task.resume()
        }
    }
    
    func parseJSON(weatherData: Data) {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            print(decodedData.main.temp)
            print(decodedData.weather[0].description)
        } catch {
            print(error)
        }
    }
}
