//
//  LinkyAuthorizationError.swift
//  LinkyAPI
//
//  Created by Karim Angama on 26/06/2023.
//

import Foundation

/// Indicates the API errors returned by the authorization request
/// 
public enum LinkyAuthorizationError: Int, Error {
    case badRequest = 400
    case forbidden = 403
    case internalServerError = 500
    case technicalError = 503
    case apiError = 600
    case stateAuthorization = 700
    case authorization = 701
    
    public init(rawValue: Int) {
        switch rawValue {
        case 400: self = .badRequest
        case 403: self = .forbidden
        case 500: self = .internalServerError
        case 503: self = .technicalError
        case 700: self = .stateAuthorization
        case 701: self = .authorization
        default:
            self = .apiError
        }
    }
    
}
