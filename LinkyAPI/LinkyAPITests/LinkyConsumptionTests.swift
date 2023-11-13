//
//  LinkyConsumptionTests.swift
//  LinkyAPITests
//
//  Created by Karim Angama on 27/07/2023.
//

import XCTest
@testable import LinkyAPI

final class LinkyConsumptionTests: XCTestCase {

    var linkyConsumption: LinkyConsumption!
    var firstDate: LinkyConsumptionDate {
        LinkyConsumptionDate(year: .year(2023), month: .month(6), day: .day(1))
    }
    var beforeDate: LinkyConsumptionDate {
        LinkyConsumptionDate(year: .year(2023), month: .month(5), day: .day(1))
    }
    var afterDate: LinkyConsumptionDate {
        LinkyConsumptionDate(year: .year(2023), month: .month(7), day: .day(1))
    }
    
    override func setUpWithError() throws {
        let account = LinkyAccountMock()
        let linkyConfig = LinkyConfiguration(
            clientId: "832d-451c-9005",
            clientSecret: "AfGT8-4f6d-a345-1208",
            redirectURI: URL(string: "fake.url-redirect.com")!
        )
        let linkyService = LinkyServiceAPIImplMock(configuration: linkyConfig, account: account)
        linkyConsumption = LinkyConsumption.shared
        linkyConsumption.linkyAPI = linkyService
    }

    override func tearDownWithError() throws {
        linkyConsumption = nil
    }

    func testDailyReturnAnErrorIfTheStartDateIsLestThanEndDate() throws {
        let exp = XCTestExpectation(description: "Success closure should be executed")
        
        linkyConsumption.daily(
            start: firstDate,
            end: beforeDate)
        { consumption, error in
            XCTAssertNil(consumption)
            XCTAssertNotNil(error)
            XCTAssertEqual(error as? LinkyAPIErro, LinkyAPIErro.dateError)
            exp.fulfill()
         }
        
        wait(for: [exp], timeout: 3)
    }
    
    func testDailyReturnNotErrorIfTheStartDateIsEqualToEndDate() throws {
        let exp = XCTestExpectation(description: "Success closure should be executed")
        
        linkyConsumption.daily(
            start: firstDate,
            end: firstDate)
        { consumption, error in
            XCTAssertNotNil(consumption)
            XCTAssertNil(error)
            exp.fulfill()
         }
        
        wait(for: [exp], timeout: 3)
    }
    
    func testDailyReturnNotErrorIfTheStartDateIsGreaterThanEndDate() throws {
        let exp = XCTestExpectation(description: "Success closure should be executed")
        
        linkyConsumption.daily(
            start: firstDate,
            end: afterDate)
        { consumption, error in
            XCTAssertNotNil(consumption)
            XCTAssertNil(error)
            exp.fulfill()
         }
        
        wait(for: [exp], timeout: 3)
    }
    
    func testLoadcurveReturnAnErrorIfTheStartDateIsLestThanEndDate() throws {
        let exp = XCTestExpectation(description: "Success closure should be executed")
        
        linkyConsumption.loadcurve(
            start: firstDate,
            end: beforeDate)
        { consumption, error in
            XCTAssertNil(consumption)
            XCTAssertNotNil(error)
            XCTAssertEqual(error as? LinkyAPIErro, LinkyAPIErro.dateError)
            exp.fulfill()
         }
        
        wait(for: [exp], timeout: 3)
    }
    
    func testLoadcurveReturnNotErrorIfTheStartDateIsEqualToEndDate() throws {
        let exp = XCTestExpectation(description: "Success closure should be executed")
        
        linkyConsumption.loadcurve(
            start: firstDate,
            end: firstDate)
        { consumption, error in
            XCTAssertNotNil(consumption)
            XCTAssertNil(error)
            exp.fulfill()
         }
        
        wait(for: [exp], timeout: 3)
    }
    
    func testLoadcurveReturnNotErrorIfTheStartDateIsGreaterThanEndDate() throws {
        let exp = XCTestExpectation(description: "Success closure should be executed")
        
        linkyConsumption.daily(
            start: firstDate,
            end: afterDate)
        { consumption, error in
            XCTAssertNotNil(consumption)
            XCTAssertNil(error)
            exp.fulfill()
         }
        
        wait(for: [exp], timeout: 3)
    }

