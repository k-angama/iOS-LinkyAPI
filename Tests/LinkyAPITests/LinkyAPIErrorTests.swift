//
//  LinkyAPIErrorTests.swift
//  LinkyAPITests
//
//  Created by Karim Angama on 11/07/2023.
//

import XCTest
@testable import LinkyAPI

final class LinkyAPIErrorTests: XCTestCase {

    func testRawValue() throws {
        XCTAssertEqual(LinkyAPIErro(rawValue: LinkyAPIErro.userNotOwner.rawValue), .userNotOwner)
        XCTAssertEqual(LinkyAPIErro(rawValue: LinkyAPIErro.invalidRequest.rawValue), .invalidRequest)
        XCTAssertEqual(LinkyAPIErro(rawValue: LinkyAPIErro.technicalException.rawValue), .technicalException)
        XCTAssertEqual(LinkyAPIErro(rawValue: LinkyAPIErro.unauthorizedUser.rawValue), .unauthorizedUser)
        XCTAssertEqual(LinkyAPIErro(rawValue: LinkyAPIErro.quotaReached.rawValue), .quotaReached)
        XCTAssertEqual(LinkyAPIErro(rawValue: LinkyAPIErro.apiError.rawValue), .apiError)
        XCTAssertEqual(LinkyAPIErro(rawValue: LinkyAPIErro.dateError.rawValue), .dateError)
    }

    func testRawValueNotExiste() throws {
        XCTAssertEqual(LinkyAPIErro(rawValue: 1001), .apiError)
        XCTAssertEqual(LinkyAPIErro(rawValue: 100), .apiError)
        XCTAssertEqual(LinkyAPIErro(rawValue: 2001), .apiError)
    }

}
