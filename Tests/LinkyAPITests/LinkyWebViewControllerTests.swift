//
//  WebViewController.swift
//  LinkyAPITests
//
//  Created by Karim Angama on 19/06/2023.
//

import XCTest
@testable import LinkyAPI
import WebKit

final class LinkyWebViewControllerTests: XCTestCase {
    
    let clientId = "832d-451c-9005"
    let clientSecret = "AfGT8-4f6d-a345-1208"
    
    var webViewController: LinkyWebViewController!
    var linkyConfig: LinkyConfiguration!
    var accountMock: LinkyAccount!

    override func setUpWithError() throws {
        linkyConfig = LinkyConfiguration(
            clientId: clientId,
            clientSecret: clientSecret,
            redirectURI: URL(string: "fake.url-redirect.com")!,
            mode: .production
        )
        accountMock = LinkyAccountMock()
    }

    override func tearDownWithError() throws {
        webViewController = nil
        linkyConfig = nil
        accountMock = nil
    }

    func testWhenIndicatorViewIsDisplayed() throws {
   
        webViewController = LinkyWebViewController(configuration: linkyConfig, account: accountMock) { usagePointsId, state, error in }
        webViewController.loadView()
        
        XCTAssertEqual(webViewController.indicator.isAnimating, true)
        
        webViewController.webView(webViewController.webView, didFinish: webViewController.webView.reload())

        XCTAssertEqual(webViewController.indicator.isAnimating, false)
        
    }
    
    func testResponsePolicyWhenStatusCodeIs200AndCallbackUrlNotCalled() throws {
        
        let exp = XCTestExpectation(description: "Success closure should be executed")

        webViewController = LinkyWebViewController(configuration: linkyConfig, account: accountMock) { usagePointsId, state, error in }
        let response = HTTPURLResponse(
            url: URL(string: "fake.url-redirect.com")!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )!
        webViewController.handleWebViewResponse(response) { navigationResponsePolicy in
            XCTAssertEqual(navigationResponsePolicy, .allow)
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 3)
        
    }
    
    func testResponsePolicyWhenStatusCodeReturnAnErrorAndCallbackUrlNotCalled() throws {
        
        let exp = XCTestExpectation(description: "Success closure should be executed")
        exp.expectedFulfillmentCount = 2
        
        webViewController = LinkyWebViewController(configuration: linkyConfig, account: accountMock) { usagePointsId, state, error in
            let error = error as! LinkyAuthorizationError
            XCTAssertEqual(error, LinkyAuthorizationError.badRequest)
            XCTAssertEqual(usagePointsId, nil)
            XCTAssertEqual(state, nil)
            exp.fulfill()
        }
        let response = HTTPURLResponse(
            url: URL(string: "fake.url-redirect.com")!,
            statusCode: 400,
            httpVersion: nil,
            headerFields: nil
        )!
        webViewController.handleWebViewResponse(response) { navigationResponsePolicy in
            XCTAssertEqual(navigationResponsePolicy, .cancel)
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 3)
        
    }
    
    func testResponsePolicyWhenStatusCodeReturnAnErrorAndCallbackUrlIsCalled() throws {
        
        let exp = XCTestExpectation(description: "Success closure should be executed")
        exp.expectedFulfillmentCount = 2
        webViewController = LinkyWebViewController(configuration: linkyConfig, account: accountMock) { usagePointsId, state, error in
            let error = error as! LinkyAuthorizationError
            XCTAssertEqual(error, LinkyAuthorizationError.technicalError)
            XCTAssertEqual(usagePointsId, nil)
            XCTAssertEqual(state, nil)
            exp.fulfill()
        }
        
        let response = HTTPURLResponse(
            url: URL(string: "http://\(linkyConfig.redirectURI)?code=azert&state=\(linkyConfig.state)")!,
            statusCode: 503,
            httpVersion: nil,
            headerFields: nil
        )!
        webViewController.handleWebViewResponse(response) { navigationResponsePolicy in
            XCTAssertEqual(navigationResponsePolicy, .cancel)
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 3)
        
    }
    
    func testResponsePolicyWhenStatusCodeReturnAnOtherErrorAPI() throws {
        
        let exp = XCTestExpectation(description: "Success closure should be executed")
        exp.expectedFulfillmentCount = 2
        webViewController = LinkyWebViewController(configuration: linkyConfig, account: accountMock) { usagePointsId, state, error in
            let error = error as! LinkyAuthorizationError
            XCTAssertEqual(error, LinkyAuthorizationError.apiError)
            exp.fulfill()
        }
        let response = HTTPURLResponse(
            url: URL(string: "fake.url-redirect.com")!,
            statusCode: 504,
            httpVersion: nil,
            headerFields: nil
        )!
        webViewController.handleWebViewResponse(response) { navigationResponsePolicy in
            XCTAssertEqual(navigationResponsePolicy, .cancel)
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 3)
        
    }
    
