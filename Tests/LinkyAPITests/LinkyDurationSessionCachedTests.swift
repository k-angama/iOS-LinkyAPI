//
//  LinkyDurationSessionCachedTests.swift
//  LinkyAPITests
//
//  Created by Karim Angama on 19/01/2024.
//

import XCTest
@testable import LinkyAPI

final class LinkyDurationSessionCachedTests: XCTestCase {

    var linkySessionCached: LinkySessionCached!

    override func setUpWithError() throws {
        linkySessionCached = LinkySessionCached()
    }

    override func tearDownWithError() throws {
        linkySessionCached = nil
    }

    func testReturn3600sIfHourIs09h() throws {
        let date = dateFormat("2024-01-01 09:00:00")
        let duration = linkySessionCached.getExpirationDuration(date, 10)
        
        XCTAssertEqual(duration, 3600)
    }
    
    func testReturn82800sIfHourIs11h() throws {
        let date = dateFormat("2024-01-01 11:00:00")
        let duration = linkySessionCached.getExpirationDuration(date, 10)
        
        XCTAssertEqual(duration, 82800)
    }
    
    func testReturn36000sIfHourIs00h() throws {
        let date = dateFormat("2024-01-01 00:00:00")
        let duration = linkySessionCached.getExpirationDuration(date, 10)
        
        XCTAssertEqual(duration, 36000)
    }
    
    func testReturn43200sIfHourIs22h() throws {
        let date = dateFormat("2024-01-01 22:00:00")
        let duration = linkySessionCached.getExpirationDuration(date, 10)
        
        XCTAssertEqual(duration, 43200)
    }
    
    private func dateFormat(_ value: String) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
        return formatter.date(from: value)!
    }

}
