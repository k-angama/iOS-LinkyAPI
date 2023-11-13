//
//  LinkyAccessTokenEntity.swift
//  LinkyAPI
//
//  Created by Karim Angama on 26/06/2023.
//

import Foundation

struct LinkyAccessTokenEntity: Codable {
    let accessToken: String
    let tokenType: String
    let expiresIn: Int
    let scope: String
}
