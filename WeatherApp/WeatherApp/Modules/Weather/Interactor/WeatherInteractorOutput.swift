//
//  WeatherWeatherInteractorOutput.swift
//  WeatherApp
//
//  Created by Dmytro Golub 
//  
//

import Foundation

protocol WeatherInteractorOutput: class {
    func weather(_: [WeatherModel]?)
    func fail(with error: Error)
}
