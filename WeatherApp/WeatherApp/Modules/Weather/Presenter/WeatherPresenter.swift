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
    var wertherByDay = [String: [WeatherModel]]()
    var weatherDays = [String]()
    var searchLocation: String = "London, UK"

    lazy var dateFormatterDay: DateFormatter = {
        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM"
        return dateFormatter
    }()

    func viewIsReady() {
        refreshResults()
    }

    func refreshResults() {
        view.startActivityIndicator()
        clearResults()
        interactor.fetchWeather(for: searchLocation)
    }

    func clearResults() {
        wertherByDay = [String: [WeatherModel]]()
        weatherDays = [String]()
    }

    func weather(_ weatherList: [WeatherModel]?) {
        guard let weatherList = weatherList else {
            return
        }
        let dates = NSMutableOrderedSet()

        weatherList.forEach {
            let day = dateFormatterDay.string(from: $0.date)
            dates.add(day)
            if let array = wertherByDay[day] {
                var newArray = array
                newArray.append($0)
                wertherByDay[day] = newArray
            } else {
                wertherByDay[day] = [$0]
            }
        }

        weatherDays = Array(dates) as! [String]

        DispatchQueue.main.async {
            self.view.stopActivityIndicator()
            self.view.reload()
        }
    }

    func fail(with error: Error) {
        DispatchQueue.main.async {
            self.view.stopActivityIndicator()
            self.view.show(error: error as NSError)
        }
    }

    func numberOfSections() -> Int {
        return weatherDays.count
    }

    func numberOfItems(in section: Int) -> Int {
        let key = weatherDays[section]
        guard let count = wertherByDay[key]?.count else {
            return 0
        }
        return count
    }

    func titleForHeader(in section: Int) -> String {
        let key = weatherDays[section]
        return key
    }

    func navigationTitle() -> String {
        return searchLocation
    }

    func dataForCell(in section: Int, row: Int) -> WeatherModel {
        let key = weatherDays[section]
        guard let items = wertherByDay[key] else {
            fatalError()
        }
        return items[row]
    }
}
