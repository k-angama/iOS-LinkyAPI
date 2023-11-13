//
//  Environment.swift
//  LinkyAPIExample
//
//  Created by Karim Angama on 08/11/2023.
//

import Foundation

/**
 Create your environment file (env.xcconfig) to add your variables
 
 CLIENT_ID: Unique identifier of the API consuming application
 CLIENT_SECRET: Secret unique identifier of the API consuming application
 REDIRECT_URI: Url added when activating your production environment on Enedis
 */
struct Env {
    
    struct Keys {
        static let clientID = "CLIENT_ID"
        static let clientSecret = "CLIENT_SECRET"
        static let redirectURI = "REDIRECT_URI"
    }
    
    private static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
          fatalError("Plist file not found")
        }
        return dict
      }()
    
    static let clientID: String = {
        guard let clientId = infoDictionary[Keys.clientID] as? String else {
            fatalError("CLIENT_ID not set in plist for this environment")
        }
        return clientId
    }()
    
    static let clientSecret: String = {
        guard let clientId = infoDictionary[Keys.clientSecret] as? String else {
            fatalError("CLIENT_SECRET not set in plist for this environment")
        }
        return clientId
    }()
    
    static let redirectURI: String = {
        guard let clientId = infoDictionary[Keys.redirectURI] as? String else {
            fatalError("REDIRECT_URI not set in plist for this environment")
        }
        return clientId
    }()
    
}
