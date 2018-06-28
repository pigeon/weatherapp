//
//  WeatherWeatherPresenter.swift
//  WeatherApp
//
//  Created by Dmytro Golub on 28/06/2018.
//  Copyright © 2018 dmytro golub. All rights reserved.
//

import Foundation

class WeatherPresenter: WeatherModuleInput, WeatherViewOutput, WeatherInteractorOutput {
    weak var view: WeatherViewInput!
    var interactor: WeatherInteractorInput!
    var router: WeatherRouterInput!
    var wertherByDay = [String: [WeatherModel]]()

    lazy var dateFormatterTo: DateFormatter = {
        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter
    }()

    lazy var dateFormatterDay: DateFormatter = {
        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy" // 28/06/2018 9:00
        return dateFormatter
    }()

    func viewIsReady() {
        interactor.fetchWeather(for: "London,UK")
    }

    func weather(_ weatherList: [WeatherModel]?) {
        guard let weatherList = weatherList else {
            return
        }

        weatherList.forEach {
            let day = dateFormatterDay.string(from: $0.date)
            if let array = wertherByDay[day] {
                var newArray = array
                newArray.append($0)
                wertherByDay[day] = newArray
            } else {
                wertherByDay[day] = [$0]
            }
        }

        DispatchQueue.main.async {
            self.view.reload()
        }
    }
}
