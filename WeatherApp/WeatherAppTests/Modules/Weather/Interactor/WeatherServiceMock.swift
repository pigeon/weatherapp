//
//  WeatherServiceMock.swift
//  WeatherApp
//
//  Created by Dmytro Golub on 28/06/2018.
//  Copyright © 2018 dmytro golub. All rights reserved.
//

import Foundation
@testable import WeatherApp

class WeatherServiceMock: WeatherService {
    let jsonData: Data

    func weather(for _: String, completionBlock: @escaping WeatherServiceCompletion) {
        let jsonDecoder = JSONDecoder()
        do {
            let responseModel = try jsonDecoder.decode(WeatherObject.self, from: jsonData)
            completionBlock(.success(responseModel))
        } catch {
            completionBlock(.failure(error))
        }
    }

    init() {
        let url = Bundle.main.url(forResource: "response", withExtension: "json")!
        jsonData = try! Data(contentsOf: url)
    }
}
