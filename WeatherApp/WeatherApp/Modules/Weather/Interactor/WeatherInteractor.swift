//
//  WeatherWeatherInteractor.swift
//  WeatherApp
//
//  Created by Dmytro Golub 
//  
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

    lazy var dateFormatterTime: DateFormatter = {
        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter
    }()

    init(service: WeatherService = WeatherServiceImpl()) {
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
        let weatherList = result.list?.compactMap {
            createWeatherModel(title: result.city?.name,
                               date: $0.dt,
                               tepmerature: $0.main?.temp)
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
        return dateFormatterTime.string(from: time)
    }

    func fail(with error: Error) {
        output.fail(with: error)
    }
}

extension WeatherInteractor {
    func createWeatherModel(title t: String?, date d: Int?, tepmerature temp: Double?) -> WeatherModel? {
        guard let t = t,
            let d = d,
            let temp = temp else {
            return nil
        }
        return WeatherModel(title: t,
                            date: Date(timeIntervalSince1970: Double(d)),
                            time: format(time: Date(timeIntervalSince1970: Double(d))),
                            tepmerature: format(temperature: temp))
    }
}
