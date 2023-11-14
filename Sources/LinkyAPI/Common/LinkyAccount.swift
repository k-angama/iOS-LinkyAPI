//
//  LinkyAccount.swift
//  LinkyAPI
//
//  Created by Karim Angama on 20/06/2023.
//

import Foundation

protocol LinkyAccount {
    var isAccess: Bool { get }
    func getUsagePointsId() -> String?
    func setUsagePointsId(_ value: String)
    func getAcceesToken() -> String?
    func setAcceesToken(_ value: String)
    func getExpireAccessToken() -> Int
    func setExpireAccessToken(_ value: Int)
    func deleteAcceesToken()
    func deleteUsagePointsId()
}

struct LinkyAccountImpl: LinkyAccount {
    
    struct Keys {
        static let accessToken = "com.kangama.LinkyAPI-token"
        static let usagePointsId  = "com.kangama.LinkyAPI-usage-point-id"
        static let accessTokenExpiresIn  = "com.kangama.token-expires-in"
    }
    
    var isAccess: Bool {
        get {
            getUsagePointsId() != nil && getAcceesToken() != nil
        }
    }
    
    func getUsagePointsId() -> String? {
        try? LinkyKeychainService.read(forKey: Keys.usagePointsId)?.value
    }
    func setUsagePointsId(_ value: String) {
       try? LinkyKeychainService.save(forKey: Keys.usagePointsId, value: value)
    }
    func deleteUsagePointsId() {
        try? LinkyKeychainService.delete(forKey: Keys.usagePointsId)
    }
    
    func getAcceesToken() -> String? {
        try? LinkyKeychainService.read(forKey: Keys.accessToken)?.value
    }
    func setAcceesToken(_ value: String) {
       try? LinkyKeychainService.save(forKey: Keys.accessToken, value: value)
    }
    
    func getCreationDateAccessToken() -> Date? {
        try? LinkyKeychainService.read(forKey: Keys.accessToken)?.creationDate
    }
    func deleteAcceesToken() {
        try? LinkyKeychainService.delete(forKey: Keys.accessToken)
    }
    
    func isAccessTokenExpired() -> Bool {
        guard let creationDate = getCreationDateAccessToken(),
              let dateExpired = Calendar.current.date(
                byAdding: .second,
                value: getExpireAccessToken(),
                to: creationDate
              )
        else { return false }
        return dateExpired < Date.now
    }
    
    func getExpireAccessToken() -> Int {
        UserDefaults.standard.integer(forKey: Keys.accessTokenExpiresIn)
    }
    func setExpireAccessToken(_ value: Int) {
        UserDefaults.standard.set(value, forKey:Keys.accessTokenExpiresIn)
    }
    
}
