//
//  LinkyServiceAPITests.swift
//  LinkyAPITests
//
//  Created by Karim Angama on 24/06/2023.
//

import XCTest
@testable import LinkyAPI

final class LinkyServiceAPITests: XCTestCase {
    
    var service: LinkyServiceAPIImplMock!
    var url: URL!

    override func setUpWithError() throws {
        
        let account = LinkyAccountMock()
        let linkyConfig = LinkyConfiguration(
            clientId: "832d-451c-9005",
            clientSecret: "AfGT8-4f6d-a345-1208",
            redirectURI: URL(string: "fake.url-redirect.com")!
        )
        service = LinkyServiceAPIImplMock(
            configuration: linkyConfig, 
            account: account
        )
        url = URL(string: "http://fake.url.com\(LinkyAPIRoute.dailyConsumption)")!
        
    }

    override func tearDownWithError() throws {
        service = nil
        url = nil
    }

    func testDataTaskInterceptTokenResponseWhenTokenIsInvalid() throws {
        let exp = XCTestExpectation(description: "Success closure should be executed")
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer 1234", forHTTPHeaderField: "Authorization")
        let response = HTTPURLResponse(url: url, statusCode: 401, httpVersion: nil, headerFields: nil)
        let data = "{}".data(using: .utf8)
        
        service.dataTaskInterceptTokenResponse(with: request, response: response, data: data, error: nil) { (entity: LinkyConsumptionRaw?, error: Error?) in
            XCTAssertNotNil(entity)
            XCTAssertNil(error)
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 3)
    }
    
    func testDataTaskResponseWhenDataAndErrorIsNullAndStatusCodeIsValid() throws {
        let exp = XCTestExpectation(description: "Success closure should be executed")
        
        let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)
        
        service.dataTaskResponse(response: response, data: nil, error: nil, intercepResponse: nil) { (entity: LinkyConsumptionRaw?, error: Error?) in
            XCTAssertNil(entity)
            XCTAssertNotNil(error)
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 3)
    }
    
    func testDataTaskResponseWhenDataAndErrorIsNullAndStatusCodeIsNotValid() throws {
        let exp = XCTestExpectation(description: "Success closure should be executed")
        
        let response = HTTPURLResponse(url: url, statusCode: 400, httpVersion: nil, headerFields: nil)
        
        service.dataTaskResponse(response: response, data: nil, error: nil, intercepResponse: nil) { (entity: LinkyConsumptionRaw?, error: Error?) in
            XCTAssertNil(entity)
            XCTAssertNotNil(error)
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 3)
    }


}
