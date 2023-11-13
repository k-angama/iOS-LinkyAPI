//
//  LinkyKeychainService.swift
//  LinkyAPI
//
//  Created by Karim Angama on 20/06/2023.
//

import Foundation


struct LinkyKeychainServiceDate {
    let value: String
    let creationDate: Date
}

class LinkyKeychainService: NSObject {
    
    public static func save(forKey: String, value: String) throws {
        let data: Data? = value.data(using: .utf8, allowLossyConversion: false)
        let query = [
            kSecClass as String       : kSecClassGenericPassword as String,
            kSecAttrAccount as String : forKey,
            kSecValueData as String   : data!
        ] as [String : Any]

        SecItemDelete(query as CFDictionary)

        if SecItemAdd(query as CFDictionary, nil)  != noErr {
            throw NSError()
        }
    }
    
    public static func delete(forKey: String) throws {
        
        let query = [
            kSecClass as String       : kSecClassGenericPassword as String,
            kSecAttrAccount as String : forKey,
        ] as [String : Any]
        
        if SecItemDelete(query as CFDictionary)  != noErr {
            throw NSError()
        }
        
    }
    
    public static func read(forKey: String) throws -> LinkyKeychainServiceDate? {
        let query = [
            kSecClass as String       : kSecClassGenericPassword,
            kSecAttrAccount as String : forKey,
            kSecReturnAttributes as String  : kCFBooleanTrue!,
            kSecReturnData as String  : kCFBooleanTrue!,
            kSecMatchLimit as String  : kSecMatchLimitOne
        ] as [String : Any]

        var dataTypeRef: AnyObject? = nil

        let status: OSStatus = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)
        
        let dic = dataTypeRef as? NSDictionary

        if status == noErr {
            guard let data = dic?.value(forKey: kSecValueData as String) as? Data else { return nil }
            guard let creationDate = dic?.value(forKey: kSecAttrCreationDate as String) as? Date else { return nil }
            guard let value = String(data: data, encoding: .utf8) else { return nil }
            return LinkyKeychainServiceDate(value: value, creationDate: creationDate)
        } else {
            return nil
        }
    }
    
}
