//
//  LinkySessionCachedMock.swift
//  LinkyAPITests
//
//  Created by Karim Angama on 19/01/2024.
//

import Foundation
@testable import LinkyAPI

class LinkySessionCachedMock: LinkySessionCached {
    
    var expirationDuration: Int = 0
    
    override func dataTask(request: URLRequest, block: @escaping BlockDataResponse) {
        self.block = block
    }
    
    override func getExpirationDuration(_ date: Date = Date.now, _ hour: Int = 10) -> Int {
        return expirationDuration
    }
}
