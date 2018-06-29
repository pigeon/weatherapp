//
//  WeatherWeatherInteractorOutput.swift
//  WeatherApp
//
//  Created by Dmytro Golub on 28/06/2018.
//  Copyright © 2018 dmytro golub. All rights reserved.
//

import Foundation

protocol WeatherInteractorOutput: class {
    func weather(_: [WeatherModel]?)
    func fail(with error: Error)
}
