//
//  LinKyDuration.swift
//  LinkyAPI
//
//  Created by Karim Angama on 14/06/2023.
//

import Foundation

/// Duration of consent, requested by the application. This duration will be displayed to the consumer and cannot exceed 3 years.
///
public enum LinkyDuration {
    case day(value: Int)
    case month(value: Int)
    case year(value: Int)
    
    // Return duration code in the ISO 8601 format
    internal var durationCode: String {
        get{
            switch self {
            case .day(value: let value):
                testValue(value)
                return "P\(value)D"
            case .month(value: let value):
                testValue(value)
                return "P\(value)M"
            case .year(value: let value):
                testValue(value)
                return "P\(value)Y"
            }
        }
    }
    
    // Check the duration, it cannot excedd 3 years.
    private func testValue(_ value: Int) {
        if value <= 0 {
            fatalError("LinkyDuration - The value of duration must be greater than zero.")
        } else if self == .day(value: value)  && value > 1095 {
            fatalError("LinkyDuration - The value of duration must be less than three years.")
        } else if self == .month(value: value)  && value > 36 {
            fatalError("LinkyDuration - The value of duration must be less than thirty six months.")
        } else if self == .year(value: value)  && value > 3 {
            fatalError("LinkyDuration - The value of duration must be less than three years.")
        }
    }
    
}
