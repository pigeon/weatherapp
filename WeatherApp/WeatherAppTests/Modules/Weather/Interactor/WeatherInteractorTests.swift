//
//  WeatherWeatherInteractorTests.swift
//  WeatherApp
//
//  Created by Dmytro Golub on 28/06/2018.
//  Copyright © 2018 dmytro golub. All rights reserved.
//

@testable import WeatherApp
import XCTest

class WeatherInteractorTests: XCTestCase {
    let mockService = WeatherServiceMock()

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testWeatherFetcher() {
        let iteractor = WeatherInteractor(service: mockService)
        let presenter = MockPresenter()
        iteractor.output = presenter
        iteractor.fetchWeather(for: "London")
        XCTAssertTrue(presenter.weatherGetCalled, "weather callback should be called")
    }

    func testWeatherFetcherFailure() {
        let iteractor = WeatherInteractor(service: mockService)
        let presenter = MockPresenter()
        iteractor.output = presenter
        let error = NSError(domain: "", code: 0, userInfo: [:])
        iteractor.fail(with: error)
        XCTAssertTrue(presenter.error == error, "error is not as expected")
    }

    class MockPresenter: WeatherInteractorOutput {
        var weatherGetCalled = false
        var error: NSError?

        func weather(_: [WeatherModel]?) {
            weatherGetCalled = true
        }

        func fail(with err: Error) {
            error = err as NSError
        }
    }
}
