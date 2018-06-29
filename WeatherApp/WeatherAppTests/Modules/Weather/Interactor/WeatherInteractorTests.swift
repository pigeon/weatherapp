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
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    class MockPresenter: WeatherInteractorOutput {
        func weather(_: [WeatherModel]?) {
        }

        func fail(with _: Error) {
        }
    }
}
