//
//  LinkyAccessTokenMapper.swift
//  LinkyAPI
//
//  Created by Karim Angama on 26/06/2023.
//

import Foundation

struct LinkyAccessTokenMapper {
    static func rawToEntity(raw: LinkyAccessTokenRaw) -> LinkyAccessTokenEntity {
        LinkyAccessTokenEntity(
            accessToken: raw.access_token ?? "",
            tokenType: raw.token_type ?? "",
            expiresIn: raw.expires_in ?? 0,
            scope: raw.scope ?? ""
        )
    }
}
