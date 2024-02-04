//
//  Mock.swift
//  LinkyAPITests
//
//  Created by Karim Angama on 29/01/2024.
//

import Foundation

// MARK: - Error

enum ErrorMock: Int, Error  {
    case valueNotSet
}

extension NSError {
    static var test: NSError {
        return NSError(domain: "test", code: 0, userInfo: [NSLocalizedDescriptionKey: "Test error"])
    }
}
