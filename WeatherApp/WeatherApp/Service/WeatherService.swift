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

class WeatherServiceImpl: WeatherService {
    private let session = URLSession(configuration: URLSessionConfiguration.default)
    private let host = "https://api.openweathermap.org/data/2.5/forecast"
    let key: String

    init(apiKey: String = "fc7b05685865f015f42102ea620a8611") {
        key = apiKey
    }

    func weather(for city: String, completionBlock: @escaping WeatherServiceCompletion) {
        guard let city = city.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed),
            let url = URL(string: host + "?APPID=\(key)&units=metric&q=\(city)") else {
            completionBlock(.failure(NSError(domain: "Bad URL", code: Int.max - 1, userInfo: [NSLocalizedDescriptionKey: "Service URL is invalid"])))
            return
        }

        let request = URLRequest(url: url)

        let task = session.dataTask(with: request) { data, response, error in

            if error == nil,
                let data = data,
                let response = response as? HTTPURLResponse,
                response.statusCode == 200 {
                do {
                    let jsonDecoder = JSONDecoder()
                    let responseModel = try jsonDecoder.decode(WeatherObject.self, from: data)
                    completionBlock(.success(responseModel))
                } catch {
                    completionBlock(.failure(error))
                }
            } else {
                completionBlock(.failure(NSError(domain: "Bad URL", code: Int.max - 1, userInfo: [NSLocalizedDescriptionKey: "Service request error"]))) }
        }

        task.resume()
    }
}
