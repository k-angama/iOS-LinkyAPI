//
//  LinkyConsumptionEntity.swift
//  LinkyAPI
//
//  Created by Karim Angama on 26/06/2023.
//

import Foundation


public struct LinkyConsumptionEntity: Codable {
    public let meterReading: MeterReadingEntity
}

public struct MeterReadingEntity: Codable {
    public let usagePointId: String
    public let start: Date
    public let end: Date
    public let quality: String
    public let readingType: LinkyConsumptionReadingTypeEntity
    public let intervalReading: [LinkyConsumptionIntervalReadingEntity]
}

public struct LinkyConsumptionReadingTypeEntity: Codable {
    public let measurementKind: String
    public let unit: String
    public let aggregate: String
}

public struct LinkyConsumptionIntervalReadingEntity: Codable {
    public let value: String
    public let date: Date
}
