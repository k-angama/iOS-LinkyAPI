//
//  LinkyMode.swift
//  LinkyAPI
//
//  Created by Karim Angama on 13/06/2023.
//

import Foundation

/// Specified environment mode for the endpoint API, production or sandbox.
///
public enum LinkyMode {
    case production
    case sandbox(prm: LinkySandboxPRM =  .client0(.prm1))
    
    internal var baseUrlEnvironment: String {
        switch self {
        case .production:
            return "https://ext.prod.api.enedis.fr"
        case .sandbox:
            return "https://ext.prod-sandbox.api.enedis.fr"
        }
    }
    
    internal var baseUrlAuthorize: String {
        return "https://mon-compte-particulier.enedis.fr"
    }
    
    internal var prm: String {
        switch self {
        case .sandbox(let value):
            switch value {
            case .client0(let prm):
                return prm.rawValue
            case .client1(let prm):
                return prm.rawValue
            case .client2(let prm):
                return prm.rawValue
            case .client3(let prm):
                return prm.rawValue
            case .client4(let prm):
                return prm.rawValue
            case .client5(let prm):
                return prm.rawValue
            case .client6(let prm):
                return prm.rawValue
            case .client7(let prm):
                return prm.rawValue
            case .client8(let prm):
                return prm.rawValue
            }
        default:
            return ""
        }
    }

}
