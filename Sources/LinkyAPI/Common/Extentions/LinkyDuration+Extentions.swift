//
//  LinkyDuration+Extentions.swift
//  LinkyAPI
//
//  Created by Karim Angama on 04/08/2023.
//

import Foundation

extension LinkyDuration : Equatable {

    public static func == (lhs: LinkyDuration, rhs: LinkyDuration) -> Bool {
        switch (lhs, rhs) {
        case (.day(let value1), .day(let value2)):
            return value1 == value2
        case (.month(let value1), .month(let value2)):
            return value1 == value2
        case (.year(let value1), .year(let value2)):
            return value1 == value2
        default:
            return false
        }
    }
}
