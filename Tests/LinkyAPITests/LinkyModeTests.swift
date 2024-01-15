//
//  LinkyModeTests.swift
//  LinkyAPITests
//
//  Created by Karim Angama on 15/06/2023.
//

import XCTest
@testable import LinkyAPI

final class LinkyModeTests: XCTestCase {

    func testUrlSandboxEnvironment() throws {
        let mode: LinkyMode = .sandbox()
        XCTAssertEqual(mode.baseUrlEnvironment,"https://ext.prod-sandbox.api.enedis.fr")
    }
    
    func testUrlProdEnvironment() throws {
        let mode: LinkyMode = .production
        XCTAssertEqual(mode.baseUrlEnvironment,"https://ext.prod.api.enedis.fr")
    }
    
    func testUrlProdAuthorizeEnvironment() throws {
        let mode: LinkyMode = .production
        XCTAssertEqual(mode.baseUrlAuthorize,"https://mon-compte-particulier.enedis.fr")
    }
    
    func testUrlSandboxAuthorizeEnvironment() throws {
        let mode: LinkyMode = .sandbox()
        XCTAssertEqual(mode.baseUrlAuthorize,"https://mon-compte-particulier.enedis.fr")
    }

}
