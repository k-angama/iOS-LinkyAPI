//
//  LinkyAccountMock.swift
//  LinkyAPITests
//
//  Created by Karim Angama on 20/06/2023.
//

import Foundation
@testable import LinkyAPI

class LinkyAccountMock: LinkyAccount {
    
    var isAccess: Bool 
    
    var usagePointsId: String?
    var accessToken: String?
    var expireToken: Int?
    
    init(isAccess: Bool = false) {
        self.isAccess = isAccess
    }
    
    func getUsagePointsId() -> String? {
        self.usagePointsId
    }
    
    func setUsagePointsId(_ value: String) {
        self.usagePointsId = value
    }
    
    func getAcceesToken() -> String? {
        self.accessToken
    }
    
    func setAcceesToken(_ value: String) {
        self.accessToken = value
    }
    
    func getExpireAccessToken() -> Int {
        expireToken ?? 0
    }
    
    func setExpireAccessToken(_ value: Int) {
        self.expireToken = value
    }
    
    func deleteAcceesToken() {
        self.accessToken = nil
    }
    
    func deleteUsagePointsId() {
        self.usagePointsId = nil
    }
    
}
