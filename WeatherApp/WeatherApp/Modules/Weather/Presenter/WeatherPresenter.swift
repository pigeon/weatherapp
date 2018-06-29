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
    var dataSource = [[String: [WeatherModel]]]()

    lazy var dateFormatterDay: DateFormatter = {
        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM" // 28/06/2018 9:00
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

        wertherByDay.forEach {
            dataSource.append([$0: $1])
        }

        DispatchQueue.main.async {
            self.view.reload()
        }
    }

    func numberOfSections() -> Int {
        return dataSource.count
    }

    func numberOfItems(in section: Int) -> Int {
        guard let items = dataSource[section].first else {
            return 0
        }
        return items.value.count
    }

    func titleForHeader(in section: Int) -> String {
        guard let items = dataSource[section].first else {
            return ""
        }
        return items.key
    }

    func dataForCell(in section: Int, row: Int) -> WeatherModel {
        guard let items = dataSource[section].first else {
            fatalError()
        }
        return items.value[row]
    }
}
