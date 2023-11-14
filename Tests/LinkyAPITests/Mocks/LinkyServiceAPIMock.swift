//
//  LinkyServiceAPIMock.swift
//  LinkyAPITests
//
//  Created by Karim Angama on 20/06/2023.
//

import Foundation
@testable import LinkyAPI

class LinkyServiceAPIMock: LinkyAPI {

    var account:LinkyAccount
    var configuration: LinkyConfiguration
    var accessToken: LinkyAccessTokenRaw?
    var accessTokenError: Error?
    
    required init(configuration: LinkyConfiguration, account: LinkyAccount) {
        self.configuration = configuration
        self.account = account
    }
    
    func getAccessToken() -> LinkyAccessTokenRaw? {
        accessToken
    }
    func setAccessToken(token: LinkyAccessTokenRaw) {
        self.accessToken = token
    }
    
    func getErrorAccessToken() -> Error? {
        accessTokenError
    }
    func setErrorAccessToken(error: Error) {
        self.accessTokenError = error
    }
    
    func accessToken(block: @escaping (LinkyAccessTokenRaw?, Error?) -> Void) {
        block(accessToken, accessTokenError)
    }
    
    func consumption(start: String, end: String, route: LinkyAPIRoute, block: @escaping (LinkyConsumptionRaw?, Error?) -> Void) {
        //
    }
    
}
