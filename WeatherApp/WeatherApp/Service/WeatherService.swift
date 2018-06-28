//
//  WeatherService.swift
//  WeatherApp
//
//  Created by Dmytro Golub on 28/06/2018.
//  Copyright © 2018 dmytro golub. All rights reserved.
//

import Foundation

enum Result<Value, Error> {
    case success(Value)
    case failure(Error)
}

typealias WeatherServiceCompletion = (Result<WeatherObject, Error>) -> Void

protocol WeatherService {
    func weather(for city: String, completionBlock: @escaping WeatherServiceCompletion)
}
