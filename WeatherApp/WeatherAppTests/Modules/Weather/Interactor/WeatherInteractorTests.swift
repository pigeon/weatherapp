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

    class MockPresenter: WeatherInteractorOutput {
        func weather(_: [WeatherModel]?) {
        }

        func fail(with _: Error) {
        }
    }
}
