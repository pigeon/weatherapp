//
//  WeatherWeatherViewOutput.swift
//  WeatherApp
//
//  Created by Dmytro Golub 
//  
//

protocol WeatherViewOutput {
    /**
     @author Dmytro Golub
     Notify presenter that view is ready
     */

    func viewIsReady()
    func refreshResults()
    // model data source
    func numberOfSections() -> Int
    func numberOfItems(in section: Int) -> Int
    func dataForCell(in section: Int, row: Int) -> WeatherModel
    // titles
    func titleForHeader(in section: Int) -> String
    func navigationTitle() -> String
}
