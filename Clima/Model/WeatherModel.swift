//
//  WeatherModel.swift
//  Clima
//
//  Created by ヴィヤヴャハレ・アディティア on 06/11/22.
//

import Foundation

struct WeatherModel {
    let conditionId: Int
    let temperature: Double
    let cityName: String
    
    //use of computed property
    var conditionName: String {
        switch conditionId {
        case 200...232:
            return "cloud.bolt"
        case 300...500:
            return"cloud.drizzle"
        case 501:
            return "cloud.rain"
        case 502...503:
            return "cloud.heavyrain"
        case 504:
            return "cloud.bolt.rain"
        case 511:
            return "cloud.sleet"
        case 520...531:
            return "cloud.rain"
        case 600...622:
            return "snowflake"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.sun.bolt"
        default:
            return "cloud"
        }
    }
    
    var temperatureString: String {
        let tempString = String(format: "%.1f", temperature)
        return tempString
    }
}
