//
//  WeatherWeatherPresenterTests.swift
//  WeatherApp
//
//  Created by Dmytro Golub on 28/06/2018.
//  Copyright © 2018 dmytro golub. All rights reserved.
//

@testable import WeatherApp
import XCTest

class WeatherPresenterTest: XCTestCase {
    let presenter = WeatherPresenter()
    let view = MockViewController()

    override func setUp() {
        super.setUp()
        view.reset()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testDateFormat() {
        let date0 = Date(timeIntervalSince1970: 1_530_198_000) // "Jun 28, 2018 at 4:00 PM"
        let date1 = Date(timeIntervalSince1970: 1_530_208_800) // "Jun 28, 2018 at 7:00 PM"
        let date2 = Date(timeIntervalSince1970: 1_530_241_200) // "Jun 29, 2018 at 4:00 AM"

        XCTAssertTrue(presenter.dateFormatterDay.string(from: date0) == "28 Jun", "Date is not formatted correctly")
        XCTAssertTrue(presenter.dateFormatterDay.string(from: date1) == "28 Jun", "Date is not formatted correctly")
        XCTAssertFalse(presenter.dateFormatterDay.string(from: date2) == "28 Jun", "Date is not formatted correctly")
    }

    func testViewIsReady() {
        let interactor = MockInteractor()
        presenter.interactor = interactor
        presenter.view = view
        presenter.viewIsReady()
        XCTAssertTrue(interactor.weatherFetcherCalled, "Weather has to be fetched")
        XCTAssertTrue(view.startActivityCalled,"Activity indicator should have been started")
    }

    func testFail() {
        let expectation = self.expectation(description: "fail expectation")
        view.expectation = expectation
        presenter.view = view
        presenter.fail(with: NSError(domain: "", code: Int.max - 1, userInfo: [:]))
        waitForExpectations(timeout: 0.5, handler: nil)
        XCTAssertTrue(view.showErrorCalled, "showError should get called")
        XCTAssertTrue(view.stopActivityCalled,"Activity indicator should have been stopped")
    }

    func testWeatherResultsEmpty() {
        let view = MockViewController()
        presenter.view = view
        presenter.weather(nil)
        XCTAssertFalse(view.reloadCalled, "View reload shouldn't get called")
    }

    func testWeatherResults() {
        let expectation = self.expectation(description: "reload expectation")
        view.expectation = expectation
        presenter.view = view
        presenter.weather([])
        waitForExpectations(timeout: 0.5, handler: nil)
        XCTAssertTrue(view.reloadCalled, "View reload should get called")
        XCTAssertTrue(view.stopActivityCalled,"Activity indicator should have been stopped")
    }

    func testNavigationTitle() {
        let searchLocation = "Location"
        presenter.searchLocation = searchLocation
        XCTAssertTrue(presenter.navigationTitle() == searchLocation, "Search location is not as expected")
    }

    class MockInteractor: WeatherInteractorInput {
        var weatherFetcherCalled = false

        func fetchWeather(for _: String) {
            weatherFetcherCalled = true
        }
    }

    class MockViewController: WeatherViewInput {
        var showErrorCalled = false
        var reloadCalled = false
        var startActivityCalled = false
        var stopActivityCalled = false
        var expectation: XCTestExpectation?
        

        func reset() {
            showErrorCalled = false
            reloadCalled = false
            startActivityCalled = false
            stopActivityCalled = false
            expectation = nil
        }
        
        func reload() {
            reloadCalled = true
            expectation?.fulfill()
        }

        func show(error _: NSError) {
            showErrorCalled = true
            expectation?.fulfill()
        }

        func setupInitialState() {
        }

        func startActivityIndicator() {
            startActivityCalled = true
        }

        func stopActivityIndicator() {
            stopActivityCalled = true
        }
    }
}
