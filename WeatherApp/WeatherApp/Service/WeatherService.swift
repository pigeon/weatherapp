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


class WeatherServiceImpl : WeatherService {
    
    private let session = URLSession(configuration: URLSessionConfiguration.default)
    private let host = "https://api.openweathermap.org/data/2.5/forecast"
    let key:String
    
    init(apiKey:String="") {
        key = apiKey
    }
    
    func weather(for city: String, completionBlock: @escaping WeatherServiceCompletion) {
        
        let strURL = host + "?APPID=\(key)&units=metric&q=\(String(describing: city.addingPercentEncoding(withAllowedCharacters:.urlHostAllowed)))"
        
        let url = URL(string: strURL)
        var request = URLRequest(url: url!)

        
        //request.encodeParameters(parameters: createRequestBody())
        
        let task = session.dataTask(with: request) {  (data, response, error) in
            
            if  error == nil,
                let data = data,
                let response = response as? HTTPURLResponse,
                response.statusCode = 200 {
                
                //    completionBlock(.success(responseModel))
            } else {
                //completion(nil,error! as NSError)
                //self.service(error: error as NSError?, completion: AuthorisationAction(completion: completion))
            }
        }
        
        task.resume()
    }
    
    
}
