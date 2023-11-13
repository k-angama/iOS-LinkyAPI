//
//  XCTestCase+Extentions.swift
//  LinkyAPITests
//
//  Created by Karim Angama on 15/06/2023.
//

import XCTest
@testable import LinkyAPI

// Extention for Unit Test fatalError in Swift
// Check out https://stackoverflow.com/a/68496755/2820064
//
extension XCTestCase {
    func expectFatalError(expectedMessage: String, testcase: @escaping () -> Void) {

        // arrange
        let expectation = self.expectation(description: "expectingFatalError")
        var assertionMessage: String? = nil

        // override fatalError. This will terminate thread when fatalError is called.
        FatalErrorUtil.replaceFatalError { message, _, _ in
            DispatchQueue.main.async {
                assertionMessage = message
                expectation.fulfill()
            }
            // Terminate the current thread after expectation fulfill
            Thread.exit()
            // Since current thread was terminated this code never be executed
            fatalError("It will never be executed")
        }

        // act, perform on separate thread to be able terminate this thread after expectation fulfill
        Thread(block: testcase).start()
        
        waitForExpectations(timeout: 0.1) { _ in
            // assert
            XCTAssertEqual(assertionMessage, expectedMessage)

            // clean up
            FatalErrorUtil.restoreFatalError()
        }
    }
}
