//
//  WeatherModel.swift
//  TodaysWeather
//
//  Created by 밀가루 on 5/29/24.
//

import Foundation

struct WeatherResponse: Codable {
    let list: [WeatherForecast]
}

struct WeatherForecast: Codable {
    let dt: Int
    let main: Main
    let weather: [Weather]
    let clouds: Clouds
    let wind: Wind
    let visibility: Int
    let pop: Double
    let sys: Sys
    let dt_txt: String
}

struct Main: Codable {
    let temp: Double
    let feels_like: Double
    let temp_min: Double
    let temp_max: Double
    let pressure: Int
    let sea_level: Int
    let grnd_level: Int
    let humidity: Int
    let temp_kf: Double
}

struct Weather: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct Clouds: Codable {
    let all: Int
}

struct Wind: Codable {
    let speed: Double
    let deg: Int
    let gust: Double
}

struct Sys: Codable {
    let pod: String
}
