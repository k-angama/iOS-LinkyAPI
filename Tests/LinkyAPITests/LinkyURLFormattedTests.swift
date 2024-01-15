//
//  LinkyURLFormatted.swift
//  LinkyAPITests
//
//  Created by Karim Angama on 12/01/2024.
//

import XCTest
@testable import LinkyAPI

final class LinkyURLFormattedTests: XCTestCase {

    func testURLFormattedWithHostAndPath() throws {
        let url = URL(string: "https://fake.url-redirect.com/test/")?.formatted()
        XCTAssertEqual(url?.absoluteString, "https://fake.url-redirect.com/test/")
    }
    
    func testURLFormattedWithHost() throws {
        let url = URL(string: "https://fake.url-redirect.com")?.formatted()
        XCTAssertEqual(url?.absoluteString, "https://fake.url-redirect.com")
    }
    
    func testURLFormattedWithoutHost() throws {
        let url = URL(string: "fake.url-redirect.com")?.formatted()
        XCTAssertEqual(url?.absoluteString, "https://fake.url-redirect.com")
    }
    
    func testInvalidURLFormatted() throws {
        let url = URL(string: "monApp://")?.formatted()
        XCTAssertEqual(url?.absoluteString, nil)
    }

}
