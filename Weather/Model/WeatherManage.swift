//
//  WeatherManage.swift
//  Weather
//
//  Created by Aidar Asanakunov on 4/8/22.
//

import Foundation
import CoreLocation
struct WeatherManage {
    
    var delegate: WeatherManageDelegate?
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=268db0357186f5a389b6a8330f5fe5e0&units=metric"
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(with: urlString )
        print(urlString)
    }
    func fetchWeather(latitude: CLLocationDegrees, longitute: CLLocationDegrees) {
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitute)"
        performRequest(with: urlString )
        print(urlString)
    }
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let urlSession = URLSession(configuration: .default)
            urlSession.dataTask(with: url) { data, response, error in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let weather = parseJson(weatherData: safeData) {
                        self.delegate?.didUpdateWeather(weatherManage: self, weatherModel: weather)
                    }
                }
            }.resume()
        }
    }
}
func parseJson(weatherData: Data)  -> WeatherModel? {
    let jsonDecoder = JSONDecoder()
    do {
        let decoder = try jsonDecoder.decode(WeatherData.self, from: weatherData)
        let id = decoder.weather[0].id
        let temp = decoder.main.temp
        let name = decoder.name
        let weatherModel = WeatherModel(conditionId: id, cityName: name, temperature: temp)
        print(weatherModel.temperatureString)
        print(weatherModel.conditionName)
        return weatherModel
        
    } catch {
        print("error")
        return nil
    }
}




