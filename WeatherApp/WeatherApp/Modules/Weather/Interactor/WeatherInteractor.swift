//
//  WeatherWeatherInteractor.swift
//  WeatherApp
//
//  Created by Dmytro Golub on 28/06/2018.
//  Copyright © 2018 dmytro golub. All rights reserved.
//

import Foundation

struct WeatherModel {
    let title: String
    let date: Date
    let tepmerature: Double
}

class WeatherInteractor: WeatherInteractorInput {
    weak var output: WeatherInteractorOutput!

    let weatherService: WeatherService

    init(service: WeatherService = WeatherServiceMock()) {
        weatherService = service
    }

    func fetchWeather(for city: String) {
        weatherService.weather(for: city) { [weak self] result in

            switch result {
            case let .success(data):
                self?.populateProductModels(with: data)
            case let .failure(error):
                self?.fail(with: error)
            }
        }
    }

    func populateProductModels(with result: WeatherObject) {
        let weatherList = result.list?.map {
            WeatherModel(title: result.city!.name!, date: Date(timeIntervalSince1970: Double($0.dt!)), tepmerature: ($0.main?.temp)!)
        }
        output.weather(weatherList)
    }

    func fail(with _: Error) {
    }
}
