//
//  WeatherWeatherViewController.swift
//  WeatherApp
//
//  Created by Dmytro Golub on 28/06/2018.
//  Copyright © 2018 dmytro golub. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController, WeatherViewInput {

    var output: WeatherViewOutput!

    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
    }


    // MARK: WeatherViewInput
    func setupInitialState() {
    }
}
