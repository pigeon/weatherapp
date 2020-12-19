//
//  WeatherWeatherConfiguratorTests.swift
//  WeatherApp
//
//  Created by Dmytro Golub 
//  
//

@testable import WeatherApp
import XCTest

class WeatherModuleConfiguratorTests: XCTestCase {
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testConfigureModuleForViewController() {
        // given
        let viewController = WeatherViewControllerMock()
        let configurator = WeatherModuleConfigurator()

        // when
        configurator.configureModuleForViewInput(viewInput: viewController)

        //then
        XCTAssertNotNil(viewController.output, "WeatherViewController is nil after configuration")
        XCTAssertTrue(viewController.output is WeatherPresenter, "output is not WeatherPresenter")

        let presenter: WeatherPresenter = viewController.output as! WeatherPresenter
        XCTAssertNotNil(presenter.view, "view in WeatherPresenter is nil after configuration")

        let interactor: WeatherInteractor = presenter.interactor as! WeatherInteractor
        XCTAssertNotNil(interactor.output, "output in WeatherInteractor is nil after configuration")
    }

    class WeatherViewControllerMock: WeatherViewController {
        var setupInitialStateDidCall = false

        override func setupInitialState() {
            setupInitialStateDidCall = true
        }
    }
}
