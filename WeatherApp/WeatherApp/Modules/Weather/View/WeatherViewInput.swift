//
//  WeatherWeatherViewInput.swift
//  WeatherApp
//
//  Created by Dmytro Golub on 28/06/2018.
//  Copyright © 2018 dmytro golub. All rights reserved.
//

protocol WeatherViewInput: class {
    /**
     @author Dmytro Golub
     Setup initial state of the view
     */

    func setupInitialState()
    func reload()
}
