//
//  WeatherWeatherInteractorInput.swift
//  WeatherApp
//
//  Created by Dmytro Golub 
//  
//

import Foundation

protocol WeatherInteractorInput {
    func fetchWeather(for city: String)
}
