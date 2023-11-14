//
//  LinkyAccessToken.swift
//  LinkyAPI
//
//  Created by Karim Angama on 22/06/2023.
//

import Foundation

struct LinkyAccessTokenRaw: Codable {
    let access_token: String?
    let token_type: String?
    let expires_in: Int?
    let scope: String?
}
