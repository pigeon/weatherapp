//
//  WeatherWeatherInitializer.swift
//  WeatherApp
//
//  Created by Dmytro Golub 
//  
//

import UIKit

class WeatherModuleInitializer: NSObject {
    // Connect with object on storyboard
    @IBOutlet var weatherViewController: WeatherViewController!

    override func awakeFromNib() {
        let configurator = WeatherModuleConfigurator()
        configurator.configureModuleForViewInput(viewInput: weatherViewController)
    }
}
