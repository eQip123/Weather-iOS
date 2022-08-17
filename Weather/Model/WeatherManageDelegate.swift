//
//  WeatherManageDelegate.swift
//  Weather
//
//  Created by Aidar Asanakunov on 4/8/22.
//

import Foundation
protocol WeatherManageDelegate {
    func didUpdateWeather(weatherManage: WeatherManage, weatherModel: WeatherModel)
    func didFailWithError(error: Error)
}
