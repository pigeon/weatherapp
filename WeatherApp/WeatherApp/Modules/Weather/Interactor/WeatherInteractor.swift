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
    let tepmerature: String
}

class WeatherInteractor: WeatherInteractorInput {
    weak var output: WeatherInteractorOutput!

    let weatherService: WeatherService

    lazy var temperatureFormatter:NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .none
        formatter.roundingMode = .halfUp
        return formatter
    }()
    
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
                WeatherModel(title: result.city!.name!, date: Date(timeIntervalSince1970: Double($0.dt!)), tepmerature: temperatureFormatter.string(from: NSNumber(value: ($0.main?.temp)!))! )
        }
        output.weather(weatherList)
    }

/*
     
     - (NSString *)temperature:(NSNumber *)temperature
     {
     float f = [temperature floatValue];
     if (f < 0 && f > -0.5)
     temperature = [NSNumber numberWithLong:lround(f)];
     
     return [self.temperatureFormatter stringFromNumber:temperature];
     }
     
*/

    
    func fail(with _: Error) {
    }
}
