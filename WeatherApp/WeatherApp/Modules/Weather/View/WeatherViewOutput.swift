//
//  WeatherWeatherViewOutput.swift
//  WeatherApp
//
//  Created by Dmytro Golub on 28/06/2018.
//  Copyright © 2018 dmytro golub. All rights reserved.
//

protocol WeatherViewOutput {
    /**
     @author Dmytro Golub
     Notify presenter that view is ready
     */

    func viewIsReady()
    func numberOfSections() -> Int
    func numberOfItems(in section: Int) -> Int
    func titleForHeader(in section:Int) -> String
}
