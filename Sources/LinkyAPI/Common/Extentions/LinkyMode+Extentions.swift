//
//  LinkyMode+Extentions.swift
//  LinkyAPI
//
//  Created by Karim Angama on 04/08/2023.
//

import Foundation

extension LinkyMode : Equatable {

    public static func == (lhs: LinkyMode, rhs: LinkyMode) -> Bool {
        switch (lhs, rhs) {
        case (.sandbox(let value1), .sandbox(let value2)):
            return value1.prm == value2.prm
        case (.production, .production):
            return true
        default:
            return false
        }
    }
}
