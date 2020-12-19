//
//  WeatherWeatherViewInput.swift
//  WeatherApp
//
//  Created by Dmytro Golub 
//  
//

import Foundation

protocol WeatherViewInput: class {
    /**
     @author Dmytro Golub
     Setup initial state of the view
     */

    func setupInitialState()
    func reload()
    func show(error: NSError)

    func startActivityIndicator()
    func stopActivityIndicator()
}
