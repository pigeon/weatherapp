//
//  WeatherWeatherConfigurator.swift
//  WeatherApp
//
//  Created by Dmytro Golub 
//  
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
