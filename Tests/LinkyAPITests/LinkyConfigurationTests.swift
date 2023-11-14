//
//  LinkyConfigurationTests.swift
//  LinkyAPITests
//
//  Created by Karim Angama on 15/06/2023.
//

import XCTest
@testable import LinkyAPI

final class LinkyConfigurationTests: XCTestCase {
    
    let clientId = "832d-451c-9005"
    let clientSecret = "AfGT8-4f6d-a345-1208"

    func testDefaultConfiguration() throws {
        let config = LinkyConfiguration(
            clientId: clientId,
            clientSecret: clientSecret,
            redirectURI: URL(string: "fake.url-redirect.com")!
        )
        
        XCTAssertEqual(config.clientId, clientId)
        XCTAssertEqual(config.clientSecret, clientSecret)
        XCTAssertEqual(config.mode, .sandbox())
        XCTAssertEqual(config.duration, .year(value: 3))
    }
    
    func testValueConfiguration() throws {
        let duration: LinkyDuration = .month(value: 24)
        let config = LinkyConfiguration(
            clientId: clientId,
            clientSecret: clientSecret,
            redirectURI: URL(string: "fake.url-redirect.com")!,
            mode: .production,
            duration: duration
        )
        
        XCTAssertEqual(config.clientId, clientId)
        XCTAssertEqual(config.clientSecret, clientSecret)
        XCTAssertEqual(config.mode, .production)
        XCTAssertEqual(config.duration, duration)
    }
    
    func testUrlQuery() throws {
        let duration: LinkyDuration = .year(value: 3)
        let config = LinkyConfiguration(
            clientId: clientId,
            clientSecret: clientSecret,
            redirectURI: URL(string: "fake.url-redirect.com")!,
            duration: duration
        )
        
        XCTAssertEqual(
            config.urlQuery,
            [
                URLQueryItem(name: Constants.Config.nameClientId, value: clientId),
                URLQueryItem(name: Constants.Config.nameState, value: config.state),
                URLQueryItem(name: Constants.Config.nameDuration, value: duration.durationCode),
                URLQueryItem(name: Constants.Config.nameResponseType, value:  Constants.Config.valueResponseType),
                //URLQueryItem(name: Constants.Config.nameRedirectURI, value:  Constants.Config.valueRedirectURI),
            ]
        )
    }
    
    func testurlAuthorize() throws {

        let duration: LinkyDuration = .year(value: 3)
        let config = LinkyConfiguration(
            clientId: clientId,
            clientSecret: clientSecret,
            redirectURI: URL(string: "fake.url-redirect.com")!,
            duration: duration
        )
        
        var urlComps = URLComponents(string: "\(config.mode.baseUrlAuthorize)/dataconnect/v1/oauth2/authorize")!
        urlComps.queryItems = config.urlQuery
        
        XCTAssertEqual(config.urlAuthorize?.absoluteString, urlComps.url?.absoluteString)
        
    }

}
