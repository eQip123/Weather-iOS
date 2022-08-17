//
//  WeatherData.swift
//  Weather
//
//  Created by Aidar Asanakunov on 4/8/22.
//

import Foundation

struct Coordinate: Decodable {
    var lon: Double
    var lat: Double
}
struct WeatherData: Decodable {
    var name: String
    var main: Main
    var weather: [WeatherDescription]
}
struct Main: Decodable {
    var temp: Double
}
struct WeatherDescription: Decodable {
    var id: Int
    var description: String
}

