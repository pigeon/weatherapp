//
//  WeatherWeatherConfigurator.swift
//  WeatherApp
//
//  Created by Dmytro Golub on 28/06/2018.
//  Copyright © 2018 dmytro golub. All rights reserved.
//

import UIKit

class WeatherModuleConfigurator {
    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {
        if let viewController = viewInput as? WeatherViewController {
            configure(viewController: viewController)
        }
    }

    private func configure(viewController: WeatherViewController) {
        let presenter = WeatherPresenter()
        presenter.view = viewController

        let interactor = WeatherInteractor()
        interactor.output = presenter

        presenter.interactor = interactor
        viewController.output = presenter
    }
}
