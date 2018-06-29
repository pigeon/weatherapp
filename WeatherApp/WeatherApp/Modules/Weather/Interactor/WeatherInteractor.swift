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
    let time: String
    let tepmerature: String
}

class WeatherInteractor: WeatherInteractorInput {
    weak var output: WeatherInteractorOutput!

    let weatherService: WeatherService

    lazy var temperatureFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .none
        formatter.roundingMode = .halfUp
        return formatter
    }()

    lazy var dateFormatterTo: DateFormatter = {
        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter
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
            WeatherModel(title: result.city!.name!,
                         date: Date(timeIntervalSince1970: Double($0.dt!)),
                         time: format(time: Date(timeIntervalSince1970: Double($0.dt!))),
                         tepmerature: format(temperature: $0.main?.temp))
        }
        output.weather(weatherList)
    }

    func format(temperature: Double?) -> String {
        guard let temperature = temperature else {
            return ""
        }
        let number = NSNumber(value: temperature)
        guard let str = temperatureFormatter.string(from: number) else {
            return ""
        }
        return "\(str)℃"
    }

    func format(time: Date?) -> String {
        guard let time = time else {
            return ""
        }
        return dateFormatterTo.string(from: time)
    }

    func fail(with _: Error) {
    }
}
