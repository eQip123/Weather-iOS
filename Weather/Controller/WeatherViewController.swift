//
//  ViewController.swift
//  Weather
//
//  Created by Aidar Asanakunov on 2/8/22.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController{
    
    
    var weatherManage = WeatherManage()
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var conditionImage: UIImageView!
    
    @IBOutlet weak var temperateLabel: UILabel!
    
    @IBOutlet weak var cityLabel: UILabel!
    
    
    @IBOutlet weak var searchTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        weatherManage.delegate = self
        searchTextField.delegate = self
        
    }
    
    @IBAction func locationButtonPressed(_ sender: UIButton) {
        locationManager.requestLocation()
    }
    
}
extension WeatherViewController: UITextFieldDelegate {
    @IBAction func searchPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
        print(searchTextField.text!)
    }
    //MARK: Отвечает за то, чтобы в клавиатуре можно было перейти по кнопке
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true) // Убирает клавиатуру, после нажатия кнопки в клаве
        print(searchTextField.text!)
        return true
    }
    //MARK: Этот метод позволяет делать какие-то проверки, что ввел пользователь
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Введите что-нибудь"
            return false
        }
    }
    //MARK: Этот метод что-то делает после завершениыя редактирования
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let searchCity = searchTextField.text {
            weatherManage.fetchWeather(cityName: searchCity)
        }
        searchTextField.text = ""
    }
}


extension WeatherViewController: WeatherManageDelegate {
    
    func didUpdateWeather(weatherManage: WeatherManage, weatherModel: WeatherModel) {
        DispatchQueue.main.async {
            self.conditionImage.image = UIImage(systemName: weatherModel.conditionName)
            self.temperateLabel.text = weatherModel.temperatureString
            self.cityLabel.text = weatherModel.cityName
            
        }
    }
    func didFailWithError(error: Error) {
        print(error)
    }
    
    
}
extension WeatherViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lot = location.coordinate.longitude
            weatherManage.fetchWeather(latitude: lat, longitute: lot)
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
