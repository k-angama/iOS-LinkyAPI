//
//  LinkyAuthorizationErrorTests.swift
//  LinkyAPITests
//
//  Created by Karim Angama on 26/06/2023.
//

import XCTest
@testable import LinkyAPI

final class LinkyAuthorizationErrorTests: XCTestCase {

    func testRawValue() throws {
        XCTAssertEqual(LinkyAuthorizationError(rawValue: LinkyAuthorizationError.badRequest.rawValue), .badRequest)
        XCTAssertEqual(LinkyAuthorizationError(rawValue: LinkyAuthorizationError.forbidden.rawValue), .forbidden)
        XCTAssertEqual(LinkyAuthorizationError(rawValue: LinkyAuthorizationError.internalServerError.rawValue), .internalServerError)
        XCTAssertEqual(LinkyAuthorizationError(rawValue: LinkyAuthorizationError.technicalError.rawValue), .technicalError)
        XCTAssertEqual(LinkyAuthorizationError(rawValue: LinkyAuthorizationError.apiError.rawValue), .apiError)
        XCTAssertEqual(LinkyAuthorizationError(rawValue: LinkyAuthorizationError.stateAuthorization.rawValue), .stateAuthorization)
        XCTAssertEqual(LinkyAuthorizationError(rawValue: LinkyAuthorizationError.authorization.rawValue), .authorization)
    }
    
    func testRawValueNotExiste() throws {
        XCTAssertEqual(LinkyAuthorizationError(rawValue: 1001), .apiError)
        XCTAssertEqual(LinkyAuthorizationError(rawValue: 100), .apiError)
        XCTAssertEqual(LinkyAuthorizationError(rawValue: 2001), .apiError)
    }

}
