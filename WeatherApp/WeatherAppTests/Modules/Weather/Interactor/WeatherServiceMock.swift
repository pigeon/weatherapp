//
//  WeatherServiceMock.swift
//  WeatherApp
//
//  Created by Dmytro Golub 
//  
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
        let bundle = Bundle(for: WeatherServiceMock.self)
        let url = bundle.url(forResource: "response", withExtension: "json")!
        jsonData = try! Data(contentsOf: url)
    }
}
