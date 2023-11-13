//
//  LinkyDurationTests.swift
//  LinkyAPITests
//
//  Created by Karim Angama on 15/06/2023.
//

import XCTest
@testable import LinkyAPI

final class LinkyDurationTests: XCTestCase {

    func testFormatDurationDay() throws {
        let days = 40
        let duration: LinkyDuration = .day(value: days)
        XCTAssertEqual(duration.durationCode, "P\(days)D")
    }
    
    func testFormatDurationMonth() throws {
        let months = 24
        let duration: LinkyDuration = .month(value: months)
        XCTAssertEqual(duration.durationCode, "P\(months)M")
    }
    
    func testFormatDurationYear() throws {
        let years = 3
        let duration: LinkyDuration = .year(value: years)
        XCTAssertEqual(duration.durationCode, "P\(years)Y")
    }
    
    func testFatalErrorIfTheValueOfFormatDurationDayIsZero() throws {
        let day = 0
        let duration: LinkyDuration = .day(value: day)
        expectFatalError(expectedMessage: "LinkyDuration - The value of duration must be greater than zero.") {
            _ = duration.durationCode
        }
    }
    
    func testFatalErrorIfTheValueOfFormatDurationDayIsLessThanZero() throws {
        let day = -1
        let duration: LinkyDuration = .day(value: day)
        expectFatalError(expectedMessage: "LinkyDuration - The value of duration must be greater than zero.") {
            _ = duration.durationCode
        }
    }
    
    func testFatalErrorIfTheValueOfFormatDurationMonthIsZero() throws {
        let month = 0
        let duration: LinkyDuration = .month(value: month)
        expectFatalError(expectedMessage: "LinkyDuration - The value of duration must be greater than zero.") {
            _ = duration.durationCode
        }
    }
    
    func testFatalErrorIfTheValueOfFormatDurationMonthIsLessThanZero() throws {
        let month = -1
        let duration: LinkyDuration = .month(value: month)
        expectFatalError(expectedMessage: "LinkyDuration - The value of duration must be greater than zero.") {
            _ = duration.durationCode
        }
    }
    
    func testFatalErrorIfTheValueOfFormatDurationYearIsZero() throws {
        let year = 0
        let duration: LinkyDuration = .year(value: year)
        expectFatalError(expectedMessage: "LinkyDuration - The value of duration must be greater than zero.") {
            _ = duration.durationCode
        }
    }
    
    func testFatalErrorIfTheValueOfFormatDurationYearIsLessThanZero() throws {
        let year = -1
        let duration: LinkyDuration = .year(value: year)
        expectFatalError(expectedMessage: "LinkyDuration - The value of duration must be greater than zero.") {
            _ = duration.durationCode
        }
    }
    
    func testFatalErrorIfTheValueOfFormatDurationYearIsGreaterThanThree() throws {
        let years = 4
        let duration: LinkyDuration = .year(value: years)
        expectFatalError(expectedMessage: "LinkyDuration - The value of duration must be less than three years.") {
            _ = duration.durationCode
        }
    }
    
    func testIfTheValueOfFormatDurationMonthIsGreaterThan36() throws {
        let months = 37
        let duration: LinkyDuration = .month(value: months)
        expectFatalError(expectedMessage: "LinkyDuration - The value of duration must be less than thirty six months.") {
            _ = duration.durationCode
        }
    }
    
    func testIfTheValueOfFormatDurationDayIsGreaterThan1095() throws {
        let days = 1096
        let duration: LinkyDuration = .day(value: days)
        expectFatalError(expectedMessage: "LinkyDuration - The value of duration must be less than three years.") {
            _ = duration.durationCode
        }
    }

}
