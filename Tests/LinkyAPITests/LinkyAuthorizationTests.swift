//
//  LinkyAuthorizationTests.swift
//  LinkyAPITests
//
//  Created by Karim Angama on 20/06/2023.
//

import XCTest
@testable import LinkyAPI

final class LinkyAuthorizationTests: XCTestCase {
    
    let clientId = "832d-451c-9005"
    let clientSecret = "AfGT8-4f6d-a345-1208"
    
    var linkyConfig: LinkyConfiguration!

    override func setUpWithError() throws {
        linkyConfig = LinkyConfiguration(
            clientId: clientId,
            clientSecret: clientSecret,
            redirectURI: URL(string: "fake.url-redirect.com")!
        )
    }

    override func tearDownWithError() throws {
        linkyConfig = nil
    }

    func testIfAccessTokenIsNotExpiredDontOpenWebView() throws {
        let exp = XCTestExpectation(description: "Success closure should be executed")

        let account = LinkyAccountMock(isAccess: true)
        let authorization = setupALinkyAuthorizationMock(account)
        
        account.setAcceesToken("azery")
        account.setUsagePointsId("azery")
        
        authorization.authorization { error in
            XCTAssertNil(error)
            exp.fulfill()
        }
        
        XCTAssertNil(authorization.authorizationBlok)
        XCTAssertFalse(authorization.isDisplayWebViewScreenIsCalled)
        
        wait(for: [exp], timeout: 3)
    }
    
    func testOpenWebViewIfAccessTokenIsExpired() throws {

        let authorization = setupALinkyAuthorizationMock(LinkyAccountMock())
        
        authorization.authorization { error in }

        XCTAssertNotNil(authorization.authorizationBlok)
        XCTAssertTrue(authorization.isDisplayWebViewScreenIsCalled)
    }
    
    func testIfWebViewError() throws {
        let exp = XCTestExpectation(description: "Success closure should be executed")
        
        let authorization = setupALinkyAuthorizationMock(LinkyAccountMock())
        
        authorization.authorization { error in
            XCTAssertNotNil(error)
            exp.fulfill()
        }
        
        authorization.handleResponse(
            usagePointsId: nil, state: nil, error: NSError(domain: "com.kangama.LinkyAPITEsts", code: 100)
        )
        
        XCTAssertTrue(authorization.isDismissScreenIsCalled)
        
        wait(for: [exp], timeout: 3)
    }
    
    func testIfStateIsNotTheSame() throws {
        let exp = XCTestExpectation(description: "Success closure should be executed")
        
        let authorization = setupALinkyAuthorizationMock(LinkyAccountMock())
        
        authorization.authorization { error in
            XCTAssertNotNil(error)
            exp.fulfill()
        }
        
        authorization.handleResponse(
            usagePointsId: nil, state: "1234", error: nil
        )
        
        XCTAssertTrue(authorization.isDismissScreenIsCalled)
        
        wait(for: [exp], timeout: 3)
    }
    
    func testIfStateIsTheSameAndUsagePointsIdIsNull() throws {
        let exp = XCTestExpectation(description: "Success closure should be executed")
        
        let authorization = setupALinkyAuthorizationMock(LinkyAccountMock())
        
        authorization.authorization { error in
            XCTAssertNotNil(error)
            exp.fulfill()
        }
        
        authorization.handleResponse(
            usagePointsId: nil, state: linkyConfig.state, error: nil
        )
        
        XCTAssertTrue(authorization.isDismissScreenIsCalled)
        
        wait(for: [exp], timeout: 3)
    }
    
    func testIfStateIsTheSameAndUsagePointsIdIsNotNullAndErrorIsNotNull() throws {

        let authorization = setupALinkyAuthorizationMock(LinkyAccountMock())
        
        authorization.authorization { error in }
        
        authorization.handleResponse(
            usagePointsId: "1234",
            state: linkyConfig.state,
            error: NSError(domain: "com.kangama.LinkyAPITEsts", code: 100)
        )
        
        XCTAssertFalse(authorization.isDismissScreenIsCalled)
        XCTAssertTrue(authorization.isHandleAccessToken)

    }
    
    func testIfStateIsTheSameAndUsagePointsIdIsNotNullAndErrorIsNull() throws {

        let account = LinkyAccountMock()
        let authorization = setupALinkyAuthorizationMock(account)
        
        authorization.authorization { error in }
        
        let usagePointsId = "1234"
        authorization.handleResponse(
            usagePointsId: usagePointsId,
            state: linkyConfig.state,
            error: nil
        )
        
        XCTAssertEqual(account.getUsagePointsId(), usagePointsId)
        XCTAssertFalse(authorization.isDismissScreenIsCalled)
        XCTAssertTrue(authorization.isHandleAccessToken)

    }
    
    func testIfTokenIsSavedAndStateIsTheSameAndUsagePointsIdIsNotNullAndErrorIsNull() throws {
        let exp = XCTestExpectation(description: "Success closure should be executed")
        
        let account = LinkyAccountMock()
        let linkyService = LinkyServiceAPIMock(
            configuration: linkyConfig,
            account: account
        )
        let authorization = LinkyAuthorizationMock(
            configuration: linkyConfig,
            account: account,
            serviceAPI: linkyService
        )
        authorization.isSuperHandleAccessToken = true
        
        let token = "1234"
        linkyService.setAccessToken(
            token: LinkyAccessTokenRaw(
                access_token: "1234",
                token_type: "Bearer",
                expires_in: 12600,
                scope: ""
            )
        )
        
        authorization.authorization { error in
            XCTAssertNil(error)
            XCTAssertEqual(account.getAcceesToken(), token)
            exp.fulfill()
        }
        
        authorization.handleResponse(
            usagePointsId: "1234",
            state: linkyConfig.state,
            error: nil
        )
        
        XCTAssertTrue(authorization.isDismissScreenIsCalled)
        wait(for: [exp], timeout: 3)

    }
    
    func testRemovePRMWhenPRMAddedIsDifferentInSandbox() {
        
        setupLinkyConfigSandbox(mode: .sandbox(prm: .client4(.prm1)))
        
        let account = LinkyAccountMock(isAccess: false)
        account.setUsagePointsId(LinkySandboxPRM.client1(.prm1).prm)
        let authorization = setupALinkyAuthorizationMock(account)
        
        XCTAssertEqual(authorization.isAccess, false)
        XCTAssertNil(account.getUsagePointsId())
        
    }
    
    func testDontRemovePRMWhenPRMAddedIsDifferentInSandbox() {
        
        let mode  = LinkyMode.sandbox(prm: .client0(.prm1))
        setupLinkyConfigSandbox(mode: mode)
        
        let account = LinkyAccountMock(isAccess: true)
        account.setUsagePointsId(mode.prm)
        let authorization = setupALinkyAuthorizationMock(account)
        
        XCTAssertEqual(authorization.isAccess, true)
        XCTAssertNotNil(account.getUsagePointsId())
        
    }
    
    private func setupLinkyConfigSandbox(mode: LinkyMode) {
        linkyConfig = LinkyConfiguration(
            clientId: clientId,
            clientSecret: clientSecret,
            redirectURI: URL(string: "fake.url-redirect.com")!,
            mode: mode
        )
    }
    
    private func setupALinkyAuthorizationMock(_ account: LinkyAccount) -> LinkyAuthorizationMock {
        let linkyService = LinkyServiceAPIMock(
            configuration: linkyConfig,
            account: account
        )
        return LinkyAuthorizationMock(
            configuration: linkyConfig,
            account: account,
            serviceAPI: linkyService
        )
    }


}
