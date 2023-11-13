//
//  LinkyConsumptionRaw.swift
//  LinkyAPI
//
//  Created by Karim Angama on 26/06/2023.
//

import Foundation


struct LinkyConsumptionRaw: Codable {
    let meter_reading: MeterReadingRaw?
}

struct MeterReadingRaw: Codable {
    let usage_point_id: String?
    let start: String?
    let end: String?
    let quality: String?
    let reading_type: LinkyConsumptionReadingTypeRaw?
    let interval_reading: [LinkyConsumptionIntervalReadingRaw]?
}

public struct LinkyConsumptionReadingTypeRaw: Codable {
    let measurement_kind: String?
    let unit: String?
    let aggregate: String?
}

struct LinkyConsumptionIntervalReadingRaw: Codable {
    let value: String?
    let date: String?
}