    func testResponsePolicyWhenStatusCodeReturn200AndCallbackUrlIsCalled() throws {
        
        let pointsId = "5757GF6457G"
        let exp = XCTestExpectation(description: "Success closure should be executed")
        exp.expectedFulfillmentCount = 2
        webViewController = LinkyWebViewController(configuration: linkyConfig, account: accountMock) { [weak self] usagePointsId, state, error in
            let error = error as? LinkyAuthorizationError
            XCTAssertEqual(error, nil)
            XCTAssertEqual(usagePointsId, pointsId)
            XCTAssertEqual(state, self?.linkyConfig.state)
            exp.fulfill()
        }
        
        let response = HTTPURLResponse(
            url: URL(string: "http://\(linkyConfig.redirectURI)?code=azert&state=\(linkyConfig.state)&usage_point_id=\(pointsId)")!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )!
        webViewController.handleWebViewResponse(response) { navigationResponsePolicy in
            XCTAssertEqual(navigationResponsePolicy, .cancel)
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 3)
        
    }
    
    func testResponsePolicyWhenStatusCodeReturn200AndCallbackUrlIsCalledButNotParams() throws {
        
        let exp = XCTestExpectation(description: "Success closure should be executed")
        exp.expectedFulfillmentCount = 2
        webViewController = LinkyWebViewController(configuration: linkyConfig, account: accountMock) { usagePointsId, state, error in
            let error = error as? LinkyAuthorizationError
            XCTAssertEqual(error, LinkyAuthorizationError.apiError)
            XCTAssertEqual(usagePointsId, nil)
            XCTAssertEqual(state, nil)
            exp.fulfill()
        }
        
        let response = HTTPURLResponse(
            url: URL(string: "http://\(linkyConfig.redirectURI)")!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )!
        webViewController.handleWebViewResponse(response) { navigationResponsePolicy in
            XCTAssertEqual(navigationResponsePolicy, .cancel)
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 3)
    }
    
    func testWhenCodeHaveBeenSaved() throws {
        
        let pointsId = "azert"
        let exp = XCTestExpectation(description: "Success closure should be executed")
        accountMock.setUsagePointsId(pointsId)
        webViewController = LinkyWebViewController(configuration: linkyConfig, account: accountMock) { [weak self] usagePointsId, state, error in
            let error = error as? LinkyAuthorizationError
            XCTAssertEqual(error, nil)
            XCTAssertEqual(usagePointsId, pointsId)
            XCTAssertEqual(state, self?.linkyConfig.state)
            exp.fulfill()
        }
        webViewController.viewDidLoad()
        
        wait(for: [exp], timeout: 3)
    }
    
    func testResponsePolicyWhenStatusCodeReturn200AndCallbackUrlIsCalledInSandbox() throws {
        
        let linkyConfig = LinkyConfiguration(
            clientId: clientId,
            clientSecret: clientSecret,
            redirectURI: URL(string: "fake.url-redirect.com")!,
            mode: .sandbox(prm: .client1(.prm1))
        )
        
        var pointsId: String = ""
        switch linkyConfig.mode {
        case .production:
            break
        case .sandbox(prm: let prm):
            pointsId = prm.prm
        }
        
        let exp = XCTestExpectation(description: "Success closure should be executed")
        exp.expectedFulfillmentCount = 2
        webViewController = LinkyWebViewController(configuration: linkyConfig, account: accountMock) { usagePointsId, state, error in
            let error = error as? LinkyAuthorizationError
            XCTAssertEqual(error, nil)
            XCTAssertEqual(usagePointsId, pointsId)
            XCTAssertEqual(state, linkyConfig.state)
            exp.fulfill()
        }
        
        let response = HTTPURLResponse()
        webViewController.handleWebViewResponse(response) { navigationResponsePolicy in
            XCTAssertEqual(navigationResponsePolicy, .cancel)
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 3)
        
    }
    
    func testInvalidRedirectURL() throws {
        
        let linkyConfig = LinkyConfiguration(
            clientId: clientId,
            clientSecret: clientSecret,
            redirectURI: URL(string: "fake://")!,
            mode: .sandbox(prm: .client1(.prm1))
        )

        webViewController = LinkyWebViewController(
            configuration: linkyConfig,
            account: accountMock,
            block: { usagePointsId, state, error in })
        
        expectFatalError(expectedMessage: "LinkyAPI - Redirect URI format is invalid") {
            self.webViewController.handleWebViewResponse(HTTPURLResponse()) { navigationResponsePolicy in
                //
            }
        }
        
    }

}
