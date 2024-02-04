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
    var accessTokenError: Error? = ErrorMock.valueNotSet
    
    var customerRaw: LinkyCustomerRaw?
    var customerError: Error? = ErrorMock.valueNotSet
    
    var consumptionRaw: LinkyConsumptionRaw?
    var consumptionError: Error? = ErrorMock.valueNotSet
    
    required init(configuration: LinkyConfiguration, account: LinkyAccount) {
        self.configuration = configuration
        self.account = account
    }
    
    func accessToken(block: @escaping (LinkyAccessTokenRaw?, Error?) -> Void) {
        block(accessToken, accessTokenError)
    }
    
    func consumption(start: String, end: String, route: LinkyAPIRoute, block: @escaping (LinkyConsumptionRaw?, Error?) -> Void) {
        block(consumptionRaw, consumptionError)
    }
    
    func customer(route: LinkyAPIRoute, block: @escaping (LinkyCustomerRaw?, Error?) -> Void) { 
        block(customerRaw, customerError)
    }
    
}
