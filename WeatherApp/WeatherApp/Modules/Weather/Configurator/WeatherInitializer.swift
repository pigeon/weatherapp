//
//  WeatherWeatherInitializer.swift
//  WeatherApp
//
//  Created by Dmytro Golub on 28/06/2018.
//  Copyright © 2018 dmytro golub. All rights reserved.
//

import UIKit

class WeatherModuleInitializer: NSObject {

    //Connect with object on storyboard
    @IBOutlet weak var weatherViewController: WeatherViewController!

    override func awakeFromNib() {

        let configurator = WeatherModuleConfigurator()
        configurator.configureModuleForViewInput(viewInput: weatherViewController)
    }

}
