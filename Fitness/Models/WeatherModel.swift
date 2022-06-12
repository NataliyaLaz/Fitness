//
//  WeatherModel.swift
//  Fitness
//
//  Created by Nataliya Lazouskaya on 11.06.22.
//

import Foundation

struct WeatherModel: Decodable {
    let main: Main
    let weather: [Weather]
}

struct Main: Decodable {
    let temp: Double
    
    var temperatureInt: Int {
        return(Int(temp))
    }
}

struct Weather: Decodable {
    let icon: String?
    
    var iconDescription: String {
        switch icon {
        case "01d": return "Clear sky"
        case "02d": return "Few clouds"
        case "03d": return "Scattered clouds"
        case "04d": return "Broken clouds"
        case "09d": return "Shower rain"
        case "10d": return "Rain"
        case "11d": return "Thunderstorm"
        case "13d": return "Snow"
        case "50d": return "Mist"
        case "01n": return "Clear sky"
        case "02n": return "Few clouds"
        case "03n": return "Scattered clouds"
        case "04n": return "Broken clouds"
        case "09n": return "Shower rain"
        case "10n": return "Rain"
        case "11n": return "Thunderstorm"
        case "13n": return "Snow"
        case "50n": return "Mist"
        default:  return "Strange Weather"
        }
    }
    
    var iconAdvice: String {
        switch icon {
        case "01d": return "The best time to have training outdoors. Finish your day with running"
        case "02d": return "Good time to have training outdoors. Finish your day with running"
        case "03d": return "Train outdoors or in gym. Up to you!"
        case "04d": return "Good time to visit gym!"
        case "09d": return "Not a good idea to train outdoors. Visit gym!"
        case "10d": return "Right time to visit gym or play games indoors"
        case "11d": return "the best time to visit gym or play games indoors"
        case "13d": return "You can play snowballs or visit gym"
        case "50d": return "Running can be fun!"
        case "01n": return "Train outdoors... or sleep"
        case "02n": return "Train outdoors... or just sleep"
        case "03n": return "Light training ... or just sleep"
        case "04n": return "Some gymnastic ... or just sleep"
        case "09n": return "Some gymnastic, relax ... or just sleep"
        case "10n": return "Some gymnastic, relax ... or just sleep"
        case "11n": return "Some gymnastic, stretching ... or just sleep"
        case "13n": return "Why not to go to sleep?"
        case "50n": return "Some easy training or... sleep!"
        default:  return "Strange Weather"
        }
    }
}


