//
//  LinkyConfiguration.swift
//  LinkyAPI
//
//  Created by Karim Angama on 13/06/2023.
//

import Foundation

/// Information to access API data
///
/// - Parameter clientId: Unique identifier of the API consuming application
/// - Parameter clientSecret: Secret unique identifier of the API consuming application
/// - Parameter mode: Specified environment mode for the endpoint API
/// - Parameter duration: Duration of consent
/// - Parameter redirectURI: Url added when activating your production environment on Enedis
///
public struct LinkyConfiguration {
    public let clientId: String
    public let clientSecret: String
    public let mode: LinkyMode
    public let duration: LinkyDuration
    public let redirectURI: URL
    internal let state: String = UUID().uuidString
    
    public init(
        clientId: String,
        clientSecret: String,
        redirectURI: URL,
        mode: LinkyMode = .sandbox(),
        duration: LinkyDuration = .year(value: 3)
    ) {
        self.clientId = clientId
        self.clientSecret = clientSecret
        self.mode = mode
        self.duration = duration
        self.redirectURI = redirectURI
    }
    
    internal var urlAuthorize: URL? {
        var urlComps = URLComponents(string: "\(mode.baseUrlAuthorize)/dataconnect/v1/oauth2/authorize")!
        urlComps.queryItems = urlQuery
        return urlComps.url
    }
    
    internal var urlQuery: [URLQueryItem] {
        [
            URLQueryItem(name: Constants.Config.nameClientId, value: clientId),
            URLQueryItem(name: Constants.Config.nameState, value: state),
            URLQueryItem(name: Constants.Config.nameDuration, value: duration.durationCode),
            URLQueryItem(name: Constants.Config.nameResponseType, value: Constants.Config.valueResponseType),
            //URLQueryItem(name: Constants.Config.nameRedirectURI, value: redirectURI.absoluteString),
        ]
    }
}
