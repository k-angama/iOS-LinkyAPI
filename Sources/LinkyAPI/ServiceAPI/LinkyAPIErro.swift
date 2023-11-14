//
//  LinkyAPIErro.swift
//  LinkyAPI
//
//  Created by Karim Angama on 29/06/2023.
//

import Foundation

enum LinkyAPIErro: Int, Error {
    case userNotOwner = 403
    case invalidRequest = 400
    case technicalException = 500
    case unauthorizedUser = 404
    case quotaReached = 429
    case apiError = 701
    case dateError =  800
    
    public init(rawValue: Int) {
        switch rawValue {
        case 403: self = .userNotOwner
        case 400: self = .invalidRequest
        case 500: self = .technicalException
        case 404: self = .unauthorizedUser
        case 429: self = .quotaReached
        case 800: self = .dateError
        default:
            self = .apiError
        }
    }
}
