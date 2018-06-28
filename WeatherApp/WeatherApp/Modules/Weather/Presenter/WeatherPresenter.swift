//
//  WeatherWeatherPresenter.swift
//  WeatherApp
//
//  Created by Dmytro Golub on 28/06/2018.
//  Copyright © 2018 dmytro golub. All rights reserved.
//

class WeatherPresenter: WeatherModuleInput, WeatherViewOutput, WeatherInteractorOutput {

    weak var view: WeatherViewInput!
    var interactor: WeatherInteractorInput!
    var router: WeatherRouterInput!

    func viewIsReady() {

    }
}