    func testMaxpowerReturnAnErrorIfTheStartDateIsLestThanEndDate() throws {
        let exp = XCTestExpectation(description: "Success closure should be executed")
        
        linkyConsumption.maxpower(
            start: firstDate,
            end: beforeDate)
        { consumption, error in
            XCTAssertNil(consumption)
            XCTAssertNotNil(error)
            XCTAssertEqual(error as? LinkyAPIErro, LinkyAPIErro.dateError)
            exp.fulfill()
         }
        
        wait(for: [exp], timeout: 3)
    }
    
    func testMaxpowerReturnNotErrorIfTheStartDateIsEqualToEndDate() throws {
        let exp = XCTestExpectation(description: "Success closure should be executed")
        
        linkyConsumption.maxpower(
            start: firstDate,
            end: firstDate)
        { consumption, error in
            XCTAssertNotNil(consumption)
            XCTAssertNil(error)
            exp.fulfill()
         }
        
        wait(for: [exp], timeout: 3)
    }
    
    func testMaxpowerReturnNotErrorIfTheStartDateIsGreaterThanEndDate() throws {
        let exp = XCTestExpectation(description: "Success closure should be executed")
        
        linkyConsumption.maxpower(
            start: firstDate,
            end: afterDate)
        { consumption, error in
            XCTAssertNotNil(consumption)
            XCTAssertNil(error)
            exp.fulfill()
         }
        
        wait(for: [exp], timeout: 3)
    }
    
    func testDailyprodReturnAnErrorIfTheStartDateIsLestThanEndDate() throws {
        let exp = XCTestExpectation(description: "Success closure should be executed")
        
        linkyConsumption.dailyprod(
            start: firstDate,
            end: beforeDate)
        { consumption, error in
            XCTAssertNil(consumption)
            XCTAssertNotNil(error)
            XCTAssertEqual(error as? LinkyAPIErro, LinkyAPIErro.dateError)
            exp.fulfill()
         }
        
        wait(for: [exp], timeout: 3)
    }
    
    func testDailyprodReturnNotErrorIfTheStartDateIsEqualToEndDate() throws {
        let exp = XCTestExpectation(description: "Success closure should be executed")
        
        linkyConsumption.dailyprod(
            start: firstDate,
            end: firstDate)
        { consumption, error in
            XCTAssertNotNil(consumption)
            XCTAssertNil(error)
            exp.fulfill()
         }
        
        wait(for: [exp], timeout: 3)
    }
    
    func testDailyprodReturnNotErrorIfTheStartDateIsGreaterThanEndDate() throws {
        let exp = XCTestExpectation(description: "Success closure should be executed")
        
        linkyConsumption.dailyprod(
            start: firstDate,
            end: afterDate)
        { consumption, error in
            XCTAssertNotNil(consumption)
            XCTAssertNil(error)
            exp.fulfill()
         }
        
        wait(for: [exp], timeout: 3)
    }
    
    func testLoadcurveprodReturnAnErrorIfTheStartDateIsLestThanEndDate() throws {
        let exp = XCTestExpectation(description: "Success closure should be executed")
        
        linkyConsumption.loadcurveprod(
            start: firstDate,
            end: beforeDate)
        { consumption, error in
            XCTAssertNil(consumption)
            XCTAssertNotNil(error)
            XCTAssertEqual(error as? LinkyAPIErro, LinkyAPIErro.dateError)
            exp.fulfill()
         }
        
        wait(for: [exp], timeout: 3)
    }
    
    func testLoadcurveprodReturnNotErrorIfTheStartDateIsEqualToEndDate() throws {
        let exp = XCTestExpectation(description: "Success closure should be executed")
        
        linkyConsumption.loadcurveprod(
            start: firstDate,
            end: firstDate)
        { consumption, error in
            XCTAssertNotNil(consumption)
            XCTAssertNil(error)
            exp.fulfill()
         }
        
        wait(for: [exp], timeout: 3)
    }
    
    func testLoadcurveprodReturnNotErrorIfTheStartDateIsGreaterThanEndDate() throws {
        let exp = XCTestExpectation(description: "Success closure should be executed")
        
        linkyConsumption.loadcurveprod(
            start: firstDate,
            end: afterDate)
        { consumption, error in
            XCTAssertNotNil(consumption)
            XCTAssertNil(error)
            exp.fulfill()
         }
        
        wait(for: [exp], timeout: 3)
    }

}
