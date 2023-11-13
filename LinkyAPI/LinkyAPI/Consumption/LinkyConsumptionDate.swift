//
//  LinkyConsumptionDate.swift
//  LinkyAPI
//
//  Created by Karim Angama on 26/06/2023.
//

import Foundation

/// Representing a date of consumption for the Linky Consomtion.
///
public struct LinkyConsumptionDate {
    
    private var year: LinkyConsumptionDateYear
    private var month: LinkyConsumptionDateMonth
    private var day: LinkyConsumptionDateDay
    
    internal var date: String {
        String(format: "%d-%0.2d-%0.2d", year.value, month.value, day.value)
    }
    
    /// Initializes a new instance of LinkyConsumptionDate.
    ///
    /// - Parameters:
    ///   - year: The year of consumption.
    ///   - month: The month of consumption.
    ///   - day: The day of consumption.
    ///
    public init(year: LinkyConsumptionDateYear, month: LinkyConsumptionDateMonth, day: LinkyConsumptionDateDay) {
        self.year = year
        self.month = month
        self.day = day
    }
    
}

/// Representing the year of consumption for the Linky Consomtion.
///
public enum LinkyConsumptionDateYear {
    case year(Int)
    internal var value: Int {
        switch self {
        case .year(let value):
            return value
        }
    }
}

/// Representing the month of consumption for the Linky Consomtion.
///
public enum LinkyConsumptionDateMonth {
    case month(Int)
    internal var value: Int {
        switch self {
        case .month(let value):
            return value
        }
    }
}

/// Representing the day of consumption for the Linky Consomtion.
///
public enum LinkyConsumptionDateDay {
    case day(Int)
    internal var value: Int {
        switch self {
        case .day(let value):
            return value
        }
    }
}
